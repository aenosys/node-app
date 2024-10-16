# Use an official Node image as the base
FROM node:latest

# Set the working directory
WORKDIR /app

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openssh-server && \
    rm -rf /var/lib/apt/lists/*

# Set up SSH server
RUN mkdir /var/run/sshd && \
    echo 'sshuser:password' | chpasswd && \  # Update 'password' with a secure password
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create a non-root user for SSH
RUN useradd -ms /bin/bash sshuser && \
    echo 'sshuser:password' | chpasswd && \
    echo 'sshuser ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Copy application dependencies
COPY package*.json ./
RUN npm install

# Copy the application files
COPY . .

# Expose the application port and SSH port
EXPOSE 6750 22

# Start SSH and your application
CMD service ssh start && node index.js
