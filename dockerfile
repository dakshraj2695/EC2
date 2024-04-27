# Use a lightweight Node.js image
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json
COPY package.json ./

# Install dependencies
RUN npm install

# Copy remaining application files (excluding node_modules)
COPY . .

# Use a minimal Node.js image for runtime
FROM node:18-slim

# Copy everything from the builder stage
COPY --from=builder /app /app

# Expose port 3000
EXPOSE 3000

# Set command to run the application
CMD [ "npm", "start" ]
