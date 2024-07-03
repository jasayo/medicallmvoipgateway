#!/bin/bash

# Set environment variables
export NODE_ENV=production
export LOG_LEVEL=info

# Install dependencies
echo "Installing dependencies..."
npm ci >> logs/install.log 2>&1

# Build the application
echo "Building the application..."
npm run build >> logs/build.log 2>&1

# Create logs directory if it doesn't exist
mkdir -p logs

# Start the application and redirect output to log file
echo "Starting the Matrix API..."
nohup npm start >> logs/api.log 2>&1 &

# Get the process ID of the started application
API_PID=$!

# Wait for the API to start
echo "Waiting for the Matrix API to start..."
while ! nc -z localhost 8080; do
  sleep 0.1
done

# Print the API URL
echo "Matrix API started on http://localhost:8080"

# Tail the API log file
echo "Showing API logs..."
tail -f logs/api.log