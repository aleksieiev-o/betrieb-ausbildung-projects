-- Q2 JOIN (1:n): z. B. "Alle Kurse inkl. Dozent"

USE ticket_system;


-- Erste 5 Tickets mit zugehörigem Kategorienamen (LEFT JOIN)
SELECT t.title AS title,
       t.description AS description,
       t.author AS author,
       cat.name AS category_name
FROM tickets AS t
LEFT JOIN categories AS cat ON t.category_id = cat.id
LIMIT 5;


-- Alle Kommentare mit dem dazugehörigen Ticket und dessen Autor
SELECT com.author AS created_by,
       com.body AS BODY,
       com.created_at AS crated_at,
       t.title AS ticket,
       t.author AS ticket_author
FROM comments AS com
LEFT JOIN tickets AS t ON com.ticket_id = t.id;


-- Alle Tickets mit Kategorienamen, nach Kategorie sortiert
SELECT cat.name AS category_name,
       t.title,
       t.author
FROM tickets AS t
JOIN categories AS cat ON t.category_id = cat.id
ORDER BY cat.name;


-- Tickets mit hoher Priorität inkl. Status und Priorität
SELECT t.title,
       t.author,
       det.status,
       det.priority
FROM tickets AS t
JOIN ticket_details AS det ON t.id = det.ticket_id
WHERE det.priority = 'high';


-- Alle Ticket-Tags mit dem jeweiligen Tag-Namen, nach Ticket sortiert
SELECT tt.ticket_id,
       tag.name AS tag_name
FROM ticket_tags AS tt
JOIN tags AS tag ON tt.tag_id = tag.id
ORDER BY tt.ticket_id;
