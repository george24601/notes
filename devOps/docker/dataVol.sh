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
