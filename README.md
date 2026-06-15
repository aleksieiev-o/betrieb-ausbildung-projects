# MariaDB Übungsprojekt

## Schritte zum Erledigen

1. Docker Setup. *docker-compose.yml* wurde erstellt
	* Es wurde in der Datei angelegt:
		* *environment* - Umgebungsvariablen für die Verbindung mit der Datenbank
		* *volumes* - Persistentes Volume für Daten
		* *ports* - Port-Mapping für den Zugriff der Datenbank im Container
		* *healthcheck* - Regelmäßige Überprüfung der Datenbank im Container

2. Docker Container Start
	* `docker compose up -d --build` - um alle Services aus *docker-compose.yml* im Hintergrund laufen zu lassen
	* `docker compose ps` - um die laufenden Containers aufzulisten
	* `docker compose down` - um alle laufenden Services zu löschen

	* `docker exec -it database_container mariadb -u root -p` - um die Verbindung mit dem laufenden Container zu erstellen und um einen Befehl gleichzeitig auszuführen

3. Benutzer & Rechte in der Datenbank wurden angelegt
	* Die Datenbank "**ticket_system**" wurde beim ersten Start vom Container automatisch erstellt
		* Man kann das in der Console des Containers überprüfen
		* SHOW DATABASES;
		```
		+--------------------+
		| Database           |
		+--------------------+
		| information_schema |
		| mysql              |
		| performance_schema |
		| sys                |
		| ticket_system      |
		+--------------------+
		```
	* 
	* 
	* 
	* 
	* 
	* 
	* 
	* 
	* 

4. 
