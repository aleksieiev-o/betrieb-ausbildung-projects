-- Q5 n:m + Mehrfach-JOIN + Bedingung, (INNERJOIN, OUTERJOIN): z. B. "Teilnehmer, die an Kursen von Dozent X teilnehmen, aber nicht an Kurs Y"

USE ticket_system;

-- Tickets mit Tag-Name 'bug' und Status 'in progress'
SELECT title,
       description,
       author,
       tg.name AS tag_name,
       td.status AS ticket_status
FROM tickets t
INNER JOIN ticket_tags tgt ON t.id = tgt.ticket_id
INNER JOIN tags tg ON tg.id = tgt.tag_id
INNER JOIN ticket_details td ON t.id = td.ticket_id
WHERE tg.name = 'bug'
  AND td.status = 'in progress'
ORDER BY author;


-- Tickets aus Kategorie 'Feature Request' mit Tag 'bug' oder 'security' und hoher/mittlerer Priorität
SELECT t.title,
       t.author,
       cat.name AS category,
       tg.name AS tag,
       td.priority
FROM tickets t
INNER JOIN categories cat ON t.category_id = cat.id
INNER JOIN ticket_tags tgt ON t.id = tgt.ticket_id
INNER JOIN tags tg ON tgt.tag_id = tg.id
INNER JOIN ticket_details td ON t.id = td.ticket_id
WHERE cat.name = 'Feature Request'
  AND tg.name IN ('bug', 'security')
  AND td.priority IN ('high', 'medium')
ORDER BY td.priority DESC, t.author;


-- Alle Tickets mit Status und Kategorie, inkl. Tickets ohne Tag
SELECT t.title,
       t.author,
       cat.name AS category,
       COALESCE(tg.name, '(kein Tag)') AS tag,
       td.status
FROM tickets t
INNER JOIN categories cat ON t.category_id = cat.id
INNER JOIN ticket_details td ON t.id = td.ticket_id
LEFT JOIN ticket_tags tgt ON t.id = tgt.ticket_id
LEFT JOIN tags tg ON tgt.tag_id = tg.id
ORDER BY t.id;


-- Alle Tags inkl. ungenutzter Tags, mit den zugehoerigen Ticket-Informationen
SELECT tg.name AS tag,
       t.title AS ticket_title,
       cat.name AS category,
       td.status
FROM tags tg
LEFT JOIN ticket_tags tgt ON tg.id = tgt.tag_id
LEFT JOIN tickets t ON tgt.ticket_id = t.id
LEFT JOIN categories cat ON t.category_id = cat.id
LEFT JOIN ticket_details td ON t.id = td.ticket_id
ORDER BY tg.name, t.id;


-- Kategorien mit Anzahl verschiedener Tags (nur Kategorien mit mindestens 2 verschiedenen Tag-Typen)
SELECT cat.name AS category,
       COUNT(DISTINCT tg.id) AS unique_tag_count,
       COUNT(DISTINCT t.id) AS tagged_ticket_count,
       GROUP_CONCAT(DISTINCT tg.name ORDER BY tg.name SEPARATOR ', ') AS tags_used
FROM categories cat
INNER JOIN tickets t ON cat.id = t.category_id
INNER JOIN ticket_tags tgt ON t.id = tgt.ticket_id
INNER JOIN tags tg ON tgt.tag_id = tg.id
LEFT JOIN ticket_details td ON t.id = td.ticket_id
GROUP BY cat.id, cat.name
HAVING unique_tag_count >= 2
ORDER BY unique_tag_count DESC;
