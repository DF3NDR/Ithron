#!/bin/bash
# Main tool installation script
# Run this to install all tool categories

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==================================="
echo "Kali Tools Installation"
echo "==================================="
echo ""
echo "This script will install all tool categories."
echo "You can also run individual scripts:"
echo "  - install-networking.sh"
echo "  - install-web.sh"
echo "  - install-exploitation.sh"
echo "  - install-forensics.sh"
echo ""
read -p "Continue with full installation? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Installation cancelled."
    exit 0
fi

# Run all installation scripts
echo ""
echo "Installing all tools..."
echo ""

bash "$SCRIPT_DIR/install-networking.sh"
echo ""

bash "$SCRIPT_DIR/install-web.sh"
echo ""

bash "$SCRIPT_DIR/install-exploitation.sh"
echo ""

bash "$SCRIPT_DIR/install-forensics.sh"
echo ""

echo "==================================="
echo "Installation Complete!"
echo "==================================="
echo ""
echo "To set up the PostgreSQL database for Metasploit:"
echo "  sudo ./scripts/setup-postgres.sh"
echo ""
