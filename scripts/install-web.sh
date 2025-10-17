#!/bin/bash
# Install web application testing tools

set -e

echo "==================================="
echo "Installing Web Testing Tools..."
echo "==================================="

# Update package lists
sudo apt-get update

# Install web testing tools
sudo apt-get install -y --no-install-recommends \
    burpsuite \
    zaproxy \
    sqlmap \
    commix \
    wpscan \
    joomscan \
    dirb \
    dirbuster \
    gobuster \
    ffuf \
    wfuzz \
    nikto \
    whatweb \
    wafw00f \
    httprobe \
    httpx-toolkit \
    subfinder \
    sublist3r \
    arjun \
    xsser \
    dalfox

# Install additional Python-based web tools
pip3 install --user \
    requests \
    beautifulsoup4 \
    selenium \
    scrapy \
    jwt \
    flask \
    django

# Clean up
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "✓ Web testing tools installed successfully"
echo ""
echo "Installed tools include:"
echo "  - burpsuite, zaproxy (proxy/interceptor)"
echo "  - sqlmap (SQL injection)"
echo "  - wpscan, joomscan (CMS scanners)"
echo "  - gobuster, ffuf, dirb (directory fuzzing)"
echo "  - nikto, whatweb (web scanners)"
echo "  - xsser, dalfox (XSS testing)"
echo ""
