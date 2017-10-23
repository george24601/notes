#list images pulled
docker images

#remove an image, rm removes the container
docker rmi -f $IMAGE_ID_OR_NAME

#after making changes to the image
docker commit -m $COMMIT_MESSGAE -a $AUTHOR $CONTAINER_ID_FROM $USER/$CONTAINER_NAME:$TAG

#verify that the image was created correctly
docker images --filter reference=$TAG

docker tag $IMAGE_ID $ACCOUNT_NAME/$IMAGE_NAME:latest


docker run --name postgres -p 5432:5432 -e POSTGRES_PASSWORD=password -d --volumes-from postgres-data postgres


#####AWS ECR Specific WORKFLOW STARTS######
#build docker image, -t is for tags, . is for the location of the Dockerfile
docker build -t $TAG .
aws ecr create-repository --repository-name $REPO_NAME

docker tag $TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$TAG

#get the docker login authentication command string for your registry
aws ecr get-login --no-include-email

#Run the docker login command that was returned in the previous step. This command provides an authorization token that is valid for 12 hours.

docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$TAG

#delete repo after its done
aws ecr delete-repository --repository-name $REPO_NAME --force

#The URL for your default registry is https://your_aws_account_id.dkr.ecr.your_region.amazonaws.com.

#Repository names can support namespaces

#In your ECS task definitions, make sure that you are using the full registry/repository:tag naming for your ECR images. For example, aws_account_id.dkr.ecr.region.amazonaws.com/my-web-app:latest

######AWS ECR WORKFLOW ENDS#########


