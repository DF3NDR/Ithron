# Network Scanning Project Template

This template provides a starting structure for network reconnaissance and scanning projects.

## Directory Structure

```
scanning-project/
├── scans/          # Raw scan output
├── results/        # Processed results
├── scripts/        # Custom scanning scripts
└── notes/          # Manual notes and findings
```

## Quick Start

1. Copy this template to your projects directory:
   ```bash
   cp -r templates/scanning-project ~/projects/my-scan-project
   cd ~/projects/my-scan-project
   ```

2. Run initial reconnaissance:
   ```bash
   ./scripts/recon.sh <target>
   ```

3. Review results in the `results/` directory

## Example Workflow

### Network Discovery
```bash
# Ping sweep
nmap -sn 192.168.1.0/24 -oN scans/ping-sweep.txt

# ARP scan (local network)
sudo arp-scan --interface=eth0 --localnet > scans/arp-scan.txt
```

### Port Scanning
```bash
# Quick scan
nmap -T4 -F <target> -oN scans/quick-scan.txt

# Full TCP scan
nmap -p- -T4 <target> -oN scans/full-tcp-scan.txt

# Service detection
nmap -sV -p <ports> <target> -oN scans/service-scan.txt

# OS detection
sudo nmap -O <target> -oN scans/os-scan.txt
```

### Vulnerability Scanning
```bash
# Nmap NSE scripts
nmap --script vuln <target> -oN scans/vuln-scan.txt

# Nikto web scan
nikto -h <target> -o scans/nikto-scan.txt
```

## Notes

- Always ensure you have permission to scan the target
- Document your findings in `notes/`
- Keep raw scan outputs in `scans/`
- Store processed results in `results/`
