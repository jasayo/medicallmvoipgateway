# Use a Node.js base image for deploy matrix API JavaScript
FROM node:14-alpine

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Expose the port the app will run on
EXPOSE 8080

# Set the command to start the application
CMD ["npm", "start"]