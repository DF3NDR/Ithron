# Kali Linux VS Code Dev Container

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Docker](https://img.shields.io/badge/docker-ready-blue.svg)](https://www.docker.com/)
[![VS Code](https://img.shields.io/badge/VS%20Code-devcontainer-purple.svg)](https://code.visualstudio.com/)

*Ithron (plural: ithryn) is a Sindarin word from J.R.R. Tolkien's Lord of the Rings, meaning 'wizard' or 'sorcerer'. It symbolizes the mystical power and expertise harnessed for security and creation.*

A professional, production-ready VS Code Dev Container based on Kali Linux for security analysis, penetration testing, tool development, and server management.

## 🎯 Features

- **🚀 Rapid Setup**: Go from zero to fully functional in under 10 minutes
- **🛠️ Development-First**: Seamless integration with modern development workflows
- **🔐 Security Tools**: Modular installation of networking, web testing, exploitation, and forensics tools
- **💻 Multi-Language Support**: Python, Rust, and Bash with full IDE support
- **📦 Non-Root Default**: Secure by default with sudo privileges when needed
- **🎨 Professional Structure**: Well-organized project templates and documentation
- **🔄 Persistent Data**: Volumes for workspace, home directory, and PostgreSQL data
- **🌐 Network Flexibility**: Configurable network modes for different testing scenarios

## 📋 Prerequisites

- **Docker Desktop** or **Docker Engine** (20.10+)
- **VS Code** (1.60+)
- **Remote - Containers Extension** for VS Code
- **8GB RAM** (minimum), 16GB recommended
- **20GB free disk space** (minimum)

### Platform Support

- ✅ Linux (native Docker)
- ✅ Windows 10/11 with WSL2
- ✅ macOS (Intel and Apple Silicon)
- ✅ Podman (as Docker alternative)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/kali-devcontainer.git
cd kali-devcontainer
```

### 2. Open in VS Code

```bash
code .
```

### 3. Reopen in Container

When VS Code opens, you'll see a prompt: **"Reopen in Container"**. Click it, or:

1. Press `F1` or `Ctrl+Shift+P` (Cmd+Shift+P on Mac)
2. Type: **Remote-Containers: Reopen in Container**
3. Press Enter

The container will build automatically. First build takes 5-10 minutes.

### 4. Start Working

Once the container is ready, you'll have:
- A full Kali Linux environment
- All development tools pre-installed
- VS Code extensions loaded
- Terminal ready to use

### 5. Install Additional Tools (Optional)

```bash
# Install all tool categories
./scripts/install-tools.sh

# Or install specific categories
./scripts/install-networking.sh
./scripts/install-web.sh
./scripts/install-exploitation.sh
./scripts/install-forensics.sh

# Set up PostgreSQL for Metasploit
sudo ./scripts/setup-postgres.sh
```

## 📖 Documentation

- **[Quick Start Guide](docs/QUICKSTART.md)** - Detailed setup instructions
- **[Tool Usage Examples](docs/TOOLS.md)** - Common workflows and examples
- **[Troubleshooting](docs/TROUBLESHOOTING.md)** - Solutions to common issues
- **[Contributing](CONTRIBUTING.md)** - How to contribute to this project

## 🗂️ Project Structure

```
kali-devcontainer/
├── .devcontainer/          # Dev container configuration
│   ├── devcontainer.json   # VS Code settings
│   └── Dockerfile          # Container image
├── .vscode/                # VS Code workspace settings
│   ├── extensions.json     # Recommended extensions
│   ├── settings.json       # Editor settings
│   └── launch.json         # Debug configurations
├── scripts/                # Installation and utility scripts
│   ├── install-tools.sh
│   ├── install-networking.sh
│   ├── install-web.sh
│   ├── install-exploitation.sh
│   ├── install-forensics.sh
│   └── setup-postgres.sh
├── templates/              # Project templates
│   ├── scanning-project/
│   ├── exploit-dev/
│   ├── tool-dev/
│   └── reports/
└── docs/                   # Documentation
```

## 🛠️ Pre-installed Tools

### Core Tools (Always Available)
- nmap, netcat, curl, wget, ssh
- Python 3 with pip, venv
- Rust with cargo
- Git, vim, nano
- tmux, screen
- PostgreSQL

### Optional Tool Categories
Install as needed with the provided scripts:

**Networking & Reconnaissance**
- nmap, masscan, rustscan
- netdiscover, arp-scan
- tcpdump, tshark
- dnsenum, dnsrecon, subfinder

**Web Application Testing**
- burpsuite, zaproxy
- sqlmap, commix
- wpscan, nikto
- gobuster, ffuf, wfuzz

**Exploitation**
- metasploit-framework
- searchsploit, exploitdb
- crackmapexec, impacket
- john, hashcat, hydra

**Forensics & Analysis**
- autopsy, sleuthkit
- binwalk, foremost
- volatility3
- radare2, gdb

## 🎯 Use Cases

### Security Research
```bash
# Copy the scanning template
cp -r templates/scanning-project ~/projects/recon
cd ~/projects/recon

# Run reconnaissance
./scripts/recon.sh target.example.com
```

### Tool Development
```bash
# Copy the tool development template
cp -r templates/tool-dev ~/projects/my-scanner
cd ~/projects/my-scanner

# Start developing in Python or Rust
```

### Penetration Testing
```bash
# Install exploitation tools
./scripts/install-exploitation.sh

# Set up Metasploit
sudo ./scripts/setup-postgres.sh

# Start Metasploit
msfconsole
```

### Web Application Security
```bash
# Install web testing tools
./scripts/install-web.sh

# Run web application scans
nikto -h https://target.example.com
sqlmap -u "https://target.example.com/page?id=1" --batch
```

## 🔐 Security Considerations

### Default Security Posture
- Container runs as non-root user (`kali`) by default
- Sudo access available with `NOPASSWD` for tool usage
- No ports exposed by default
- Secrets management via `.env` files (not committed to git)

### Network Modes

**Bridge Mode (Default)**
- Isolated network
- Suitable for most use cases
- Port forwarding as needed

**Host Mode (Optional)**
- Comment out the bridge mode in `devcontainer.json`
- Uncomment host network mode
- Required for some network tools
- ⚠️ Less isolation, use with caution

### VPN Support
- OpenVPN and WireGuard clients pre-installed
- Use for connecting to test environments securely

## 🧪 Development Workflow

### Python
```bash
# Pre-installed packages (from Kali repos):
# - requests, beautifulsoup4, lxml
# - scapy, paramiko, cryptography
# - flask, pytest

# Install additional packages (optional)
./scripts/install-python-extras.sh

# Or install manually
pip3 install --user django black pylint mypy

# Create virtual environment for project
python -m venv .venv
source .venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Debug in VS Code (F5)
```

### Rust
```rust
// Create new project
cargo new myproject

// Build and run
cargo build
cargo run

// Debug in VS Code (F5)
```

## 🔧 Configuration

### Git Configuration
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Environment Variables
Copy `.env.example` to `.env` and customize:
```bash
cp .env.example .env
# Edit .env with your configuration
```

### Custom Aliases
Add to `~/.bashrc`:
```bash
alias ns='nmap -sS'
alias nf='nmap -sT'
alias ports='netstat -tuln'
```

## 📝 Project Templates

### Network Scanning Project
```bash
cp -r templates/scanning-project ~/projects/my-scan
```

### Exploit Development
```bash
cp -r templates/exploit-dev ~/projects/my-exploit
```

### Security Tool Development
```bash
cp -r templates/tool-dev ~/projects/my-tool
```

### Security Assessment Reporting
```bash
cp -r templates/reports ~/projects/my-assessment
```

## 🤝 Contributing

Contributions are welcome! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for details.

### Ways to Contribute
- 🐛 Report bugs
- 💡 Suggest new features
- 📝 Improve documentation
- 🔧 Submit pull requests
- ⭐ Star the project

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Legal Disclaimer

This dev container is intended for:
- Authorized security testing
- Educational purposes
- Security research in controlled environments
- Development of security tools

**You are responsible for obtaining proper authorization before conducting security assessments.** Unauthorized access to computer systems is illegal. The authors assume no liability for misuse of this software.

## 🙏 Acknowledgments

- Kali Linux team for the excellent base image
- VS Code team for the dev container specification
- Security community for tool recommendations
- Contributors who help improve this project

## 📞 Support

- 📖 Check the [Documentation](docs/)
- 🐛 Open an [Issue](https://github.com/yourusername/kali-devcontainer/issues)
- 💬 Start a [Discussion](https://github.com/yourusername/kali-devcontainer/discussions)

## 🗺️ Roadmap

- [ ] Additional language support (Ruby, JavaScript)
- [ ] More tool installation scripts
- [ ] Docker Compose for multi-container setups
- [ ] CI/CD pipeline for container builds
- [ ] Video tutorials
- [ ] Pre-configured tool profiles

---

**Made with ❤️ by security professionals, for security professionals**

⭐ Star this repo if you find it useful!
