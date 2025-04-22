FROM swift:5.9-jammy

# Install essential packages including curl
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Set up a working directory
WORKDIR /workspace
RUN chown -R $USERNAME:$USERNAME /workspace

# Switch to the non-root user
USER $USERNAME

# Install Swiftly toolchain manager
RUN curl -L https://swiftlang.github.io/swiftly/swiftly-install.sh | bash
ENV PATH="/home/${USERNAME}/.swiftly/bin:${PATH}"

# Add Swiftly to bash profile to ensure it's always available
RUN echo 'export PATH="$HOME/.swiftly/bin:$PATH"' >> /home/$USERNAME/.bashrc

# Verify Swift installation
RUN swift --version

# Set default shell
ENV SHELL=/bin/bash
