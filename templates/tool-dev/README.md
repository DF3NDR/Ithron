# Security Tool Development Template

This template provides a starting structure for developing custom security tools.

## Directory Structure

```
tool-dev/
├── src/            # Source code
├── tests/          # Unit tests
├── docs/           # Documentation
├── examples/       # Usage examples
└── requirements.txt or Cargo.toml
```

## Quick Start

1. Copy this template to your projects directory:
   ```bash
   cp -r templates/tool-dev ~/projects/my-tool
   cd ~/projects/my-tool
   ```

2. Choose your language and set up the project structure

3. Develop your tool in `src/`

## Python Tool Template

### Project Structure
```
my-tool/
├── src/
│   └── my_tool/
│       ├── __init__.py
│       ├── main.py
│       └── utils.py
├── tests/
│   └── test_main.py
├── requirements.txt
├── setup.py
└── README.md
```

### Example: Port Scanner Tool

```python
#!/usr/bin/env python3
"""
Simple port scanner tool
"""

import argparse
import socket
from concurrent.futures import ThreadPoolExecutor
from typing import List

def scan_port(host: str, port: int, timeout: float = 1.0) -> dict:
    """Scan a single port"""
    try:
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(timeout)
        result = sock.connect_ex((host, port))
        sock.close()

        if result == 0:
            return {"port": port, "state": "open"}
        return {"port": port, "state": "closed"}
    except socket.gaierror:
        return {"port": port, "state": "error", "error": "hostname not resolved"}
    except socket.error:
        return {"port": port, "state": "error", "error": "connection error"}

def scan_ports(host: str, ports: List[int], threads: int = 10) -> List[dict]:
    """Scan multiple ports concurrently"""
    with ThreadPoolExecutor(max_workers=threads) as executor:
        results = executor.map(lambda p: scan_port(host, p), ports)
    return list(results)

def main():
    parser = argparse.ArgumentParser(description="Simple port scanner")
    parser.add_argument("host", help="Target host to scan")
    parser.add_argument("-p", "--ports", default="1-1000",
                       help="Port range (e.g., 1-1000 or 80,443,8080)")
    parser.add_argument("-t", "--threads", type=int, default=10,
                       help="Number of threads")

    args = parser.parse_args()

    # Parse port range
    if "-" in args.ports:
        start, end = map(int, args.ports.split("-"))
        ports = range(start, end + 1)
    else:
        ports = [int(p) for p in args.ports.split(",")]

    print(f"Scanning {args.host}")
    print("=" * 50)

    results = scan_ports(args.host, list(ports), args.threads)

    # Display open ports
    open_ports = [r for r in results if r["state"] == "open"]
    if open_ports:
        print(f"\nFound {len(open_ports)} open ports:")
        for result in open_ports:
            print(f"  Port {result['port']}: {result['state']}")
    else:
        print("\nNo open ports found")

if __name__ == "__main__":
    main()
```

### requirements.txt
```
argparse
```

## Best Practices

- Write tests for your code
- Use meaningful variable and function names
- Add proper error handling
- Document your code with comments
- Include usage examples
- Consider command-line arguments for flexibility
- Follow language-specific style guides
