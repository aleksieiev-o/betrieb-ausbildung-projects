USE ticket_system;

-- Create users
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'admin';
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'admin';

CREATE USER IF NOT EXISTS 'app_user'@'%' IDENTIFIED BY 'app_user';
CREATE USER IF NOT EXISTS 'app_user'@'localhost' IDENTIFIED BY 'app_user';

CREATE USER IF NOT EXISTS 'report_user'@'%' IDENTIFIED BY 'report_user';
CREATE USER IF NOT EXISTS 'report_user'@'localhost' IDENTIFIED BY 'report_user';

-- Grant privileges to users
GRANT ALL PRIVILEGES ON ticket_system.* TO 'admin'@'%' WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ticket_system.* TO 'admin'@'localhost' WITH GRANT OPTION;
GRANT CREATE ON *.* TO 'admin'@'%';
GRANT CREATE ON *.* TO 'admin'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE ON ticket_system.* TO 'app_user'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON ticket_system.* TO 'app_user'@'localhost';

GRANT SELECT ON ticket_system.* TO 'report_user'@'%';
GRANT SELECT ON ticket_system.* TO 'report_user'@'localhost';

FLUSH PRIVILEGES;
