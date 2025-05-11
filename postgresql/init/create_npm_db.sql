-- Script para crear la base de datos y usuario para Nginx Proxy Manager
CREATE DATABASE npm;
CREATE USER npm WITH PASSWORD 'npm_password';
GRANT ALL PRIVILEGES ON DATABASE npm TO npm;
ALTER DATABASE npm OWNER TO npm; 