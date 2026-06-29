-- Q1 Basic SELECT: einfache Filter/Sortierung (WHERE, ORDER BY, LIMIT)

USE ticket_system;


-- Kategorie mit dem Namen 'Bug' abrufen
SELECT *
FROM categories
WHERE name = 'Bug';


-- Tickets, deren Titel mit 'Password ' beginnt, nach Autor sortiert
SELECT title,
       description,
       author
FROM tickets
WHERE title LIKE 'Password %'
ORDER BY author;


-- Die ersten 5 Kommentare abrufen
SELECT *
FROM comments
LIMIT 5;


-- Ticket-Details mit hoher Priorität und Status 'started' oder 'in progress'
SELECT *
FROM ticket_details
WHERE (status = 'started'
       OR status = 'in progress')
  AND priority = 'high'
ORDER BY priority;


-- Kommentare von Autoren, deren Name mit 'John' beginnt
SELECT author,
       body
FROM comments
WHERE author LIKE 'John%';
