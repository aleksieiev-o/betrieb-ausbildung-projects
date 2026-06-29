-- Q4 Subquery / CTE: z. B. "Top 3 Kurse nach Teilnehmerzahl" oder "Einträge ohne Zuordnung"

USE ticket_system;


-- Kommentare von Autoren, die auch ein Ticket mit dem Namen 'Alice Johnson' erstellt haben
SELECT *
FROM comments
WHERE author =
    (SELECT author
     FROM tickets
     WHERE author = 'Alice Johnson');


-- Status und Priorität des Tickets mit der ID 2
SELECT status,
       priority
FROM ticket_details
WHERE ticket_id =
    (SELECT id
     FROM tickets
     WHERE id = 2);

-- Tickets, zu denen noch kein Kommentar existiert
WITH tickets_with_comments AS
  (SELECT DISTINCT ticket_id
   FROM comments)
SELECT id,
       title,
       author,
       created_at
FROM tickets
WHERE id NOT IN
    (SELECT ticket_id
     FROM tickets_with_comments);

-- Top 3 Tags nach Anzahl der Verwendungen in Tickets
WITH tag_counts AS
  (SELECT tag_id,
          COUNT(ticket_id) AS usage_count
   FROM ticket_tags
   GROUP BY tag_id)
SELECT t.name AS tag_name,
       tc.usage_count
FROM tags t
JOIN tag_counts tc ON t.id = tc.tag_id
ORDER BY tc.usage_count DESC
LIMIT 3;


-- Tickets, bei denen der Ticket-Autor selbst einen Kommentar hinterlassen hat
SELECT id,
       title,
       author
FROM tickets t
WHERE EXISTS
    (SELECT 1
     FROM comments c
     WHERE c.ticket_id = t.id
       AND c.author = t.author );
