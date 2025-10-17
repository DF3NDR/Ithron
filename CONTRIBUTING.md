# Contributing to Kali Linux VS Code Dev Container

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to this project.

## Table of Contents

1. [Code of Conduct](#code-of-conduct)
2. [How Can I Contribute?](#how-can-i-contribute)
3. [Getting Started](#getting-started)
4. [Development Workflow](#development-workflow)
5. [Coding Standards](#coding-standards)
6. [Commit Messages](#commit-messages)
7. [Pull Request Process](#pull-request-process)
8. [Testing](#testing)

## Code of Conduct

### Our Pledge

We are committed to providing a welcoming and inclusive environment for everyone. We expect all contributors to:

- Use welcoming and inclusive language
- Be respectful of differing viewpoints
- Accept constructive criticism gracefully
- Focus on what is best for the community
- Show empathy towards others

### Unacceptable Behavior

- Harassment, discrimination, or offensive comments
- Trolling or insulting/derogatory remarks
- Public or private harassment
- Publishing others' private information without permission
- Other conduct that is inappropriate in a professional setting

## How Can I Contribute?

### Reporting Bugs

Before submitting a bug report:
1. Check the [troubleshooting guide](docs/TROUBLESHOOTING.md)
2. Search [existing issues](https://github.com/yourusername/kali-devcontainer/issues)
3. Collect relevant information (error messages, logs, steps to reproduce)

**Bug Report Template:**
```markdown
**Description:**
A clear description of the bug

**Steps to Reproduce:**
1. Step one
2. Step two
3. ...

**Expected Behavior:**
What you expected to happen

**Actual Behavior:**
What actually happened

**Environment:**
- OS: [e.g., Windows 11, Ubuntu 22.04]
- Docker version: [e.g., 20.10.17]
- VS Code version: [e.g., 1.75.0]
- Error messages/logs: [paste here]

**Additional Context:**
Any other relevant information
```

### Suggesting Enhancements

We welcome feature suggestions! To suggest an enhancement:

1. Check if it's already suggested in [issues](https://github.com/yourusername/kali-devcontainer/issues)
2. Open a new issue with the "enhancement" label
3. Clearly describe:
   - The problem it solves
   - Your proposed solution
   - Why this would be useful to others
   - Any alternatives you've considered

### Contributing Code

We welcome contributions in these areas:

- **New tool installation scripts**
- **Bug fixes**
- **Documentation improvements**
- **Project templates**
- **Performance optimizations**
- **VS Code configuration enhancements**

## Getting Started

### Fork and Clone

```bash
# Fork the repository on GitHub, then:
git clone https://github.com/your-username/kali-devcontainer.git
cd kali-devcontainer

# Add upstream remote
git remote add upstream https://github.com/originalowner/kali-devcontainer.git
```

### Set Up Development Environment

```bash
# Open in VS Code
code .

# Reopen in container
# F1 > Remote-Containers: Reopen in Container

# Create a branch for your changes
git checkout -b feature/my-new-feature
```

## Development Workflow

### 1. Create a Branch

```bash
# Update main branch
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/descriptive-name
# or
git checkout -b fix/bug-description
```

### 2. Make Changes

- Write clean, readable code
- Follow existing code style
- Add comments for complex logic
- Update documentation if needed

### 3. Test Your Changes

```bash
# Test scripts
bash -n script.sh  # Check syntax

# Test functionality
./scripts/your-script.sh

# Rebuild container to test changes
# F1 > Remote-Containers: Rebuild Container
```

### 4. Commit Changes

```bash
# Add changes
git add .

# Commit with descriptive message
git commit -m "feat: add network scanner script"
```

### 5. Push and Create Pull Request

```bash
# Push to your fork
git push origin feature/descriptive-name

# Create pull request on GitHub
```

## Coding Standards

### Shell Scripts

```bash
#!/bin/bash
# Script description
# Usage: ./script.sh <args>

set -e  # Exit on error

# Use descriptive variable names
TOOL_NAME="nmap"
TARGET_HOST="$1"

# Add comments for complex logic
# This function scans ports
scan_ports() {
    local host="$1"
    echo "Scanning $host..."
    # Command here
}

# Check for required arguments
if [ -z "$TARGET_HOST" ]; then
    echo "Usage: $0 <target-host>"
    exit 1
fi

# Call functions
scan_ports "$TARGET_HOST"
```

**Guidelines:**
- Use `#!/bin/bash` shebang
- Add `set -e` for error handling
- Use descriptive variable names (UPPER_CASE for globals)
- Add usage instructions
- Include error checking
- Add comments for clarity
- Use functions for reusability

### Python

```python
#!/usr/bin/env python3
"""
Module docstring describing the script's purpose.
"""

import sys
from typing import List, Optional


def function_name(param: str) -> bool:
    """
    Function docstring describing what it does.

    Args:
        param: Description of parameter

    Returns:
        Description of return value
    """
    # Implementation
    return True


def main() -> None:
    """Main entry point."""
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <argument>")
        sys.exit(1)

    # Logic here


if __name__ == "__main__":
    main()
```

**Guidelines:**
- Use Python 3.6+ features
- Type hints for function signatures
- Docstrings for modules, classes, functions
- Follow PEP 8 style guide
- Use meaningful variable names
- Handle exceptions appropriately
- Add if `__name__ == "__main__":` guard

### Markdown Documentation

```markdown
# Main Heading

Brief description of the document.

## Section Heading

Content with proper formatting:

- Bullet points for lists
- **Bold** for emphasis
- `code` for commands and filenames
- ```bash code blocks ``` for examples

### Subsection

More detailed content.
```

**Guidelines:**
- Use proper heading hierarchy
- Include table of contents for long documents
- Use code blocks with language specification
- Keep lines under 120 characters when possible
- Add examples where helpful

### Dockerfile

```dockerfile
# Use official base image
FROM kalilinux/kali-rolling:latest

# Group related commands to reduce layers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    package1 \
    package2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Use descriptive labels
LABEL maintainer="your.email@example.com"
LABEL description="Description of the image"

# Set environment variables
ENV VARIABLE_NAME=value

# Use COPY instead of ADD when possible
COPY script.sh /usr/local/bin/

# Set proper permissions
RUN chmod +x /usr/local/bin/script.sh
```

## Commit Messages

Use conventional commit format:

```
type(scope): subject

body

footer
```

### Types

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

### Examples

```
feat(scripts): add web testing tools installation script

Add script to install common web application testing tools
including burpsuite, sqlmap, and nikto.

Closes #123
```

```
fix(docker): resolve package installation failures

Update package lists before installation to prevent 404 errors.

Fixes #456
```

```
docs(readme): update quick start instructions

Clarify container build steps and add troubleshooting link.
```

## Pull Request Process

### Before Submitting

- [ ] Code follows project style guidelines
- [ ] Changes have been tested
- [ ] Documentation has been updated
- [ ] Commit messages follow convention
- [ ] No merge conflicts with main branch

### PR Description Template

```markdown
## Description
Brief description of what this PR does

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement
- [ ] Other (describe)

## Changes Made
- Change 1
- Change 2
- ...

## Testing
How you tested your changes

## Related Issues
Closes #XXX
Related to #YYY

## Screenshots (if applicable)
Add screenshots to help explain your changes

## Additional Notes
Any other information that reviewers should know
```

### Review Process

1. Submit pull request
2. Maintainers will review within 7 days
3. Address any requested changes
4. Once approved, maintainers will merge

## Testing

### Manual Testing

```bash
# Test shell scripts
bash -n script.sh
shellcheck script.sh
./script.sh

# Test Python scripts
python -m py_compile script.py
pylint script.py
python script.py

# Test container build
# F1 > Remote-Containers: Rebuild Container

# Test functionality end-to-end
```

### Test Checklist

- [ ] Scripts execute without errors
- [ ] Tools install successfully
- [ ] Documentation is accurate
- [ ] Changes work on Linux/Mac/Windows
- [ ] No security vulnerabilities introduced

## Documentation

When adding new features, update:

- `README.md` - Overview and quick start
- `docs/QUICKSTART.md` - Detailed instructions
- `docs/TOOLS.md` - Tool usage examples
- `docs/TROUBLESHOOTING.md` - Common issues

## Questions?

- Open a [GitHub Discussion](https://github.com/yourusername/kali-devcontainer/discussions)
- Check existing documentation
- Ask in pull request comments

## Recognition

Contributors will be:
- Listed in README
- Mentioned in release notes
- Credited in commit history

Thank you for contributing! 🙏

---

**Note**: By contributing, you agree that your contributions will be licensed under the MIT License.
