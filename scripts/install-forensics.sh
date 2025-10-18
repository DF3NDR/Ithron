#!/bin/bash
# Install forensics and analysis tools

set -e

echo "==================================="
echo "Installing Forensics Tools..."
echo "==================================="

# Update package lists
sudo apt-get update

# Install forensics tools
sudo apt-get install -y --no-install-recommends \
    autopsy \
    sleuthkit \
    foremost \
    scalpel \
    binwalk \
    exiftool \
    bulk-extractor \
    volatility3 \
    yara \
    clamav \
    chkrootkit \
    rkhunter \
    lynis \
    aide \
    steghide \
    stegosuite \
    outguess \
    zsteg \
    strings \
    file \
    hexedit \
    ghex \
    radare2 \
    rizin \
    gdb \
    pwndbg

# Install Python forensics libraries
pip3 install --user \
    volatility3 \
    yara-python \
    pefile \
    pyelftools \
    capstone \
    construct

# Clean up
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "✓ Forensics tools installed successfully"
echo ""
echo "Installed tools include:"
echo "  - autopsy, sleuthkit (disk forensics)"
echo "  - foremost, scalpel, binwalk (file carving)"
echo "  - volatility3 (memory forensics)"
echo "  - radare2, rizin, gdb (reverse engineering)"
echo "  - steghide, stegosuite (steganography)"
echo "  - lynis, aide, rkhunter (system auditing)"
echo ""
