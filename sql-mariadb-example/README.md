# MariaDB Übungsprojekt

## Schritte zum Starten

> Zuerst die `.env`-Datei im Root-Ordner anlegen:
```
MARIADB_DATABASE=ticket_system
MARIADB_ROOT_PASSWORD=root
```

1. **Docker Setup** – `docker-compose.yml` wurde erstellt mit:
   - `env_file` – Umgebungsvariablen für die DB-Verbindung
   - `volumes` – Persistentes Datenvolume + Init-Skripte
     - `./init:/docker-entrypoint-initdb.d/` – MariaDB führt alle `.sql`-Dateien in diesem Ordner beim ersten Start alphabetisch aus
   - `ports` – Port-Mapping für externen Zugriff (3307 → 3306)
   - `healthcheck` – Regelmäßige Verfügbarkeitsprüfung

2. **Container starten:**
   ```bash
   docker compose up -d --build
   ```
   Alle Init-Skripte werden automatisch ausgeführt. Der **root**-Benutzer wird automatisch durch MariaDB gesetzt.

> **Wichtig:** Die Init-Skripte laufen nur, wenn das Volume leer ist (erster Start).
> Nach Änderungen an den SQL-Dateien muss das Volume gelöscht werden:
> ```bash
> docker compose down
> rm -r ./volumes
> docker compose up -d --build
> ```

---

## Datenbankstruktur (`init/`)

Die Initialisierung ist in drei nummerierte Dateien aufgeteilt, die MariaDB alphabetisch ausführt:

| Datei | Inhalt |
|---|---|
| `01_schema.sql` | Datenbank, Tabellen |
| `02_users.sql` | DB-Benutzer anlegen + Rechte vergeben |
| `03_seed.sql` | Beispieldaten für Entwicklung und Tests |

---

## Benutzer & Rechte (Prinzip „Least Privilege")

| Benutzer | Rechte | Warum |
|---|---|---|
| `admin` | `ALL PRIVILEGES` + `WITH GRANT OPTION` + `CREATE USER` | Darf Schema ändern (ALTER, DROP …), neue Nutzer anlegen und Rechte delegieren. Nur für DBA-Aufgaben gedacht. |
| `app_user` | `SELECT, INSERT, UPDATE, DELETE` auf alle Tabellen | Die Anwendung braucht nur CRUD. Kein `CREATE`/`ALTER`/`DROP` und kein `GRANT` verhindert, dass ein kompromittierter App-Account das Schema oder die Rechtevergabe verändert. |
| `report_user` | nur `SELECT` | Rein lesender Zugriff für Auswertungen. Der View gibt nur aggregierte Felder zurück – kein direkter Zugriff auf Rohtabellen mit ggf. sensiblen Freitextfeldern. |

### Warum kein `GRANT ALL` für `app_user`?

Ein `GRANT ALL` würde der Anwendung erlauben, Tabellen zu löschen, das Schema zu verändern oder Rechte weiterzugeben. Wird der App-Account kompromittiert (z. B. durch SQL-Injection), kann ein Angreifer so keinen dauerhaften Schaden an der Datenbankstruktur anrichten.

### Warum `report_user` nur auf den SELECT?

Der SELECT-Befehl und View geben ausschließlich aggregierte, öffentlich relevante Felder aus (Titel, Status, Anzahl Kommentare).

---

## Verbindung zum laufenden Container

```bash
# Als root
docker exec -it database_container mariadb -u root -p'root'

# Als admin
docker exec -it database_container mariadb -u admin -p'admin' ticket_system

# Als app_user
docker exec -it database_container mariadb -u app_user -p'app_user' ticket_system

# Als report_user
docker exec -it database_container mariadb -u report_user -p'report_user' ticket_system
```

Nützliche Befehle innerhalb der MariaDB-Konsole:
```sql
SHOW DATABASES;
USE ticket_system;
SHOW TABLES;
SHOW GRANTS FOR 'app_user'@'%';
SELECT * FROM v_tickets_with_comments;
```
