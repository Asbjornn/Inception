*This project has been created as part of the 42 curriculum by gcauchy.*
# User documentation

## Start / Stop the project
```bash
make        # build the containers
make up		# start everything
make down   # stop all containers
make clean  # stop + and remove volumes
make fclean	# clean + erase ALL images
make re		# fclean + build + up
```

## Understand what services are provided by the stack.

## Access the website
Go on https://login.42.fr in a browser.  
Ignore the self-signed certificate warning.


## Login
All the login are in the secrets directory.  
/!\ Never share this directory /!\ .


## Locate and manage credentials
Open the **.env** file  
Some files are in the secrets directory


## Check if the device is working
```bash
docker compose -f srcs/docker-compose.yml ps
docker compose -f srcs/docker-compose.yml logs
```
Show the output of the containers


