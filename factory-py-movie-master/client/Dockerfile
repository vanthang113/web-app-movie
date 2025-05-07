# Base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies using npm
RUN npm install

# Copy the rest of the application
COPY . .
RUN npm install --save-dev @types/nprogress
# Build application
RUN npm run build



# Expose port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
