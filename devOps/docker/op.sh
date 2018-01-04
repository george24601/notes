#list images pulled
docker images

#remove an image, rm removes the container
docker rmi -f $IMAGE_ID_OR_NAME

#after making changes to the image
docker commit -m $COMMIT_MESSGAE -a $AUTHOR $CONTAINER_ID_FROM $USER/$CONTAINER_NAME:$TAG

#verify that the image was created correctly
docker images --filter reference=$TAG

#delete repo after its done
aws ecr delete-repository --repository-name $REPO_NAME --force

#The URL for your default registry is https://your_aws_account_id.dkr.ecr.your_region.amazonaws.com.

#Repository names can support namespaces

#In your ECS task definitions, make sure that you are using the full registry/repository:tag naming for your ECR images. For example, aws_account_id.dkr.ecr.region.amazonaws.com/my-web-app:latest
