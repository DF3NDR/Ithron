#!/bin/bash
# Basic reconnaissance script
# Usage: ./recon.sh <target>

set -e

TARGET="$1"

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <target>"
    exit 1
fi

SCAN_DIR="$(dirname "$0")/../scans"
mkdir -p "$SCAN_DIR"

echo "Starting reconnaissance on $TARGET"
echo "=================================="

# Quick port scan
echo "[+] Running quick port scan..."
nmap -T4 -F "$TARGET" -oN "$SCAN_DIR/quick-scan.txt"

# Service detection on open ports
echo "[+] Running service detection..."
nmap -sV "$TARGET" -oN "$SCAN_DIR/service-scan.txt"

# Basic NSE scripts
echo "[+] Running default NSE scripts..."
nmap --script default "$TARGET" -oN "$SCAN_DIR/nse-scan.txt"

echo ""
echo "Reconnaissance complete!"
echo "Results saved to: $SCAN_DIR"
