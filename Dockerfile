FROM node:latest
WORKDIR /app

# Install OpenSSH server
RUN apt-get update && apt-get install -y openssh-server

# Set up SSH server
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd  # Replace 'password' with a secure password

# Allow root login via SSH (not recommended for production)
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Copy your application files
COPY package*.json ./
RUN npm install
COPY . .

# Expose your application and SSH ports
EXPOSE 6750 22

# Start SSH and your application
CMD service ssh start && node index.js
