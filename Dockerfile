# Use an official Node image as the base
FROM node:latest

# Set the working directory
WORKDIR /app

# Install necessary packages, set up SSH server, and configure a non-root user
RUN apt-get update && \
    apt-get install -y openssh-server sudo && \
    mkdir /var/run/sshd && \
    useradd -ms /bin/bash sshuser && \
    echo "sshuser:password" | chpasswd && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo 'sshuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    rm -rf /var/lib/apt/lists/*

# Switch to the non-root user
USER sshuser

# Copy application dependencies
COPY package*.json ./
RUN npm install

# Copy the application files
COPY . .

# Expose the application port and SSH port
EXPOSE 6750 22

# Start SSH and your application
CMD service ssh start && node index.js
