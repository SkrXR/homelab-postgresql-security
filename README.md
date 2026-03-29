# Database with PostgreSQL

## Project Title

- Setting Up a Self-Hosted PostgreSQL Database Server

## Objective

- The goal of this project is to set up a self-hosted PostgreSQL database server on Ubuntu Linux.
- This project is intended to provide hands-on experience with database installation, basic server administration, and database management.
- The final system should allow local database creation, user management, and secure access for future applications.
- # Planned Environment

## Planned Environment

- Operating System: Ubuntu Server
- Database System: PostgreSQL
- Deployment Type: Local self-hosted server
- Purpose: Learning and homelab practice

## Notes

- This is my first homelab database project.
- The main focus is to understand the installation process, initial configuration, and basic administration of a PostgreSQL server.
- 

## Environment / Setup

### Hardware

- Device:. Virtual Machine
- CPU: 2 vCPUs
- RAM: 8 GB
- Storage: 500 GB

### Software

- Operating System: Ubuntu Server 24.04.4 LTS
- Access Method: Local terminal

### Installation Notes

- Ubuntu Server was installed using the official ISO image.
- During the installation process, a user account was created.
- After installation, the system was verified using:

```bash
lsb_release -a
```

## Implementation

### Step 1: Install PostgreSQL

1. The system packages were first updated:

```bash
sudo apt update
sudo apt upgrade -y
```

1. PostgreSQL and additional contributed modules were installed:

```bash
sudo apt install postgresql postgresql-contrib -y
```

1. After installation, the PostgreSQL service was checked:

```bash
sudo systemctl status postgresql
```

The service was confirmed to be running.

#### Step 2: Access PostgreSQL

- The PostgreSQL command line interface was accessed using:

```bash
sudo -u postgres psql
```

- Inside the PostgreSQL shell, the installed version was verified:

```sql
SELECT version();
```

- This confirmed that PostgreSQL is installed and operational.
- The session was exited using:

```sql
\q
```

#### Step 3: Create Database and User

1. A new database was created:

```sql
CREATE DATABASE homelab_db;
```

1. A dedicated user was created for accessing the database:

```sql
CREATE USER homelab_user WITH ENCRYPTED PASSWORD 'xxxxxxxx';
```

1. Privileges were granted to allow full access:

```sql
GRANT ALL PRIVILEGES ON DATABASE homelab_db TO homelab_user;
```

1. Exiting the session using:

```sql
\q
```

#### Step 4: Test Connection

- The connection to the database was tested using:

```bash
psql -U homelab_user -d homelab_db -h localhost
```

#### Notes on Database Access

Two different connection methods were used:

- Administrative access via the system user `postgres`
- Standard access using a dedicated database user

The administrative access allows full control over the database system, while the standard user is restricted based on assigned privileges. This improves security and follows best practices.

#### Step 5: Create Security Events Table

- A table named `security_events` was created to store structured cybersecurity event data such as failed logins, port scans, and malware alerts.

```sql
CREATE TABLE security_events (
    id SERIAL PRIMARY KEY,
    event_time TIMESTAMP NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    source_ip VARCHAR(45) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    description TEXT
);
```

### Problem: Permission Denied on Schema

- While attempting to create a table, the following error occurred:

### Cause

- The database user did not have sufficient privileges on the `public` schema.

### Solution

The required permissions were granted using the PostgreSQL superuser:

```sql
GRANT ALL ON SCHEMA public TO homelab_user;
```

Additionally, ownership of the schema was assigned:

```sql
ALTER SCHEMA public OWNER TO homelab_user;
```

### Step 6: Insert Sample Security Event Data

Sample data was inserted into the `security_events` table to simulate basic cybersecurity-related incidents.

```sql
INSERT INTO security_events (event_time, event_type, source_ip, severity, description)
VALUES
('2026-03-27 10:15:00', 'failed_login', '192.168.1.50', 'medium', 'Multiple failed SSH login attempts detected'),
('2026-03-27 11:00:00', 'port_scan', '10.0.0.23', 'high', 'Port scan detected against internal web server'),
('2026-03-27 11:30:00', 'malware_alert', '172.16.0.15', 'high', 'Endpoint protection flagged suspicious file activity');
```

To verify the inserted data, the following query was executed:

```sql
SELECT * FROM security_events;
```

## Step 7: Security Data Analysis

After inserting sample data, several SQL queries were used to analyze the stored security events.

#### Retrieve All Events

```sql
SELECT * FROM security_events;
```

#### Filter High Severity Events

```sql
SELECT*FROM security_events
WHERE severity='high';
```

This query was used to identify critical incidents.

### Identify Most Active Source IPs

```sql
SELECT source_ip,COUNT(*)AS attack_count
FROM security_events
GROUPBY source_ip
ORDERBY attack_countDESC;
```

This query identifies which IP addresses generated the most events.

### Analyze Event Types

```sql
SELECT event_type,COUNT(*)AS total
FROM security_events
GROUPBY event_type
ORDERBY totalDESC;
```

This shows the most frequent types of events.

### Sort Events by Time

```sql
SELECT*FROM security_events
ORDERBY event_timeDESC;
```

This allows reviewing the most recent events first.

### Combined Analysis

```sql
SELECT*FROM security_events
WHERE severity='high'
ORDERBY event_timeDESC;
```

This query provides a focused view of critical events sorted by time.

## Conclusion

This project demonstrates the setup of a PostgreSQL database in a homelab environment, including user management, permission handling, and structured data storage.

In addition, basic cybersecurity event logging and analysis were implemented using SQL queries.

Through this project, practical experience was gained in database administration, troubleshooting, and data analysis.

This project will be expanded in the future to include more advanced features such as remote access, security hardening, and monitoring.