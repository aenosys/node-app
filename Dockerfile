# Use an official minimal base image
FROM node:18-slim

# Set environment variables to non-interactive to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      openssh-server \
      sudo \
      ca-certificates \
      gnupg \
      curl \
      lsb-release && \
    rm -rf /var/lib/apt/lists/*

# Create SSH directory and set permissions
RUN mkdir /var/run/sshd && chmod 700 /var/run/sshd

# Create a non-root user for SSH access
RUN useradd -m -s /bin/bash sshuser && \
    echo "sshuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up SSH for the non-root user
RUN mkdir /home/sshuser/.ssh && \
    chmod 700 /home/sshuser/.ssh && \
    chown sshuser:sshuser /home/sshuser/.ssh

# SSH Configuration
# Disable password authentication and root login
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    echo "AllowUsers sshuser" >> /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config && \
    echo "Port 2222" >> /etc/ssh/sshd_config  # Change SSH port to 2222 for non-privileged access

# Install sudo (already installed above, but ensuring it's present)
RUN apt-get update && \
    apt-get install -y sudo && \
    rm -rf /var/lib/apt/lists/*

# Copy application dependencies
COPY package*.json ./
RUN npm install --production

# Copy the application files
COPY . .

# Expose SSH port (2222) and application port (replace with actual port if needed)
EXPOSE 2222 6750

# Start SSH service and your application
CMD ["/bin/bash", "-c", "service ssh start && node index.js"]
