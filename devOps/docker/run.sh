#-d run in background; -p publish port to host; --name assign name to a container; followed by image name. Note that -P will map any required port inside container to network
docker run -d -p 80:80 --name webserver nginx

#after the image name is the command note that docker is alive as long as your command is alive, which means it shuts down right after this cmd
docker run ubuntu /bin/echo 'Hello world'

#-t gives a terminal inside the container, -i allows an interactive connection
docker run -it  ubuntu /bin/bash

#show container stdout
docker logs -f $CONTAINER_ID_OR_NAME

#conversely
docker stop $CONTAINER_ID

#-a list all containers. Otherwise, it lists only running ones
docker ps -a

#get the ip of the host ip: localhost does not do!
docker-machine ip my-docker-vm

docker port nostalgic_morse 5000

docker top

docker inspect nostalgic_morse

#go into containers with bash
sudo docker exec -it $CONTAINER_ID_OR_NAME bash
