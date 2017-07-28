
#mount a data volumn with -v, it will be created upon start, and will persist
docker create --name postgres-data -v /var/lib/postgresql/data postgres

#mount a host directory can be useful for testing: mount source code inside container and o

#use DVC to share data between containers, and/or use it from non-persistent containers

docker create -v /dbdata --name dbstore training/postgres /bin/true
docker run -d --volumes-from dbstore --name db1 training/postgres

#find dangling volumn
docker volume ls -f dangling=true
docker volumn rm $VOL_NAME

docker run --rm --volumes-from dbstore -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata

#1. multiple containers writing to a single shared DV can cause data corruption
#2. access them from dockerhost is can cause data corruption as well


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
