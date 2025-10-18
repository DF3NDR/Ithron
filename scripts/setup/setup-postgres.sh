#!/bin/bash
# Set up PostgreSQL database for Metasploit and other tools

set -e

echo "==================================="
echo "Setting up PostgreSQL..."
echo "==================================="

# Start PostgreSQL service
sudo service postgresql start

# Wait for PostgreSQL to start
sleep 3

# Create database and user for Metasploit
sudo -u postgres psql << EOF
CREATE USER msf WITH PASSWORD 'msf';
CREATE DATABASE msf OWNER msf;
\q
EOF

echo "✓ PostgreSQL database created"

# Initialize Metasploit database
echo "Initializing Metasploit database..."
msfdb init

echo "✓ Metasploit database initialized"
echo ""
echo "PostgreSQL is now configured for Metasploit."
echo "To start PostgreSQL: sudo service postgresql start"
echo "To stop PostgreSQL: sudo service postgresql stop"
echo "To check status: sudo service postgresql status"
echo ""
echo "To connect to Metasploit console: msfconsole"
echo ""
