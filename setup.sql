-- Create database
CREATE DATABASE homelab_db;

-- Create user
CREATE USER homelab_user WITH ENCRYPTED PASSWORD 'your_secure_password';

-- Grant privileges on database
GRANT ALL PRIVILEGES ON DATABASE homelab_db TO homelab_user;

-- Connect to database
\c homelab_db

-- Fix permissions
GRANT ALL ON SCHEMA public TO homelab_user;
ALTER SCHEMA public OWNER TO homelab_user;

-- Create table
CREATE TABLE security_events (
    id SERIAL PRIMARY KEY,
    event_time TIMESTAMP NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    source_ip VARCHAR(45) NOT NULL,
    severity VARCHAR(20) NOT NULL,
    description TEXT
);
