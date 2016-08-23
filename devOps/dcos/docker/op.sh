#run the image, will pull from public registry if not avaiable locally yet
docker run $IMAGE_NAME:$VERSION

docker run -p 5432:5432 $CONTAINER_ID

#remove container
docker rm $CONTAINER_ID_OR_NAME

#conversely
docker stop $CONTAINER_ID

#list running containers:
docker ps -a

#go into containers with bash
sudo docker exec -i -t {container ID or name} bash

sudo docker exec -i -t 0020670194fc bash

docker create --name postgres-data -v /var/lib/postgresql/data postgres

docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=password -d --volumes-from postgres-data postgres

##############
#Data container volumns ops

#-v creates a volume inside the container at /dbdata
#--name is the container name
#the container is from training/postgres image
docker create -v /dbdata --name dbstore training/postgres /bin/true

#run -d runs the container in the background and prints container id
#--volumns-from loads data volume from dbstore container
#only files from the dbstore container are visible under /dbdata, even if the PG image has data in /dbdata already
docker run -d --volumes-from dbstore --name db1 training/postgres

docker rm -v $ALL_CONTAINER_ID_TO_VOLUME
