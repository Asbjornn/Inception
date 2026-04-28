*This project has been created as part of the 42 curriculum by gcauchy.*

# ___Inception___
<a anme="top"></a>

## __Table__

1. [Description](#description)
2. [Instruction](#instructions)
3. [Ressources](#ressources)
3. [Project Description](#projet-description)

## __Description__

### Presentation of the project
Breaf overview :  
We will create __dockerfiles__ for each docker / application.  
These dockerfiles contains many __instructions__ for container to use when build.

On this project we will create __3 dockers__, one for __Nginx__, one for __MariaDB__ and __Wordpress__.   

- <u>__Nginx__</u>  
Nginx acts as a __secure entry point__.  
It accepts HTTPS connections (port 443), decrypts TLS, and then forwards PHP requests to WordPress via FastCGI.

- <u>__Wordpress__</u>  
Communicates with nginx via port 9000 using __FastCGI__ only.  
It receives FastCGI requests from nginx, executes WordPress PHP code, and returns the result.

- <u>__MariaDB__</u>  
MariaDB is the __database engine__ that __stores WordPress content__.  
It should only be accessible from within the WordPress container and not from outside.


Our goal on this project is to use docker to create :
 - dockerfiles
 - containers
 - docker-compose
 - volumes
 - docker images

 <code style="color : red">ceci est un test coloré</code>



## __Instructions__

### Information about
- compilation
- installation
- execution


## __Ressources__

I used these website to start the project, to have a overview of the project and some notions (Docker, container ...).  
- [Website 1](https://tuto.grademe.fr/inception/)  
- [Website 2](https://medium.com/@ssterdev/inception-guide-42-project-part-i-7e3af15eb671)  

I also view some videos on notion on this [Youtube channel](https://www.youtube.com/@cocadmin) to better understanding of Docker.

After that i used a online tuto to see in what direction i need to go.

I used AI to have answer on specific question to fully undestand them and to create a PDF to help me for the building of the all project.

### References used to do Inception

# Projet description

### - _Virtual Machines vs Docker_

| Virtual Machines |         Docker      |
|------------------|---------------------|
|Slow to boot      |Fast to boot         |
|GB memory used    |MG memory            |
|Full OS for VM    |Share host OS kernel |


### - _Secrets vs Environment Variables_

|          | Secrets 		| Environment Variables	|
|----------|----------------|-----------------------|
|Security  |High   			|Low    		  		|
|Visibility|Hiden			|Visible       			|
|Usage     |Sensitive data	|Config general			|
|Format    |File			|string					|

You can see all the environment variables with **_docker inspect_**

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
Maximum performance without NAT and minumum latency.

<br>

**NAT** = Network Address Translation  
Used by *routers* to use only one public address IP to communicate with internet.


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
It link the directory to the container  
Really usefull to access to files from the host.  
But less secure cause it can modify the system

[back to top](#top)