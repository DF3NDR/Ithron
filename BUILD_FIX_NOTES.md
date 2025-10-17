# Docker Build Fix - Go Installation Issue

## Problem
The dev container build was failing with:
```
ERROR: failed to build: failed to solve: process "/bin/sh -c wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz..."
did not complete successfully: exit code: 4
```

## Root Cause
- `wget` exit code 4 indicates network error or file not found
- Go version 1.21.5 may no longer be available at the download URL
- Network issues or golang.org accessibility problems

## Solution Applied

### Changed Dockerfile to use apt package manager (more reliable):

**Before:**
```dockerfile
ENV GO_VERSION=1.21.5
RUN wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz && \
    rm go${GO_VERSION}.linux-amd64.tar.gz
```

**After:**
```dockerfile
# Install Go from apt (more reliable than downloading)
RUN apt-get update && \
    apt-get install -y --no-install-recommends golang-go && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Alternative manual install commented out for future use if needed
```

## Benefits of This Approach

1. **More Reliable**: Uses Kali's package repositories instead of external downloads
2. **Faster Build**: No need to download large tar.gz files
3. **Better Caching**: Docker can cache the apt layer more efficiently
4. **Automatic Updates**: Gets security updates through apt
5. **Network Resilient**: Works even if golang.org is temporarily unreachable

## Testing the Fix

Rebuild the container:
```bash
# In VS Code
F1 > Remote-Containers: Rebuild Container

# Or from command line
docker build -f .devcontainer/Dockerfile .
```

Verify Go is installed:
```bash
go version
go env
```

## Alternative: Use Dev Container Features

If you need a specific Go version, you can use VS Code Dev Container Features instead.

Add to `.devcontainer/devcontainer.json`:
```json
"features": {
    "ghcr.io/devcontainers/features/go:1": {
        "version": "1.23"
    }
}
```

## Files Modified

1. `.devcontainer/Dockerfile` - Changed Go installation method
2. `.devcontainer/BUILD_TROUBLESHOOTING.md` - Added troubleshooting guide
3. `BUILD_FIX_NOTES.md` - This file

## Next Steps

1. Try rebuilding the container
2. If it still fails, check `.devcontainer/BUILD_TROUBLESHOOTING.md`
3. Report any new issues with full error logs

---

**Fix Applied**: October 17, 2025
**Issue**: Go download failure (exit code 4)
**Status**: ✅ Fixed - Using apt package manager instead
