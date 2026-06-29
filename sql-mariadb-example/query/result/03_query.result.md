categories
---
```sql
SELECT cat.name AS category, COUNT(t.id) AS ticket_count
FROM categories cat
LEFT JOIN tickets t ON cat.id = t.category_id
GROUP BY cat.id, cat.name
```
| category | ticket_count | 
| --- | ---: | 
| Bug | 3 | 
| Feature Request | 5 | 
| Security | 2 | 
| Design | 3 | 
| Documentation | 2 | 
| Support | 0 | 

---

tickets
---
```sql
SELECT t.title, COUNT(com.id) AS comment_count
FROM tickets t
LEFT JOIN comments com ON t.id = com.ticket_id
GROUP BY t.id, t.title
HAVING comment_count > 0
```
| title | comment_count | 
| --- | ---: | 
| Login issue | 3 | 
| Page not loading | 1 | 
| Error 500 on submit | 3 | 
| Feature request: dark mode | 4 | 
| Typo on homepage | 3 | 
| Slow API response | 1 | 
| File upload failed | 1 | 
| Security vulnerability | 1 | 

---

ticket_details
---
```sql
SELECT td.status, COUNT(td.id) AS ticket_count
FROM ticket_details td
GROUP BY td.status
```
| status | ticket_count | 
| --- | ---: | 
| started | 6 | 
| in progress | 3 | 
| closed | 6 | 

---

ticket_details
---
```sql
SELECT td.priority AS priority, COUNT(td.id) AS ticket_count
FROM ticket_details td
LEFT JOIN tickets t ON td.ticket_id = t.id
GROUP BY td.priority
ORDER BY ticket_count ASC
```
| priority | ticket_count | 
| --- | ---: | 
| high | 3 | 
| low | 6 | 
| medium | 6 | 

---

categories
---
```sql
SELECT cat.name AS category, COUNT(t.id) AS ticket_count
FROM categories cat
JOIN tickets t ON cat.id = t.category_id
GROUP BY cat.id, cat.name
HAVING ticket_count > 0
```
| category | ticket_count | 
| --- | ---: | 
| Bug | 3 | 
| Feature Request | 5 | 
| Security | 2 | 
| Design | 3 | 
| Documentation | 2 | 
