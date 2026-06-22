-- Q3 Aggregation: GROUP BY, COUNT/SUM/AVG, HAVING

USE ticket_system;


-- Anzahl der Tickets pro Kategorie (inkl. Kategorien ohne Tickets)
SELECT cat.name AS category,
       COUNT(t.id) AS ticket_count
FROM categories cat
LEFT JOIN tickets t ON cat.id = t.category_id
GROUP BY cat.id,
         cat.name;


-- Tickets, die mindestens einen Kommentar haben, mit Kommentaranzahl
SELECT t.title,
       COUNT(com.id) AS comment_count
FROM tickets t
LEFT JOIN comments com ON t.id = com.ticket_id
GROUP BY t.id,
         t.title
HAVING comment_count > 0;


-- Anzahl der Tickets pro Status
SELECT td.status,
       COUNT(td.id) AS ticket_count
FROM ticket_details td
GROUP BY td.status;


-- Anzahl der Tickets pro Priorität, aufsteigend nach Anzahl sortiert
SELECT td.priority AS priority,
       COUNT(td.id) AS ticket_count
FROM ticket_details td
LEFT JOIN tickets t ON td.ticket_id = t.id
GROUP BY td.priority
ORDER BY ticket_count ASC;


-- Kategorien mit mindestens einem zugeordneten Ticket
SELECT cat.name AS category,
       COUNT(t.id) AS ticket_count
FROM categories cat
JOIN tickets t ON cat.id = t.category_id
GROUP BY cat.id,
         cat.name
HAVING ticket_count > 0;
