# Build Troubleshooting

If you encounter build issues, try these solutions:

## Container Build Tips

1. **Clear Docker cache** if build fails:
   ```bash
   docker system prune -a
   docker builder prune
   ```

2. **Check network connectivity**:
   ```bash
   # Test general connectivity
   ping google.com
   curl -I https://github.com
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
