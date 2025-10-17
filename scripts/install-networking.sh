#!/bin/bash
# Install networking and reconnaissance tools

set -e

echo "==================================="
echo "Installing Networking Tools..."
echo "==================================="

# Update package lists
sudo apt-get update

# Install networking tools
sudo apt-get install -y --no-install-recommends \
    nmap \
    masscan \
    rustscan \
    netdiscover \
    arp-scan \
    netcat-traditional \
    socat \
    tcpdump \
    wireshark-common \
    tshark \
    hping3 \
    arping \
    fping \
    nbtscan \
    enum4linux \
    smbmap \
    nikto \
    dnsenum \
    dnsrecon \
    fierce \
    sublist3r \
    theharvester \
    amass \
    gobuster \
    ffuf \
    wfuzz

# Clean up
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "✓ Networking tools installed successfully"
echo ""
echo "Installed tools include:"
echo "  - nmap, masscan, rustscan (port scanning)"
echo "  - netdiscover, arp-scan (network discovery)"
echo "  - tcpdump, tshark (packet analysis)"
echo "  - dnsenum, dnsrecon, fierce (DNS reconnaissance)"
echo "  - gobuster, ffuf, wfuzz (directory/subdomain fuzzing)"
echo "  - nikto (web server scanner)"
echo ""
