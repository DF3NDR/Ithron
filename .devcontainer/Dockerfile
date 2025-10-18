# Kali Linux VS Code Dev Container
# Optimized for security research, tool development, and server management

FROM kalilinux/kali-rolling:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Update and install essential packages in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # Core utilities
    apt-utils \
    ca-certificates \
    curl \
    wget \
    git \
    vim \
    nano \
    locales \
    sudo \
    # Development tools
    build-essential \
    gcc \
    g++ \
    make \
    cmake \
    pkg-config \
    # Python and tools
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    python-is-python3 \
    # Shell tools
    bash-completion \
    shellcheck \
    shfmt \
    # Ruby package manager
    ruby \
    ruby-dev \
    # Network tools (core Kali tools)
    nmap \
    netcat-traditional \
    dnsutils \
    iputils-ping \
    iproute2 \
    traceroute \
    whois \
    # Security tools
    openssh-client \
    gnupg \
    # VPN clients
    openvpn \
    wireguard-tools \
    # Terminal multiplexing
    tmux \
    screen \
    # Database
    postgresql \
    postgresql-contrib \
    # Additional utilities
    jq \
    tree \
    zip \
    unzip \
    p7zip-full \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Generate locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Install Metasploit Framework (optional, can be installed via script)
# RUN apt-get update && apt-get install -y metasploit-framework && rm -rf /var/lib/apt/lists/*

# Create non-root user with sudo privileges
ARG USERNAME=kali
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

# Set up Rust for non-root user
USER $USERNAME
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/${USERNAME}/.cargo/bin:${PATH}"

# Switch back to root for system installations
USER root

# Install Python packages from Kali repos (avoid pip issues)
# Most Python security packages are pre-built in Kali
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Python development dependencies
    libssl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    libpcap-dev \
    # Python packages from Kali repos
    python3-requests \
    python3-bs4 \
    python3-lxml \
    python3-scapy \
    python3-paramiko \
    python3-cryptography \
    python3-flask \
    python3-pytest \
    python3-pip-whl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Note: Additional Python packages can be installed later with:
# pip3 install --user <package>
# or via the post-create script

# Switch back to non-root user
USER $USERNAME

# Create workspace directories
RUN mkdir -p /home/$USERNAME/workspace \
    /home/$USERNAME/.local/bin \
    /home/$USERNAME/tools \
    /home/$USERNAME/projects

# Set up bash configuration with custom prompt
RUN echo 'export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> /home/$USERNAME/.bashrc && \
    echo 'alias ll="ls -alF"' >> /home/$USERNAME/.bashrc && \
    echo 'alias la="ls -A"' >> /home/$USERNAME/.bashrc && \
    echo 'alias l="ls -CF"' >> /home/$USERNAME/.bashrc && \
    echo 'alias ns="nmap -sS"' >> /home/$USERNAME/.bashrc && \
    echo 'alias nf="nmap -sT"' >> /home/$USERNAME/.bashrc && \
    echo 'alias grep="grep --color=auto"' >> /home/$USERNAME/.bashrc && \
    echo '' >> /home/$USERNAME/.bashrc && \
    echo '# Welcome message' >> /home/$USERNAME/.bashrc && \
    echo 'if [ -f /home/kali/.welcome_message ]; then' >> /home/$USERNAME/.bashrc && \
    echo '    cat /home/kali/.welcome_message' >> /home/$USERNAME/.bashrc && \
    echo 'fi' >> /home/$USERNAME/.bashrc

# Configure git with useful aliases
RUN git config --global alias.st status && \
    git config --global alias.co checkout && \
    git config --global alias.br branch && \
    git config --global alias.ci commit && \
    git config --global alias.unstage 'reset HEAD --' && \
    git config --global alias.last 'log -1 HEAD' && \
    git config --global alias.visual 'log --graph --oneline --all' && \
    git config --global color.ui auto && \
    git config --global init.defaultBranch main

# Create welcome message
RUN echo '╔═══════════════════════════════════════════════════════════════╗' > /home/$USERNAME/.welcome_message && \
    echo '║           Kali Linux VS Code Dev Container v1.0              ║' >> /home/$USERNAME/.welcome_message && \
    echo '╠═══════════════════════════════════════════════════════════════╣' >> /home/$USERNAME/.welcome_message && \
    echo '║  Quick Tips:                                                  ║' >> /home/$USERNAME/.welcome_message && \
    echo '║  • Run installation scripts from /workspace/scripts/          ║' >> /home/$USERNAME/.welcome_message && \
    echo '║  • Check docs/ for usage examples and troubleshooting        ║' >> /home/$USERNAME/.welcome_message && \
    echo '║  • Use templates/ for project scaffolding                    ║' >> /home/$USERNAME/.welcome_message && \
    echo '║  • Common aliases: ns (nmap -sS), nf (nmap -sT)             ║' >> /home/$USERNAME/.welcome_message && \
    echo '╚═══════════════════════════════════════════════════════════════╝' >> /home/$USERNAME/.welcome_message

# Switch back to root for final setup
USER root

# Configure PostgreSQL for Metasploit (will be initialized on first run)
RUN mkdir -p /var/run/postgresql && \
    chown -R postgres:postgres /var/run/postgresql && \
    chmod 2777 /var/run/postgresql

# Set default user
USER $USERNAME

# Set working directory
WORKDIR /workspace

# Expose common ports (documentation only, not actually exposing)
# EXPOSE 8080 4444 8000

# Default command
CMD ["/bin/bash"]
