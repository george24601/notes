#list images pulled
docker images

#remove an image
docker rmi -f $IMAGE_ID_OR_NAME

#after making changes to the image
docker commit -m $COMMIT_MESSGAE -a $AUTHOR $CONTAINER_ID_FROM $USER/$CONTAINER_NAME:$TAG

#build docker image, -t is for tags, . is for the location of the Dockerfile
docker build -t docker-whale .

docker tag $IMAGE_ID $ACCOUNT_NAME/$IMAGE_NAME:latest


docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=password -d --volumes-from postgres-data postgres
