#!/bin/bash
# Install additional Python packages not available in Kali repos
# Run this script inside the container after it's built

set -e

echo "=========================================="
echo "Installing Additional Python Packages"
echo "=========================================="
echo ""

# Upgrade pip first (as user)
echo "[1/5] Upgrading pip..."
python3 -m pip install --user --upgrade pip setuptools wheel

# Django (web framework with specific version needs)
echo "[2/5] Installing Django..."
pip3 install --user django

# Code quality tools
echo "[3/5] Installing development tools..."
pip3 install --user black pylint mypy

# Optional: Pwntools (large package, might take time)
read -p "Install pwntools? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "[4/5] Installing pwntools (this may take several minutes)..."
    pip3 install --user pwntools
else
    echo "[4/5] Skipping pwntools"
fi

# Any other packages user wants
echo "[5/5] Install additional packages?"
read -p "Enter package names (space-separated) or press Enter to skip: " packages
if [ -n "$packages" ]; then
    echo "Installing: $packages"
    pip3 install --user $packages
fi

echo ""
echo "=========================================="
echo "Installation Complete!"
echo "=========================================="
echo ""
echo "Installed packages are in: ~/.local/lib/python3.x/site-packages"
echo "To use them, ensure ~/.local/bin is in your PATH (already configured)"
echo ""
