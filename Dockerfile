# Use the official Node.js image as the base image
FROM node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./ 

# Install dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY . .

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Set up Nginx logs directory
RUN mkdir -p /var/log/nginx

# Expose the ports for Node.js and Nginx
EXPOSE 3000 80

# Command to run both Node.js app and Nginx
CMD service nginx start && node index.js
