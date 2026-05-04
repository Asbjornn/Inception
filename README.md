*This project has been created as part of the 42 curriculum by gcauchy.*

# ___Inception___
<a name="top"></a>

## __Table__

1. [Description](#description)
	- [Presentation](#presentation-of-the-project)
	- [Notions](#notions-for-docker)
2. [Instruction](#instructions)
	- [Installation](#installation)
	- [Compilation](#compilation)
	- [Execution](#execution)
3. [Resources](#resources)
4. [Project Description](#projet-description)
	- [Virtual Machines vs Docker](#--virtual-machines-vs-docker)
	- [Secrets vs Environment Variables](#--secrets-vs-environment-variables)
	- [Docker Network vs Host Network](#--docker-network-vs-host-network)
	- [Docker Volumes vs Bind Mounts](#--docker-volumes-vs-bind-mounts)

## __Description__

### Presentation of the project
Brief overview :  
We will create __dockerfiles__ for each docker / application.  
These dockerfiles contains many __instructions__ for container to use when build.

On this project we will create __3 dockers__, one for __Nginx__, one for __MariaDB__ and __Wordpress__.   

- <u>__Nginx__</u>  
Nginx acts as a __secure entry point__.  
It accepts HTTPS connections (port 443), decrypts TLS, and then forwards PHP requests to WordPress PHP-FPM using FastCGI (port 9000).

- <u>__Wordpress__</u>  
Communicates with nginx via port 9000 using __FastCGI__ only.  
It receives FastCGI requests from nginx, executes WordPress PHP code, and returns the result.

- <u>__MariaDB__</u>  
MariaDB is the __database engine__ that __stores WordPress content__.  
MariaDB should only be accessible through the internal Docker network, and not exposed to the host machine.

<br>

### Notions for Docker

**Docker-compose**  
A tool (and YAML file) used to define and manage multiple containers and their configuration (services, networks, volumes) in a single file.

**Dockerfile**  
A text file that describes how to build a Docker image.  

**Docker images**  
A read-only template used to create containers. It contains the application code, dependencies, and configuration needed to run a service.

**Container**  
A lightweight, isolated runtime environment created from a Docker image.



<code style="color : red">ceci est un test coloré</code>



## __Instructions__

### Installation

You can clone the project with github with
```
git clone <link to the repo> inception
```

### Compilation
To compile the project you can run one of those commands
```
make
make build
```
<br>

To stop, run the command
```
make down
```
and clean everything with
```
make clean
make fclean
```
<br>

### Execution
Use the command
```
make up
```

## __Resources__

### References used to do Inception
I used these website to start the project, to have a overview of the project and some notions (Docker, container ...).  
- [Website 1](https://tuto.grademe.fr/inception/)  
- [Website 2](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)  

I also watched some videos on notion on this [Youtube channel](https://www.youtube.com/@cocadmin) to better understanding of Docker.

After that i used a online tuto to see in what direction i need to go.

I used AI to have answer on specific question to fully undestand them and to create a PDF to help me for the building of the all project.


# Projet description

## Docker
Docker allow us to create environment called **containers** to isolate the applications.  
The main benefits of using docker and containers is that it doesn't use a lot of resources and **share kernel**. With that it is really compatible

<br>

### - _Virtual Machines vs Docker_

| Virtual Machines |         Docker      |
|------------------|---------------------|
|Slow to boot      |Fast to boot         |
|GB memory used    |MG memory            |
|Full OS for VM    |Share host OS kernel |

<br>  

### - _Secrets vs Environment Variables_

|          | Secrets 		| Environment Variables	|
|----------|----------------|-----------------------|
|Security  |High   			|Low    		  		|
|Visibility|Hiden			|Visible       			|
|Usage     |Sensitive data	|Config general			|
|Format    |File			|string					|

You can see all the environment variables with **_docker inspect_**

<br>

### - _Docker Network vs Host Network_

**Docker network** is setup with
```
docker run -p 3000:3000 ...
```
Expose the port 3000 with -p  
Create a virtual network where each container has his own IP.
The network is fully isolated more secure and avoid port conflict.

<br>


**Host Network** is setup with
```
docker run --network host ...
```
The container use the network of the host.  
It share IP, ports, stack network.
Maximum performance without NAT and minimum latency.

<br>

**NAT** = Network Address Translation  
Used by *routers* to use only one public address IP to communicate with internet.

<br>

### - _Docker Volumes vs Bind Mounts_

**Docker Volumes** is setup by Docker with
```
docker run -v nginx_logs:/etc/nginx/nginx.conf nginx
```
Store in /var/lib/docker/volumes/  
We use it cause it's secure, portable and easy to backup.

**Bind Mounts** is setup with
```
docker run -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf nginx
```
It link the directory to the container.  
Really useful to access to files from the host.  
But less secure cause it can modify the system.

<br>
<br>

[back to top](#top)