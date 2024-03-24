## docker 

docker is a containerization platform that packages your application and all its dependencies together in the form of a container to ensure that your application works seamlessly in any environment. 

Containers allow a developer to package up an application with all of the parts it needs, such as libraries and other dependencies, and ship it all out as one package. 

### installation:
read installation.sh

### core concepts
- Docker Engine – It is a layer which is used to create and manage containers.
- Docker Image – It is a read-only template with instructions for creating a Docker container.
- Docker Container – It is a runnable instance of a Docker image.
- Docker Hub – It is a cloud-based registry service which allows you to link to code
    repositories, build your images and test them, stores manually pushed images, and links to Docker Cloud so you can deploy images to your hosts.
- Docker Compose – It is a tool used to define and run multi-container Docker applications.

### commands
## Basic Docker Commands
| Command | Description |
| --- | --- |
|docker | To check all available Docker Commands |
| docker --version | To check Docker version |
| docker info | Displays system wide information |
| docker --help | To check all available Docker Commands |
| docker pull | To pull the docker Images from Docker Hub Repository |
| docker build | To Docker Image from Dockerfile |
| docker run | Run a container from a docker image. |
| docker ps | List all the running containers. Add the -a flag to list all the containers. |
| docker stop | Stop a running container. |
| docker log | View the logs of a container. |
| docker rm | To remove the Docker Container, stop it first and then remove it |
| docker rmi | To remove the Docker Image |
| docker images | To list all the available Docker Images |
| docker exec | To execute a command in a running container |
| docker commit | To commit a changes in container file OR create new Docker Image |
| docker start | To start a docker container |
| docker rename | To rename Docker Container |

