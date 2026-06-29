comments
---
```sql
SELECT *
FROM comments
WHERE author =
    (SELECT author
     FROM tickets
     WHERE author = 'Alice Johnson')
```
| id | body | author | created_at | updated_at | ticket_id | 
| ---: | --- | --- | --- | --- | ---: | 
| 3 | The security feature has been added successfully. | Alice Johnson | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 3 | 
| 12 | I completely agree with you. | Alice Johnson | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 13 | 

---

ticket_details
---
```sql
SELECT status,
       priority
FROM ticket_details
WHERE ticket_id =
    (SELECT id
     FROM tickets
     WHERE id = 2)
```
| status | priority | 
| --- | --- | 
| closed | low | 

---

tickets
---
```sql
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
     FROM tickets_with_comments)
```
| id | title | author | created_at | 
| ---: | --- | --- | --- | 
| 6 | Password reset email not sent | Fiona | 2026-06-22 08:10:22 | 
| 7 | Mobile layout broken | George Brown | 2026-06-22 08:10:22 | 
| 8 | Search not working | Hannah | 2026-06-22 08:10:22 | 
| 9 | Profile update issue | Ivan | 2026-06-22 08:10:22 | 
| 11 | Notification bug | Kevin | 2026-06-22 08:10:22 | 
| 14 | Logout not working | Nina | 2026-06-22 08:10:22 | 
| 15 | UI misalignment | Oliver | 2026-06-22 08:10:22 | 

---

tags
---
```sql
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
LIMIT 3
```
| tag_name | usage_count | 
| --- | ---: | 
| design | 4 | 
| bug | 4 | 
| security | 1 | 

---

tickets
---
```sql
SELECT id,
       title,
       author
FROM tickets t
WHERE EXISTS
    (SELECT 1
     FROM comments c
     WHERE c.ticket_id = t.id
       AND c.author = t.author )
```
| id | title | author | 
| ---: | --- | --- | 
| 3 | Error 500 on submit | Charlie Wilson | 
