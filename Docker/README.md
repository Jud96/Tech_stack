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

