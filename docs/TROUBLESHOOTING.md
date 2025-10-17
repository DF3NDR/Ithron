# Troubleshooting Guide

Solutions to common issues when using the Kali Linux VS Code Dev Container.

## Table of Contents

1. [Container Build Issues](#container-build-issues)
2. [Docker Issues](#docker-issues)
3. [Network Issues](#network-issues)
4. [Tool Installation Issues](#tool-installation-issues)
5. [VS Code Issues](#vs-code-issues)
6. [Performance Issues](#performance-issues)
7. [Database Issues](#database-issues)

## Container Build Issues

### Problem: Build fails with "Cannot connect to Docker daemon"

**Solution:**
```bash
# Check if Docker is running
docker ps

# If not running, start Docker Desktop (Windows/Mac)
# Or start Docker service (Linux)
sudo systemctl start docker

# Check Docker status
sudo systemctl status docker
```

### Problem: Build takes too long or times out

**Solution:**
1. Check your internet connection
2. Increase Docker resources:
   - Docker Desktop > Settings > Resources
   - Increase CPU and RAM allocation
3. Clear Docker cache:
   ```bash
   docker system prune -a
   ```

### Problem: "No space left on device" during build

**Solution:**
```bash
# Check Docker disk usage
docker system df

# Clean up unused resources
docker system prune -a --volumes

# Check host disk space
df -h

# Increase Docker disk size in Docker Desktop settings
```

### Problem: Package installation fails with 404 errors

**Solution:**
```bash
# Update package lists inside container
sudo apt update

# If persistent, rebuild with fresh package cache
# In devcontainer.json, add to postCreateCommand:
# "sudo apt update && sudo apt upgrade -y"
```

## Docker Issues

### Problem: "permission denied" when running Docker commands

**Solution (Linux):**
```bash
# Add user to docker group
sudo usermod -aG docker $USER

# Log out and back in, or run:
newgrp docker

# Test
docker ps
```

### Problem: Container won't start after system reboot

**Solution:**
```bash
# Restart Docker service
sudo systemctl restart docker

# Or restart Docker Desktop

# Rebuild container in VS Code
# F1 > Remote-Containers: Rebuild Container
```

### Problem: Cannot remove container or image

**Solution:**
```bash
# Force remove container
docker rm -f <container_id>

# Force remove image
docker rmi -f <image_id>

# Remove all stopped containers
docker container prune

# Remove all unused images
docker image prune -a
```

## Network Issues

### Problem: Cannot reach external network from container

**Solution:**
```bash
# Test network connectivity
ping 8.8.8.8
ping google.com

# If ping fails, check Docker network settings
docker network ls
docker network inspect bridge

# Try recreating container with host network
# Edit .devcontainer/devcontainer.json:
# "runArgs": ["--network=host"]
```

### Problem: Port forwarding not working

**Solution:**
1. Check port is exposed in `devcontainer.json`:
   ```json
   "forwardPorts": [8000, 8080]
   ```

2. Verify service is running:
   ```bash
   netstat -tlnp | grep 8000
   ```

3. Check firewall settings on host

4. Restart VS Code and reopen container

### Problem: Network tools don't work (nmap, etc.)

**Solution:**
```bash
# Many network tools require elevated privileges
sudo nmap -sS target.com

# Or run container with additional capabilities
# In devcontainer.json:
"runArgs": [
    "--cap-add=NET_ADMIN",
    "--cap-add=NET_RAW"
]
```

### Problem: "Operation not permitted" for raw sockets

**Solution:**
```bash
# Use sudo for commands requiring raw sockets
sudo nmap -sS target.com

# Or switch to host network mode
# Edit devcontainer.json:
"runArgs": ["--network=host"]
```

## Tool Installation Issues

### Problem: Tool installation script fails

**Solution:**
```bash
# Update package lists
sudo apt update

# Try installing manually
sudo apt install <package-name>

# Check for specific error messages
./scripts/install-networking.sh 2>&1 | tee install.log

# Fix broken packages
sudo apt --fix-broken install
```

### Problem: Python packages fail to install

**Solution:**
```bash
# Upgrade pip
pip install --upgrade pip

# Install with --user flag
pip install --user <package-name>

# Use virtual environment
python -m venv .venv
source .venv/bin/activate
pip install <package-name>

# Check Python version
python --version
```

### Problem: Rust compilation fails

**Solution:**
```bash
# Update Rust
rustup update

# Check for missing dependencies
sudo apt install build-essential

# Clean build
cargo clean
cargo build
```

## VS Code Issues

### Problem: Extensions not loading

**Solution:**
1. Rebuild container:
   - `F1` > `Remote-Containers: Rebuild Container`

2. Install extensions manually:
   - Open Extensions panel (`Ctrl+Shift+X`)
   - Search and install missing extensions

3. Check `devcontainer.json` for extension IDs

### Problem: Debugging doesn't work

**Solution:**
```bash
# Verify debug extension is installed
# For Python:
code --list-extensions | grep python

# Check launch.json configuration
cat .vscode/launch.json

# Test interpreter
python --version
which python
```

### Problem: Terminal not opening or frozen

**Solution:**
1. Restart VS Code
2. Clear terminal:
   - Right-click terminal > Kill Terminal
3. Open new terminal: `` Ctrl+` ``
4. Check terminal settings in `settings.json`

### Problem: IntelliSense not working

**Solution:**
```bash
# Python: Install language server
pip install --user pylint

# Rust: Check rust-analyzer
rustup component add rust-analyzer

# Reload VS Code window
# F1 > Developer: Reload Window
```

### Problem: "Cannot read property" errors in VS Code

**Solution:**
1. Update VS Code to latest version
2. Update Remote - Containers extension
3. Clear VS Code cache:
   ```bash
   rm -rf ~/.vscode-server
   ```
4. Rebuild container

## Performance Issues

### Problem: Container is slow

**Solution:**
1. Increase Docker resources:
   - Docker Desktop > Settings > Resources
   - Increase CPU: 4+ cores
   - Increase RAM: 8GB+

2. Use volume mounts instead of bind mounts for better I/O

3. Disable file watching for large directories:
   ```json
   // In .vscode/settings.json
   "files.watcherExclude": {
       "**/node_modules/**": true,
       "**/.git/**": true,
       "**/target/**": true
   }
   ```

4. Close unused applications on host

### Problem: High CPU usage

**Solution:**
```bash
# Check processes inside container
top
htop

# Kill resource-heavy processes
kill <PID>

# Check Docker stats
docker stats
```

### Problem: High disk usage

**Solution:**
```bash
# Check disk usage in container
df -h
du -sh * | sort -h

# Clean package cache
sudo apt clean
sudo apt autoclean

# Clean Docker system
docker system prune -a
```

## Database Issues

### Problem: PostgreSQL won't start

**Solution:**
```bash
# Check PostgreSQL status
sudo service postgresql status

# Start PostgreSQL
sudo service postgresql start

# Check logs
sudo tail -f /var/log/postgresql/postgresql-*.log

# Restart PostgreSQL
sudo service postgresql restart
```

### Problem: Cannot connect to PostgreSQL

**Solution:**
```bash
# Check if PostgreSQL is running
sudo service postgresql status

# Check PostgreSQL configuration
sudo cat /etc/postgresql/*/main/postgresql.conf

# Test connection
psql -U postgres -h localhost

# Reset PostgreSQL
sudo service postgresql restart
```

### Problem: Metasploit database errors

**Solution:**
```bash
# Reinitialize Metasploit database
msfdb reinit

# Check database status
msfdb status

# Connect to PostgreSQL
sudo -u postgres psql

# Delete and recreate database
msfdb delete
msfdb init
```

## Common Error Messages

### "Connection refused"

**Possible causes:**
- Service not running
- Wrong port
- Firewall blocking

**Solutions:**
```bash
# Check if service is running
netstat -tlnp

# Start the service
sudo service <service-name> start

# Check firewall
sudo iptables -L
```

### "Permission denied"

**Possible causes:**
- Not running as root/sudo
- File permissions
- Docker permissions

**Solutions:**
```bash
# Use sudo
sudo <command>

# Fix file permissions
chmod +x script.sh

# Fix Docker permissions (Linux)
sudo usermod -aG docker $USER
```

### "Command not found"

**Possible causes:**
- Tool not installed
- Not in PATH
- Wrong shell

**Solutions:**
```bash
# Install the tool
sudo apt install <tool-name>

# Check if tool exists
which <command>

# Add to PATH
export PATH=$PATH:/path/to/tool
```

### "No route to host"

**Possible causes:**
- Network configuration
- Firewall
- Wrong network mode

**Solutions:**
```bash
# Check network connectivity
ping <target>

# Check routing
ip route

# Try host network mode
# Edit devcontainer.json:
"runArgs": ["--network=host"]
```

## Still Having Issues?

### Check Logs

```bash
# Docker logs
docker logs <container_id>

# System logs
sudo journalctl -xe

# Application logs
tail -f /var/log/*.log
```

### Get System Information

```bash
# Docker version
docker version

# System info
uname -a
cat /etc/os-release

# Resource usage
free -h
df -h
```

### Report an Issue

If you can't resolve your issue:

1. Search [existing issues](https://github.com/yourusername/kali-devcontainer/issues)
2. Create a new issue with:
   - Description of the problem
   - Steps to reproduce
   - Error messages and logs
   - System information
   - Docker version
   - VS Code version

### Community Support

- [GitHub Discussions](https://github.com/yourusername/kali-devcontainer/discussions)
- [VS Code Dev Containers Documentation](https://code.visualstudio.com/docs/remote/containers)
- [Docker Documentation](https://docs.docker.com/)
- [Kali Linux Forums](https://forums.kali.org/)

---

**Tips for avoiding issues:**
- Keep Docker updated
- Keep VS Code updated
- Regularly update the container: `docker pull kalilinux/kali-rolling:latest`
- Back up your work regularly
- Use version control (git)
- Read error messages carefully
