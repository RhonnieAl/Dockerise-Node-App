# Containerise a Node js App using Docker and Kubernetes on Azure

I built this Node app a while back. This is the process of containerising this
Node js app using docker and deploying and managing the docker containers on
Kubernetes using Azure.

## Steps to Deckerise your Node App

1. Add a Dockerfile to your root:

Expose your "default" port, You can add it as a variable in your `docker run`
later.

```

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

```

2. Add a `.dockerignore` file and add all the node modules and files you would
   like not to be copied into your docker `WORKDIR`
