# Use the latest Node.js image as the base image
FROM node:latest

# Set the working directory within the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install the project dependencies
RUN npm install

# Copy the rest of your application code to the working directory
#COPY . .

# Expose a port that your application will listen on (you can change this to match your application)
EXPOSE 3000

# Define the command to run your application
CMD ["node", "index.js"]
