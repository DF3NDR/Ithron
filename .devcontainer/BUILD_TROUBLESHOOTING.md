# Build Troubleshooting

If you encounter build issues, try these solutions:

## Go Download Failed (exit code 4)

**Issue**: The Dockerfile fails when downloading Go with `exit code: 4`

**Solution**: The Dockerfile has been updated to use apt package manager instead of downloading from golang.org. If you need a specific Go version:

1. Edit `.devcontainer/Dockerfile`
2. Comment out the apt install section
3. Uncomment the manual download section
4. Update `GO_VERSION` to a valid version from https://go.dev/dl/

**Alternative**: Use VS Code Dev Container Features to install Go:

Add to `.devcontainer/devcontainer.json`:
```json
"features": {
    "ghcr.io/devcontainers/features/go:1": {
        "version": "1.23"
    }
}
```

## Container Build Tips

1. **Clear Docker cache** if build fails:
   ```bash
   docker system prune -a
   docker builder prune
   ```

2. **Check network connectivity**:
   ```bash
   ping go.dev
   curl -I https://go.dev/dl/
   ```

3. **Use Docker BuildKit**:
   ```bash
   export DOCKER_BUILDKIT=1
   ```

4. **Rebuild from scratch**:
   - F1 > `Remote-Containers: Rebuild Container Without Cache`

## Network Issues

If you're behind a proxy or firewall:

1. Configure Docker proxy settings in `/etc/docker/daemon.json`:
   ```json
   {
     "proxies": {
       "http-proxy": "http://proxy.example.com:80",
       "https-proxy": "http://proxy.example.com:443"
     }
   }
   ```

2. Restart Docker:
   ```bash
   sudo systemctl restart docker
   ```

## Still Having Issues?

Check the main [TROUBLESHOOTING.md](../docs/TROUBLESHOOTING.md) guide or open an issue on GitHub.
