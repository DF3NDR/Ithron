# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial project structure
- Dev container configuration with Kali Linux base
- Comprehensive documentation (README, QUICKSTART, TOOLS, TROUBLESHOOTING)
- Modular tool installation scripts
- Project templates for scanning, exploit dev, tool dev, and reporting
- VS Code configurations with debugging support
- Support for Python, Go, Rust, and Bash development
- GitHub issue and PR templates
- Contributing guidelines

### Changed
- Nothing yet

### Deprecated
- Nothing yet

### Removed
- Nothing yet

### Fixed
- Nothing yet

### Security
- Non-root default user with sudo privileges
- Secrets management via .env files
- Configurable network modes

## [1.0.0] - 2025-10-17

### Added
- Initial release
- Kali Linux base image with essential tools
- VS Code Dev Container support
- Multi-language development environment (Python, Go, Rust, Bash)
- Modular tool installation system
- PostgreSQL setup for Metasploit
- Comprehensive documentation
- Project templates for common security workflows
- Development tools pre-configured

### Features
- Rapid environment setup (< 10 minutes)
- Persistent data through Docker volumes
- VS Code extensions for security and development
- Debugging support for all supported languages
- Network tools: nmap, netcat, tcpdump
- Web testing tools: burpsuite, sqlmap, nikto
- Exploitation tools: metasploit, john, hashcat
- Forensics tools: binwalk, volatility, radare2

---

## Version History

### Versioning Scheme

This project follows [Semantic Versioning](https://semver.org/):
- **MAJOR** version for incompatible API changes
- **MINOR** version for new functionality (backwards compatible)
- **PATCH** version for backwards compatible bug fixes

### Types of Changes

- **Added** for new features
- **Changed** for changes in existing functionality
- **Deprecated** for soon-to-be removed features
- **Removed** for now removed features
- **Fixed** for any bug fixes
- **Security** for vulnerability fixes

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for information on how to contribute to this project.

## Support

For issues and questions:
- Check [documentation](docs/)
- Search [issues](https://github.com/yourusername/kali-devcontainer/issues)
- Open a new issue

[Unreleased]: https://github.com/yourusername/kali-devcontainer/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/yourusername/kali-devcontainer/releases/tag/v1.0.0
