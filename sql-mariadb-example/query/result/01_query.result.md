categories
---
```sql
SELECT *
FROM categories
WHERE name = 'Bug'
```
| id | name | created_at | updated_at | 
| ---: | --- | --- | --- | 
| 1 | Bug | 2026-06-22 08:10:21 | 2026-06-22 08:10:21 | 

---

tickets
---
```sql
SELECT title, description, author
FROM tickets
WHERE title LIKE 'Password %'
ORDER BY author
```
| title | description | author | 
| --- | --- | --- | 
| Password reset email not sent | Users do not receive reset emails. | Fiona | 

---

comments
---
```sql
SELECT *
FROM comments
LIMIT 5
```
| id | body | author | created_at | updated_at | ticket_id | 
| ---: | --- | --- | --- | --- | ---: | 
| 1 | The bug has been fixed. | John Doe | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 1 | 
| 2 | The new design looks great! | Jane Smith | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 4 | 
| 3 | The security feature has been added successfully. | Alice Johnson | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 3 | 
| 4 | The documentation has been updated. | Bob Brown | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 5 | 
| 5 | The exploit has been patched. | Charlie Wilson | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 3 | 

---

ticket_details
---
```sql
SELECT *
FROM ticket_details
WHERE (status = 'started' OR status = 'in progress') AND priority = 'high'
ORDER BY priority
```
| id | status | priority | created_at | updated_at | ticket_id | 
| ---: | --- | --- | --- | --- | ---: | 
| 1 | started | high | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 1 | 
| 4 | in progress | high | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 4 | 
| 6 | started | high | 2026-06-22 08:10:22 | 2026-06-22 08:10:22 | 6 | 

---

comments
---
```sql
SELECT author, body
FROM comments
WHERE author LIKE 'John%'
```
| author | body | 
| --- | --- | 
| John Doe | The bug has been fixed. | 
| John Doe | I agree with your suggestions. | 
