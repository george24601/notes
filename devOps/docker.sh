#run the image, will pull from public registry if not avaiable locally yet
docker run {image name}:{version}

docker run -p 5432:5432 dcce0da1c311

#remove container
docker rm $CID_OR_NAME

#conversely
docker stop 68f1898493dd

#list running containers:
docker ps -a

#go into containers with bash
sudo docker exec -i -t {container ID or name} bash

sudo docker exec -i -t 0020670194fc bash

docker create --name postgres-data -v /var/lib/postgresql/data postgres

docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=password -d --volumes-from postgres-data postgres
