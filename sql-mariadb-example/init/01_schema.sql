CREATE DATABASE IF NOT EXISTS ticket_system;

USE ticket_system;

CREATE TABLE IF NOT EXISTS categories (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(255) UNIQUE NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS tickets (
	id INT AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(255) NOT NULL,
	description TEXT,
	author VARCHAR(100) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	category_id INT,
	FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS ticket_details (
	id INT AUTO_INCREMENT PRIMARY KEY,
	status ENUM('started', 'in progress', 'closed', 'pending') DEFAULT 'started',
	priority ENUM('low', 'medium', 'high') DEFAULT 'low',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	ticket_id INT UNIQUE,
  FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tags (
	id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS comments (
	id INT AUTO_INCREMENT PRIMARY KEY,
	body TEXT NOT NULL,
	author VARCHAR(100) NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	ticket_id INT,
	FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE
);

-- Link table for many-to-many relationship between tickets and tags
CREATE TABLE IF NOT EXISTS ticket_tags (
	ticket_id INT,
	tag_id INT,
	PRIMARY KEY (ticket_id, tag_id),
	FOREIGN KEY (ticket_id) REFERENCES tickets(id) ON DELETE CASCADE,
	FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

CREATE OR REPLACE VIEW v_tickets_with_comments AS SELECT
  t.id AS ticket_id,
  t.title,
  t.description,
  t.author AS ticket_author,
  t.created_at AS ticket_created_at,
	t.updated_at AS ticket_updated_at,
	c.id AS comment_id,
  c.body,
  c.author AS comment_author,
  c.created_at AS comment_created_at,
	c.updated_at AS comment_updated_at
FROM tickets t
LEFT JOIN comments c ON t.id = c.ticket_id
GROUP BY t.id, t.title, t.description, t.author, c.body;
