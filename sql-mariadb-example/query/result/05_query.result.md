UnknownTable
---
```sql
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
ORDER BY author
```
| title | description | author | tag_name | ticket_status | 
| --- | --- | --- | --- | --- | 
| Feature request: dark mode | Add dark mode to improve usability at night. | Diana | bug | in progress | 
| Search not working | Search returns no results even for valid queries. | Hannah | bug | in progress | 

---

UnknownTable
---
```sql
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
ORDER BY td.priority DESC, t.author
```
| title | author | category | tag | priority | 
| --- | --- | --- | --- | --- | 
| Password reset email not sent | Fiona | Feature Request | bug | high | 
| Error 500 on submit | Charlie Wilson | Feature Request | security | medium | 
| Search not working | Hannah | Feature Request | bug | medium | 

---

UnknownTable
---
```sql
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
ORDER BY t.id
```
| title | author | category | tag | status | 
| --- | --- | --- | --- | --- | 
| Login issue | Alice Johnson | Bug | bug | started | 
| Page not loading | Bob Brown | Feature Request | design | closed | 
| Error 500 on submit | Charlie Wilson | Feature Request | security | started | 
| Feature request: dark mode | Diana | Security | bug | in progress | 
| Typo on homepage | Ethan | Bug | performance | in progress | 
| Password reset email not sent | Fiona | Feature Request | bug | started | 
| Mobile layout broken | George Brown | Design | design | closed | 
| Search not working | Hannah | Feature Request | bug | in progress | 
| Profile update issue | Ivan | Feature Request | design | closed | 
| Slow API response | Julia | Documentation | design | closed | 
| Notification bug | Kevin | Security | (kein Tag) | started | 
| File upload failed | Laura | Design | (kein Tag) | closed | 
| Security vulnerability | Mike | Documentation | (kein Tag) | started | 
| Logout not working | Nina | Bug | (kein Tag) | closed | 
| UI misalignment | Oliver | Design | (kein Tag) | started | 

---

UnknownTable
---
```sql
SELECT tg.name AS tag,
       t.title AS ticket_title,
       cat.name AS category,
       td.status
FROM tags tg
LEFT JOIN ticket_tags tgt ON tg.id = tgt.tag_id
LEFT JOIN tickets t ON tgt.ticket_id = t.id
LEFT JOIN categories cat ON t.category_id = cat.id
LEFT JOIN ticket_details td ON t.id = td.ticket_id
ORDER BY tg.name, t.id
```
| tag | ticket_title | category | status | 
| --- | --- | --- | --- | 
| bug | Login issue | Bug | started | 
| bug | Feature request: dark mode | Security | in progress | 
| bug | Password reset email not sent | Feature Request | started | 
| bug | Search not working | Feature Request | in progress | 
| design | Page not loading | Feature Request | closed | 
| design | Mobile layout broken | Design | closed | 
| design | Profile update issue | Feature Request | closed | 
| design | Slow API response | Documentation | closed | 
| documentation | \N | \N | \N | 
| feature | \N | \N | \N | 
| performance | Typo on homepage | Bug | in progress | 
| security | Error 500 on submit | Feature Request | started | 

---

categories
---
```sql
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
ORDER BY unique_tag_count DESC
```
| category | unique_tag_count | tagged_ticket_count | tags_used | 
| --- | ---: | ---: | --- | 
| Feature Request | 3 | 5 | bug, design, security | 
| Bug | 2 | 2 | bug, performance | 
