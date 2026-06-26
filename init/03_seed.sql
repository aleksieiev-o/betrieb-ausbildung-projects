USE ticket_system;

INSERT INTO categories (name) VALUES
	('Bug'),
	('Feature Request'),
	('Security'),
	('Design'),
	('Documentation'),
	('Support'),
	('Performance'),
	('Infrastructure'),
	('Database'),
	('API'),
	('Mobile'),
	('Testing'),
	('Deployment'),
	('Authentication'),
	('Accessibility'),
	('Reporting'),
	('Integration'),
	('Configuration'),
	('Monitoring'),
	('Enhancement')
;

INSERT INTO tickets (title, description, author, category_id) VALUES
	('Login issue', 'User cannot log in with correct credentials.', 'Alice Johnson', 14),
	('Page not loading', 'Dashboard page takes too long to load.', 'Bob Brown', 1),
	('Error 500 on submit', 'Submitting the form triggers a server error.', 'Charlie Wilson', 10),
	('Feature request: dark mode', 'Add dark mode to improve usability at night.', 'Diana', 2),
	('Typo on homepage', 'There is a spelling error in the header section.', 'Ethan', 1),
	('Password reset email not sent', 'Users do not receive reset emails.', 'Fiona', 14),
	('Mobile layout broken', 'UI elements overlap on small screens.', 'George Brown', 4),
	('Search not working', 'Search returns no results even for valid queries.', 'Hannah', 10),
	('Profile update issue', 'Changes in profile are not saved.', 'Ivan', 9),
	('Slow API response', 'API takes more than 5 seconds to respond.', 'Julia', 10),
	('Notification bug', 'Users receive duplicate notifications.', 'Kevin', 1),
	('File upload failed', 'Uploading large files causes an error.', 'Laura', 10),
	('Security vulnerability', 'Potential XSS issue detected on input fields.', 'Mike', 3),
	('Logout not working', 'Clicking logout does not end the session.', 'Nina', 14),
	('UI misalignment', 'Buttons are not aligned properly on settings page.', 'Oliver', 1)
;

INSERT INTO ticket_details (status, priority, ticket_id) VALUES
 ('started', 'high', 1),
 ('closed', 'low', 2),
 ('started', 'medium', 3),
 ('in progress', 'high', 4),
 ('in progress', 'medium', 5),
 ('started', 'high', 6),
 ('closed', 'low', 7),
 ('in progress', 'medium', 8),
 ('closed', 'low', 9),
 ('closed', 'low', 10),
 ('started', 'medium', 11),
 ('closed', 'low', 12),
 ('started', 'medium', 13),
 ('closed', 'low', 14),
 ('started', 'medium', 15)
;

INSERT INTO tags (name) VALUES
 ('bug'),
 ('performance'),
 ('security'),
 ('design'),
 ('documentation'),
 ('feature'),
 ('frontend'),
 ('backend'),
 ('database'),
 ('api'),
 ('mobile'),
 ('accessibility'),
 ('testing'),
 ('deployment'),
 ('authentication'),
 ('authorization'),
 ('ui'),
 ('ux'),
 ('refactoring'),
 ('hotfix'),
 ('regression'),
 ('urgent'),
 ('enhancement'),
 ('integration'),
 ('configuration'),
 ('logging'),
 ('monitoring'),
 ('notification'),
 ('payment'),
 ('reporting')
;

INSERT INTO comments (body, author, ticket_id) VALUES
  ('The bug has been fixed.', 'John Doe', 1),
  ('The new design looks great!', 'Jane Smith', 4),
	('The security feature has been added successfully.', 'Alice Johnson', 3),
  ('The documentation has been updated.', 'Bob Brown', 5),
	('The exploit has been patched.', 'Charlie Wilson', 3),
  ('The new feature has been implemented.', 'David Garcia', 12),
	('The performance issue has been resolved.', 'Emily Davis', 1),
  ('The new design is much better.', 'Frank Smith', 4),
	('The documentation has been updated again.', 'George Brown', 5),
	('I agree with your suggestions.', 'John Doe', 1),
  ('I think the new design is perfect.', 'Jane Smith', 4),
	('I completely agree with you.', 'Alice Johnson', 13),
  ('I think the documentation is clear now.', 'Bob Brown', 5),
	('I agree with your points.', 'Charlie Wilson', 3),
  ('I think the new feature is a great idea.', 'David Garcia', 2),
	('I agree with your suggestions.', 'Emily Davis', 10),
  ('I think the new design is not perfect.', 'Frank Smith', 4)
;

-- Link table
INSERT INTO ticket_tags (ticket_id, tag_id) VALUES
 (1, 1), (1, 3), (1, 15),
 (2, 1), (2, 2), (2, 7),
 (3, 1), (3, 8), (3, 10),
 (4, 6), (4, 4), (4, 17), (4, 18),
 (5, 1), (5, 7), (5, 5),
 (6, 1), (6, 15), (6, 28),
 (7, 1), (7, 11), (7, 4), (7, 7),
 (8, 1), (8, 8), (8, 10),
 (9, 1), (9, 8), (9, 9),
 (10, 2), (10, 10), (10, 8), (10, 27),
 (11, 1), (11, 28), (11, 21),
 (12, 1), (12, 8), (12, 20),
 (13, 3), (13, 22), (13, 20),
 (14, 1), (14, 15), (14, 3),
 (15, 1), (15, 4), (15, 7), (15, 17)
;
