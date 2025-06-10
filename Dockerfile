# Use the official OpenROAD Flow Scripts image as the base
FROM openroad/orfs:latest

# Switch to the root user to install packages
USER root

# Install sudo, vim, and xterm (a lightweight terminal).
# - Use '&&' to chain commands into a single layer.
# - Use '-y' to automatically confirm installation.
# - Clean up the apt cache afterwards to keep the image size down.
RUN apt-get update && apt-get install -y \
    sudo \
    vim \
    xterm \
    gnome-terminal \
    && rm -rf /var/lib/apt/lists/*

# The default user in the ORFS container is 'orfs'.
# Add the 'orfs' user to the sudo group to grant sudo privileges.
RUN useradd -m orfs
RUN adduser orfs sudo

# Optionally, you can allow password-less sudo for convenience.
# Create a new file in the sudoers.d directory for the 'orfs' user.
RUN echo "orfs ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/orfs-nopasswd

# Switch back to the non-root 'orfs' user
USER orfs

# Set the default working directory to the designs folder
WORKDIR /designs
