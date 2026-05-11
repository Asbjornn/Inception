*This project has been created as part of the 42 curriculum by gcauchy.*
# User documentation
<a href="top"></a>

## Table

1. [Understand what services are provided by the stack](#understand-what-services-are-provided-by-the-stack)
2. [Start & Stop the project](#start--stop-the-project)
	- [Start](#start)
	- [Stop](#stop)
3. [Access the website & Administration pannel](#access-the-website--administration-pannel)
	- [Website](#website)
	- [Administration pannel](#administration-pannel)
3. [Locate and manage credentials](#locate-and-manage-credentials)
5. [Check if the device is working](#check-if-the-device-is-working)

## Understand what services are provided by the stack

The stack includes the following services:

|Service	|Description|
|-----------|-----------|
|Nginx		|Web server and reverse proxy|
|MariaDB	|Database server for WordPress|
|WordPress	|Content Management System (CMS) hosting the website|

All services ares defined in *docker-compose.yml*

<br>

## Start & Stop the project

### Start

```bash
make        # build the containers
make up		# start everything
```

### Stop

```bash
make down   # stop all containers
make clean  # stop + and remove volumes
make fclean	# clean + erase ALL images
```

<br>

## Access the website & Administration pannel

### Website

Open a browser and go on the website URL ***https://localhost***   
You may see a self-signed certificate warning, this is normal, you can safely ignore it.

### Administration pannel

On the browser go to:
```
https://localhost/wp-admin
```


<br>

## Locate and manage credentials

**Envrionment variables** are in the .env file (at the root)  
**Secrets** such as password are in the .secrets directory (at the root)

<br>

## Check if the device is working

You can verify that all containers are up and running:
```bash
docker ps
# or
docker compose -f srcs/docker-compose.yml ps
```

You can also view logs for a service:
```bash
docker compose -f srcs/docker-compose.yml logs nginx
docker compose -f srcs/docker-compose.yml logs mariadb
docker compose -f srcs/docker-compose.yml logs wordpress
```


<br>


[Back to top](#top)