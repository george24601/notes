#list images pulled
docker images

#remove an image, rm removes the container
docker rmi -f $IMAGE_ID_OR_NAME

#verify that the image was created correctly
docker images --filter reference=$TAG

#delete repo after its done
aws ecr delete-repository --repository-name $REPO_NAME --force

#clean up diskspace - mostly because of overlay
docker system prune -a -f

#The ARG instruction lets Dockerfile authors define values that users can set at build-time using the --build-arg flag:
#This flag allows you to pass the build-time variables that are accessed like regular environment variables in the RUN instruction of the Dockerfile. Also, these values don’t persist in the intermediate or final images like ENV values do.
#It is not recommended to use build-time variables for passing secrets like github keys, user credentials etc. Build-time variable values are visible to any user of the image with the docker history command.
docker build --build-arg HTTP_PROXY=http://10.20.30.2:1234 .

#-d run in background; -p publish port to host; --name assign name to a container; followed by image name. Note that -P will map any required port inside container to network
docker run -d -p 80:80 --name webserver nginx

#after the image name is the command note that docker is alive as long as your command is alive, which means it shuts down right after this cmd
docker run ubuntu /bin/echo 'Hello world'

#get the ip of the host ip: localhost does not do!
docker-machine ip my-docker-vm

docker port nostalgic_morse 5000

#the standard unix top command doesn't work well here, although the best practice says you should run only 1 process inside the docker container
docker top

#inspect can show the actual value of your env vars. Be aware of the risk of leaking secrets
docker inspect nostalgic_morse
