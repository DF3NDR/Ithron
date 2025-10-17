#!/bin/bash
# Post-create script for dev container setup
# This runs automatically after the container is created

set -e

echo "==================================="
echo "Setting up Kali Dev Container..."
echo "==================================="

# Ensure scripts are executable
chmod +x /workspace/scripts/*.sh

# Create commonly used directories
mkdir -p ~/tools
mkdir -p ~/projects
mkdir -p ~/workspace

echo "✓ Directory structure created"

# Set up git if not configured
if [ ! -f ~/.gitconfig ]; then
    echo "Git not configured. You can configure it later with:"
    echo "  git config --global user.name 'Your Name'"
    echo "  git config --global user.email 'your.email@example.com'"
fi

echo "✓ Post-create setup complete"
echo ""
echo "To install additional tools, run:"
echo "  ./scripts/install-networking.sh"
echo "  ./scripts/install-web.sh"
echo "  ./scripts/install-exploitation.sh"
echo "  ./scripts/install-forensics.sh"
echo ""
