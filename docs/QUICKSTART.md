# Quick Start Guide

This guide will walk you through setting up and using the Kali Linux VS Code Dev Container.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [First Steps](#first-steps)
4. [Installing Tools](#installing-tools)
5. [Common Workflows](#common-workflows)
6. [Tips and Tricks](#tips-and-tricks)

## Prerequisites

### Software Requirements

1. **Docker Desktop** (Windows/Mac) or **Docker Engine** (Linux)
   - Download from: https://www.docker.com/products/docker-desktop
   - Minimum version: 20.10
   - Ensure Docker is running before proceeding

2. **Visual Studio Code**
   - Download from: https://code.visualstudio.com/
   - Minimum version: 1.60

3. **Remote - Containers Extension**
   - Install from VS Code marketplace
   - Or: Press `Ctrl+P` and run: `ext install ms-vscode-remote.remote-containers`

### System Requirements

- **RAM**: 8GB minimum, 16GB recommended
- **Disk Space**: 20GB free (10GB for base image, 10GB for tools and projects)
- **CPU**: Modern multi-core processor
- **Internet**: Required for initial build and tool installation

## Installation

### Step 1: Clone the Repository

```bash
# Via HTTPS
git clone https://github.com/yourusername/kali-devcontainer.git
cd kali-devcontainer

# Via SSH
git clone git@github.com:yourusername/kali-devcontainer.git
cd kali-devcontainer
```

### Step 2: Open in VS Code

```bash
code .
```

Alternatively, open VS Code and use **File > Open Folder** to open the project.

### Step 3: Build and Open Container

When you open the folder, VS Code will detect the dev container configuration.

**Option A: Automatic Prompt**
- Look for the notification: "Reopen in Container"
- Click the button

**Option B: Command Palette**
1. Press `F1` or `Ctrl+Shift+P` (Windows/Linux) / `Cmd+Shift+P` (Mac)
2. Type: `Remote-Containers: Reopen in Container`
3. Press Enter

**Option C: Status Bar**
- Click the green icon in the bottom-left corner
- Select "Reopen in Container"

### Step 4: Wait for Build

The first build will take 5-10 minutes depending on your internet connection.

You'll see:
- Docker building the image
- Installing packages
- Setting up the environment
- Installing VS Code extensions

## First Steps

### Verify Installation

Once the container is ready, open a terminal in VS Code (`Ctrl+` ` or **Terminal > New Terminal**):

```bash
# Check your user
whoami
# Output: kali

# Check Python
python --version

# Check Rust
rustc --version

# Check core tools
nmap --version
git --version
```

### Explore the Environment

```bash
# List pre-configured aliases
alias

# Check available scripts
ls -la scripts/

# View project templates
ls -la templates/

# Check your home directory
ls -la ~/
```

### Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Verify configuration
git config --list
```

## Installing Tools

The base container includes essential tools. Install additional tools as needed.

### Install All Tool Categories

```bash
./scripts/install-tools.sh
```

This will install:
- Networking tools
- Web testing tools
- Exploitation tools
- Forensics tools

**Note**: This takes 15-30 minutes depending on your system.

### Install Specific Categories

```bash
# Networking and reconnaissance
./scripts/install-networking.sh

# Web application testing
./scripts/install-web.sh

# Exploitation frameworks
./scripts/install-exploitation.sh

# Forensics and analysis
./scripts/install-forensics.sh
```

### Set Up Metasploit Database

```bash
# Initialize PostgreSQL and Metasploit
sudo ./scripts/setup-postgres.sh

# Start Metasploit
msfconsole
```

## Common Workflows

### Network Reconnaissance

```bash
# Create project from template
cp -r templates/scanning-project ~/projects/my-scan
cd ~/projects/my-scan

# Run basic reconnaissance
./scripts/recon.sh 192.168.1.1

# View results
ls -la scans/
cat scans/quick-scan.txt
```

### Web Application Testing

```bash
# Install web tools if not already installed
./scripts/install-web.sh

# Directory enumeration
gobuster dir -u https://target.com -w /usr/share/wordlists/dirb/common.txt

# SQL injection testing
sqlmap -u "https://target.com/page?id=1" --batch --dbs

# Web server scanning
nikto -h https://target.com
```

### Exploit Development

```bash
# Create exploit project
cp -r templates/exploit-dev ~/projects/my-exploit
cd ~/projects/my-exploit

# Create Python exploit
cat > exploits/my_exploit.py << 'EOF'
#!/usr/bin/env python3
from pwn import *

target = remote('127.0.0.1', 9999)
payload = b"A" * 1000
target.send(payload)
target.close()
EOF

chmod +x exploits/my_exploit.py

# Run exploit
python exploits/my_exploit.py
```

### Tool Development

```bash
# Create new tool project
cp -r templates/tool-dev ~/projects/port-scanner
cd ~/projects/port-scanner

# Create Python tool
mkdir -p src/port_scanner
cat > src/port_scanner/scanner.py << 'EOF'
#!/usr/bin/env python3
import socket

def scan_port(host, port):
    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    sock.settimeout(1)
    result = sock.connect_ex((host, port))
    sock.close()
    return result == 0

if __name__ == "__main__":
    host = "127.0.0.1"
    for port in range(1, 1001):
        if scan_port(host, port):
            print(f"Port {port}: OPEN")
EOF

# Run the tool
python src/port_scanner/scanner.py
```

## Tips and Tricks

### Terminal Multiplexing

Use tmux for multiple terminal sessions:

```bash
# Start tmux
tmux

# Create new window: Ctrl+b, then c
# Switch windows: Ctrl+b, then 0-9
# Split pane horizontally: Ctrl+b, then "
# Split pane vertically: Ctrl+b, then %
# Detach: Ctrl+b, then d
# Reattach: tmux attach
```

### Command Aliases

Add custom aliases to `~/.bashrc`:

```bash
cat >> ~/.bashrc << 'EOF'
# Custom aliases
alias ll='ls -alF'
alias scan='nmap -sV -T4'
alias webtest='nikto -h'
alias sqltest='sqlmap -u'
EOF

source ~/.bashrc
```

### Python Virtual Environments

```bash
# Create virtual environment
python -m venv .venv

# Activate
source .venv/bin/activate

# Install packages
pip install requests beautifulsoup4 scapy

# Deactivate
deactivate
```

### VS Code Shortcuts

- **Open terminal**: `` Ctrl+` ``
- **Command palette**: `F1` or `Ctrl+Shift+P`
- **Quick open file**: `Ctrl+P`
- **Search in files**: `Ctrl+Shift+F`
- **Toggle sidebar**: `Ctrl+B`
- **Split editor**: `Ctrl+\`

### Debugging in VS Code

1. Set breakpoints by clicking left of line numbers
2. Press `F5` to start debugging
3. Use debug controls:
   - Continue: `F5`
   - Step Over: `F10`
   - Step Into: `F11`
   - Step Out: `Shift+F11`

### Persist Data

Your data persists in Docker volumes:

```bash
# View volumes
docker volume ls | grep kali

# Workspace is mounted from host
cd /workspace  # Same as your project directory
```

### Network Mode Switching

To use host network mode (required for some tools):

Edit `.devcontainer/devcontainer.json`:

```json
// Comment out this line:
// "runArgs": ["--cap-add=NET_ADMIN", "--cap-add=NET_RAW"],

// Uncomment this line:
"runArgs": ["--network=host"],
```

Then rebuild the container:
1. Press `F1`
2. Type: `Remote-Containers: Rebuild Container`

### Accessing Services from Host

Services running in the container are accessible from your host machine:

```bash
# In container, start a web server
python -m http.server 8000

# From host browser, access:
# http://localhost:8000
```

Port forwarding is automatic for ports defined in `devcontainer.json`.

### Updating Tools

```bash
# Update package lists
sudo apt update

# Upgrade installed packages
sudo apt upgrade -y

# Update specific tools
sudo apt install --only-upgrade nmap
```

### Backup Your Work

```bash
# Commit to git regularly
git add .
git commit -m "Description of changes"
git push

# Or backup important files manually
cp -r ~/projects /workspace/backups/
```

## Next Steps

- Read the [Tool Usage Examples](TOOLS.md)
- Explore the [Templates](../templates/)
- Check [Troubleshooting](TROUBLESHOOTING.md) if you encounter issues
- Start your first security project!

## Getting Help

If you encounter issues:

1. Check [Troubleshooting Guide](TROUBLESHOOTING.md)
2. Search existing [GitHub Issues](https://github.com/yourusername/kali-devcontainer/issues)
3. Open a new issue with:
   - Description of the problem
   - Steps to reproduce
   - Error messages
   - Your system information

Happy hacking! 🔐
