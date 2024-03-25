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
- Docker registry – It is a service that stores Docker images.

**Envornment Variables**
environment variables are key-value pairs that are used to define the environment in which a container runs.

**CMD vs ENTRYPOINT**
cmd is used to provide defaults for an executing container. There can be only one CMD instruction in a Dockerfile. If you list more than one CMD then only the last CMD will take effect. <br/>
entrypoint allows you to configure a container that will run as an executable.

**File system**  
/var/lib/docker
*aufs
*containers
*image
*volumes 

**layered architecture**

```dockerfile
FROM ubuntu
RUN apt-get update && apt-get -y install python
RUN pip install flask flask-mysql
COPY . /opt/source-code
ENTRYPOINT FLASK_APP=/opt/source-code/app.py flask run
```

```bash
docker build Dockerfile -t repo/flask-app
```
layer1 : Base ubuntu image ~120MB
layer2 : changes in apt package ~306MB
layer3 : changes in pip package ~ 10MB
layer4 : copy source code ~ 229B
layer5 : entrypoint ~ 0B

create other Dockerfile 
```dockerfile
FROM ubuntu
RUN apt-get update && apt-get -y install python
RUN pip install flask flask-mysql
COPY app2.py /opt/source-code
ENTRYPOINT FLASK_APP=/opt/source-code/app2.py flask run
```
```bash
docker build Dockerfile -t repo/flask-app2
```
it will use the cache from the previous build and only build the last two layers 

**container layer** is the layer where the changes to the filesystem are stored. 
**image layer** is the layer where the image is stored.

if you want to persist the data in the container you can use volumes
```bash
docker volume create data_volume
docker run -v data_volume:/var/lib/mysql mysql # if data_volume is not created it will be created
```
if you want to mount a host directory to the container
```bash
docker run -v /opt/datadir:/var/lib/mysql mysql
```

**Storage Drivers** are responsible for managing the contents of the image layers and the writable container layer.
* aufs (Advanced Multi-Layered Unification Filesystem) - Ubuntu

What location are the files related to the docker containers and images stored?
/var/lib/docker


**deploy image to docker hub**

```bash
docker login
docker tag image username/repository:tag
docker push username/repository:tag
```

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

## Docker images commands
| Command | Description |
| --- | --- |
| docker images | To list all the available Docker Images |
| docker pull | To pull the docker Images from Docker Hub Repository |
| docker build | To build Docker Image from Dockerfile |
| docker history | To show history of Docker Image |
| docker rmi | To remove the Docker Image |
| docker tag | To add Tag to Docker Image |
| docker push | To push Docker Images to repository |
| docker inspect | To show complete information in JSON format |

## Docker container commands
| Command | Description |
| --- | --- |
| docker start | To start a Docker container |
| docker stop | To stop a running Docker container |
| docker restart | To restart Docker container |
| docker pause | To pause a running container |
| docker unpause | To unpause a running container |
| docker run | Creates a Docker container from Docker image |
| docker ps | To list Docker containers |
| docker exec | To Access the shell of Docker Container |
| docker logs | To view logs of Docker container |
| docker rename | To rename Docker container |
| docker rm | To remove Docker container |
| docker inspect | Docker container info command |
| docker attach | Attach Terminal to Running container |
| docker kill | To stop and remove Docker containers |
| docker cp | To copy files or folders between a container and from local filesystem. |

## compose commands
| Command | Description |
| --- | --- |
| docker-compose build | build docker compose file |
| docker-compose up | To run docker compose file |
| docker-compose ls | To list docker images declared inside docker compose file |
| docker-compose stop | To stop containers which are already created using docker compose file |
| docker-compose start | To start containers which are already created using docker compose file |
| docker-compose run | To run one one of application inside docker-compose.yml |
| docker-compose down | To stop and remove containers created using docker compose file |
| docker-compose ps | To check the status of containers created using docker compose file |
| docker-compose logs | To check logs of containers created using docker compose file |
| docker-compose rm | To remove containers created using docker compose file |

## volume commands
| Command | Description |
| --- | --- |
| docker volume create | To create docker volume |
| docker volume inspect | To inspect docker volume |
| docker volume rm | To remove docker volume |

## Docker Hub Commands

| Command | Description |
| --- | --- |
| docker login | To login to Docker Hub |
| docker logout | To logout from Docker Hub |
| docker search | To search docker image |
| docker pull | To pull image from docker hub |
| docker push | To push the Docker Image again |

## Networking Commands
| Command | Description |
| --- | --- |
| docker network create | To create docker network |
| docker network ls | To list docker networks |
| docker network inspect | To view network configuration details |

## Logs and Monitoring Commands

| Command | Description |
| --- | --- |
| docker logs | To view logs of Docker container |
| docker events | To get all events of docker container |
| docker top | To show running process in docker container |
| docker stats | To check cpu, memory and network I/O usage |
| docker port | To show docker containers public ports |
| docker ps -a | To show running and stopped containers |

## Docker Prune Commands
| Command | Description |
| --- | --- |
| docker system prune | To remove all stopped containers, all dangling images, and all unused networks |
| docker container prune | To remove all stopped containers |
| docker image prune | To remove all dangling images |
| docker volume prune | To remove all unused volumes |
| docker network prune | To remove all unused networks |

