USE ticket_system;

-- Index 1: tickets(title)
-- Profitiert: Q1 – WHERE title LIKE 'Password %'
-- Warum: B-Tree-Indizes unterstützen Präfix-LIKE (kein führendes Wildcard).
--        Ohne Index: Full Table Scan über alle Tickets.
--        Mit Index: MariaDB springt direkt zum ersten 'Password'-Eintrag.
CREATE INDEX IF NOT EXISTS idx_tickets_title
    ON tickets (title);


-- Index 2: tickets(author)
-- Profitiert: Q4 – Subquery WHERE author = 'Alice Johnson'
--             Q4 – EXISTS: WHERE c.ticket_id = t.id AND c.author = t.author
-- Warum: Beide Subqueries filtern auf dem author-Feld der tickets-Tabelle.
--        Punktsuche (=) auf einem nicht-indizierten VARCHAR-Feld erzwingt
--        sonst einen Full Table Scan pro Outer-Row im EXISTS.
CREATE INDEX IF NOT EXISTS idx_tickets_author
    ON tickets (author);


-- Index 3: comments(author)
-- Profitiert: Q1 – WHERE author LIKE 'John%'
-- Warum: Analog zu idx_tickets_title – Präfix-LIKE nutzt den B-Tree-Index.
--        Ohne Index: Jede Zeile der comments-Tabelle wird geprüft.
CREATE INDEX IF NOT EXISTS idx_comments_author
    ON comments (author);


-- Index 4: comments(ticket_id, author)
-- Profitiert: Q4 – EXISTS WHERE c.ticket_id = t.id AND c.author = t.author
-- Warum: Composite-Index deckt beide Filterbedingungen ab (covering index).
--        Der FK-Auto-Index auf ticket_id allein kann author nicht prüfen;
--        der Composite erlaubt einen reinen Index-Scan ohne Heap-Zugriff.
--        Ersetzt damit den einfachen FK-Index für diese spezifische Abfrage.
CREATE INDEX IF NOT EXISTS idx_comments_ticket_author
    ON comments (ticket_id, author);
