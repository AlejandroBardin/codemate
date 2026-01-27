-- Codemate Database Initialization
-- This file is mounted to /docker-entrypoint-initdb.d/setup.sql
-- It runs on the first startup of the database container.

-- Ensure standard extensions are available if needed
CREATE EXTENSION IF NOT EXISTS plpgsql;
