A service launches and maintains a specified number of copies of the task definition in your cluster. 

Container instances need external network access to communicate with the Amazon ECS service endpoint. If your container instances do not have public IP addresses, then they must use network address translation (NAT) or an HTTP proxy to provide this access.

Amazon ECS provides a service scheduler (for long-running tasks and applications), the ability to run tasks manually (for batch jobs or single run tasks)

The service scheduler ensures that the specified number of tasks are constantly running and reschedules tasks when a task fails (for example, if the underlying container instance fails for some reason).

Amazon ECS allows you to run and maintain a specified number (the "desired count") of instances of a task definition simultaneously in an ECS cluster. This is called a service

ECR
--------
Developers can use the Docker CLI to push, pull, and manage images.

Your Docker client needs to authenticate to Amazon ECR registries as an AWS user before it can push and pull images. The AWS CLI get-login command provides you with authentication credentials to pass to Docker

 we don't recommend that you access AWS using the credentials for your AWS account; we recommend that you use AWS Identity and Access Management (IAM) instead. Create an IAM user, and then add the user to an IAM group with administrative permissions or grant this user administrative permissions. You can then access AWS using a special URL and the credentials for the IAM user.


