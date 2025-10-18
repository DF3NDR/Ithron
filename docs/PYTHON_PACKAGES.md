# Python Packages - Installation Strategy

## Problem
The Kali Linux base image has issues with pip during Docker build:
- pip upgrade fails
- pip install fails for even basic packages
- Network/repository issues with PyPI from Kali environment

## Solution
**Use apt packages during build, pip after container starts**

### Phase 1: Build Time (Dockerfile)
Install Python packages from Kali repositories using apt:

```dockerfile
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-requests \
    python3-bs4 \
    python3-lxml \
    python3-scapy \
    python3-paramiko \
    python3-cryptography \
    python3-flask \
    python3-pytest \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
```

**Advantages:**
- ✅ Reliable - uses Kali's package mirrors
- ✅ Fast - pre-compiled packages
- ✅ Tested - packages verified for Kali
- ✅ No pip issues during build

### Phase 2: Runtime (Inside Container)
Install additional packages with pip as needed:

```bash
# Run helper script
./scripts/install-python-extras.sh

# Or install manually
pip3 install --user django black pylint mypy pwntools
```

**Advantages:**
- ✅ User-level installation (no root needed)
- ✅ Customizable per user needs
- ✅ Latest versions from PyPI
- ✅ Doesn't block container build

## Pre-installed Python Packages

These packages are available immediately after container starts:

| Package | Purpose | Installed From |
|---------|---------|----------------|
| requests | HTTP library | apt (python3-requests) |
| beautifulsoup4 | Web scraping | apt (python3-bs4) |
| lxml | XML/HTML parsing | apt (python3-lxml) |
| scapy | Packet manipulation | apt (python3-scapy) |
| paramiko | SSH library | apt (python3-paramiko) |
| cryptography | Cryptographic recipes | apt (python3-cryptography) |
| flask | Web framework | apt (python3-flask) |
| pytest | Testing framework | apt (python3-pytest) |

## Packages to Install Later

These can be installed using pip after container starts:

| Package | Purpose | Install Command |
|---------|---------|-----------------|
| django | Web framework | `pip3 install --user django` |
| black | Code formatter | `pip3 install --user black` |
| pylint | Linter | `pip3 install --user pylint` |
| mypy | Type checker | `pip3 install --user mypy` |
| pwntools | CTF/exploitation | `pip3 install --user pwntools` |

## Helper Script

`scripts/install-python-extras.sh` - Interactive script to install common additional packages:

```bash
./scripts/install-python-extras.sh
```

Features:
- Upgrades pip safely
- Installs Django, black, pylint, mypy
- Optional pwntools installation
- Allows custom package list
- Uses --user flag for safe installation

## Best Practices

### For Container Users:
1. ✅ Use pre-installed packages when possible
2. ✅ Install additional packages with `pip3 install --user`
3. ✅ Use virtual environments for project-specific dependencies
4. ✅ Document custom packages in requirements.txt

### For Development:
```bash
# Create project venv
python3 -m venv .venv
source .venv/bin/activate

# Install project deps
pip install -r requirements.txt

# Work in isolated environment
```

### For System-wide Packages:
```bash
# Use sudo only if needed
sudo pip3 install <package>

# Better: use --user flag
pip3 install --user <package>
```

## Troubleshooting

### Package Not Found
```bash
# Search in Kali repos first
apt-cache search python3-<package>

# If available, install via apt
sudo apt-get install python3-<package>

# Otherwise use pip
pip3 install --user <package>
```

### pip Still Fails
```bash
# Update pip
python3 -m pip install --user --upgrade pip

# Use alternate index
pip3 install --user --index-url https://pypi.org/simple <package>

# Install from source
git clone <repo>
cd <repo>
pip3 install --user .
```

### Import Errors
```bash
# Check installation
pip3 list

# Check Python path
python3 -c "import sys; print('\n'.join(sys.path))"

# Ensure ~/.local/bin in PATH
echo $PATH | grep .local
```

## Why This Approach?

### ❌ What Doesn't Work (Kali Docker Build):
- `pip3 install <package>` - Fails with exit code 1
- `python3 -m pip install --upgrade pip` - Fails
- `pip3 install --user <package>` - Fails

### ✅ What Works:
- `apt-get install python3-<package>` - Works reliably
- `pip3 install --user <package>` (after container starts) - Works
- Pre-compiled Kali packages - Works

### Root Cause:
The Kali Docker image has pip/PyPI connectivity or configuration issues during build. This is a known limitation. Using apt during build and pip at runtime is the recommended workaround.

## References
- Kali Docker Documentation: https://www.kali.org/docs/containers/
- Python Packaging Guide: https://packaging.python.org/guides/
- pip User Installation: https://pip.pypa.io/en/stable/user_guide/#user-installs

## Date
October 17, 2025
