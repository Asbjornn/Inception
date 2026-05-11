*This project has been created as part of the 42 curriculum by gcauchy.*

#  ***Developer documentation***
<a name="top"></a>

## Table

1. [Set up environment](#set-up-environment)
	- [Prerequisites](#prerequisites)
	- [Clone the project](#clone-the-project)
	- [Configuration files](#configuration-files)
	- [Secrets](#secrets)
2. [Build & launch](#build--launch)
	- [Build](#build)
	- [Launch](#launch)
3. [Relevant commands](#relevant-commands)
	- [General commands with Docker](#general-commands-with-docker)
	- [Docker Compose](#docker-compose)
	
4. [Where is data ?](#where-is-data-)
	- [Data Volume](#data-volumes)
	- [Secrets](#secrets-1)
	- [Data persistence](#data-persistence)

<br>

## Set up environment

### Prerequisites

These are the tools or software you must have installed **before** run the project
- Docker
- Docker Compose
- Git

Check your installation with:
```bash
docker --version
docker-compose --version
git --version
```

<br>

### Clone the project

If you haven't already clone the repository:
```bash
git clone <repo_url>
cd <repo_name>
```

<br>

### Configuration files

This project relies on several configuration files:
- **docker-compose.yml**: define all services (Nginx, MariaDB, WordPress), volumes and networks
- **.env**: store environment variables
- Services-specific configuration files
	
<br>

### Secrets

Sensitive data (password, certificates, ...) are stored in the .secrets directory at the root of the project.
```
cd .secrets
```

<br>

## Build & launch

### **Build**

To build the project the Makefile will use docker compose command  
Run one of these commands to build the containers
```bash
make 
make build

# run this command
docker-compose -f srcs/docker-compose.yml build
```
Now the docker compose built all the containers  

<br>

### **Launch**

You can now run 
```bash
make up

# run this command
docker-compose -f srcs/docker-compose.yml up -d
```
With that all the concainters are launch and you can go on a browser with the url ***https://localhost*** to acces the site.


<br>

## Relevant commands

### **General commands with Docker**

Some command line are useful to know is everything is working with our containers.

A command really useful is
```
docker ps
```
With it you have many informations :
- **Container ID** : unique id of the container
- **Image**	: Docker image used
- **Command** line : command executed at launch
- **Created** : date of creation
- **Status** : actual status of the containter (ex: Up 5 minutes)
- **Port** : port exposed
- **Names** : name of the container

With the column Status you can see if every containers are launched.

<br>

Display all containers, including stopped ones: 
```bash
docker ps -a
```
### Docker volumes

List all Docker volumes
```bash
docker volume ls
```

Inspect a volume to have more informations :
```bash
docker volume inspect <container_name>
```

<br>

### Docker image

List all images
```bash
docker images
```

<br>
<br>

### **Docker compose**

Before executing docker compose's command you have to be in his directory :
```bash
cd srcs
```
<br>

### Container

To display logs for a specific service
```bash
docker-compose logs nginx
docker-compose logs mariadb
docker-compose logs wordpress
```

<br>

Follow logs in real time:
```bash
docker-compose logs -f nginx
```

<br>

You can access the running container's shell, which allow you to run command from inside the container
```bash
docker exec -it <container_name> /bin/bash
```
And to leave :
```bash
exit
```
<br>



## Where is data ?

All persistent data in the projext is stored in **Docker volumes**, which are defined in the *docker-compose.yml* file.  
These volumes ensure that your data is kept even if the containers are stopped or removed.

### **Data Volumes**

We have 2 main volumes :
- MariaDB volume : stores the database file
- WordPress volume : store WordPress file (upload, themes, plugins, ...)

These volumes are located in the *data* directory on the host machine:
```
cd /home/gcauchy/data
```
From this location you can access both MariaDB and WordPress data directly.

<br>

### **Secrets**

Sensitive information (password or certificates) is stored in the *.secrets* directory at the root of the project
```
cd .secrets
```

<br>

### **Data Persistence**

Thanks to Docker Volumes:
- Stopping or removing containers does not delete your data
- Data is reused automatically zhen you recreate or restart the containers

<br>
<br>

[back to top](#top)