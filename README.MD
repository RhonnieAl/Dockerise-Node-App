# Containerise a Node js App using Docker and Kubernetes on Azure

I built this Node app a while back. This is the process of containerising this
Node js app using docker and deploying and managing the docker containers on
Kubernetes using Azure.

## Steps to Deckerise your Node App

#### Step 1. Create a Dockerfile

Add a Dockerfile to your root: Expose your "default" port, You can add it as a
variable in your `docker run` later.

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

Docker Images are shareable and it is not recommended to add sensitive
environment varibales into the Dockerfile.

Running `docker inspect <image>` reveals the contents of the image file.

Best practice is to provide sensitive information only when starting a
container. We will set the environment vars further below in the following
format:

```docker

docker run -e MONGODB_URI='your_mongodb_uri' -d <your-image-name>

```

If you have many environment variables, it might be easier to put them into a
file, and then reference that file when you start the container:

```docker

docker run --env-file .env -d <your-image-name>

```

#### Step 2. Create a .dockerignore file

Add a `.dockerignore` file and add all the node modules and files you would like
not to be copied into your docker `WORKDIR`.

#### Step 3. Install Docker locally

Installed docker on your local and creted a docker account if you do not have
one yet.

###### Some Useful Commands:

`docker ps -a ` to see if you have any running containers

`docker images ` to see all the images you have built, or any images you have
downloaded locally

#### Step 4. Create an Image

`cd ..` Naviage out of your working directory

Run the following build command specifying the `context` of the image, (Path to
the directory location it will build from)

Use the `-t` flag to specify the `name` of the image.

```docker
docker build ./Dockerise-Node-App -t task-manager-image:latest
```

Our Image in this case is called `task-manager-image` its version is `latest`
and it is built from the context `/Dockerise-Node-App`.

#### Step 5. Run Docker Container

Create and run a container based on the image just built. Specify MongoDB
conection string as an Environmnet Variable during run.

```docker
docker run -p 3100:3100 -e "MONGO_URI=<your-mongo-uri>" -d task-manager-image
```

The `-p` flag maps the port in the container to a port on your host. In this
case both ports are 3100.

The flag `-d` specifies that the container should run detached (in the
background), or else the container will only run in your terminal and will
terminate when the terminal is killed.

check if the container is running :

```docker
docker ps -a

```
