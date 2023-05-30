# Base image used
FROM node:16

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies from package.json into a node_modules folder
RUN npm install

# Copy all files from current directory to WORKDIR
COPY . .

# Expose port 3100
EXPOSE 3100

# Run the app
CMD [ "node", "app.js" ]