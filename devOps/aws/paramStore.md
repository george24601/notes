At the time of publication, Systems Manager doesn’t support VPC private endpoint functionality. To enforce stricter access to a Parameter Store endpoint from a private VPC, use a NAT gateway with a set Elastic IP address together with IAM policy conditions that restrict parameter access to a limited set of IP addresses.

With IAM roles for Amazon ECS tasks, you can specify an IAM role to be used by the containers in a task. Applications interacting with AWS services must sign their API requests with AWS credentials. This feature provides a strategy for managing credentials for your applications to use, similar to the way that Amazon EC2 instance profiles provide credentials to EC2 instances.

as the role credentials can be accessed only from within the container for which the role is defined. The role exposes temporary credentials and these are rotated automatically

When you describe the task definition in a CloudFormation template, you could base the entry in the IAM role that provides access to Parameter Store, KMS key, and environment property on a single CloudFormation parameter, such as “environment type.” This approach could support a single task definition type that is based on a generic CloudFormation template.

Injecting secrets into containers via environment variables in the Docker run command or Amazon EC2 Container Service (ECS) task definition are the most common methods of secret injection. However, those methods may not provide the desired level of security because environment variables can be shared with any linked container, read by any process running on the same Amazon EC2 instance, and preserved in intermediate layers of an image and visible via the Docker inspect command or ECS API call. You could also bake secrets into the container image, but someone could still access the secrets via the Docker build cache.

Using IAM roles means that developers and operations staff do not have the credentials to access secrets. Only the application and staff who are responsible for managing the secrets can access them.

Without giving containers and services an identity, it is not possible to protect and restrict access to secrets with access control policies. Our services identify themselves using IAM

ne important piece to the agent is that it runs an HTTP API that MUST be accessible to the other containers that are running in the cluster. T

Secrets stored in Parameter Store are secure strings, encrypted with a customer-specific AWS KMS key.

Each role that accesses the Parameter Store requires the ssm:GetParameters permission. “SSM” stands for “Simple System Manager

In addition to the access control policies, Segment uses a dedicated AWS KMS key to encrypt secure strings within the Parameter Store. Each IAM role is granted a small set of KMS permissions in order to decrypt the secrets they store in Parameter Store.

if you’ve got a sensitive password, it might be a better idea to use a “Secure String” to obfuscate the actual value from your users

```bash
aws ssm get-parameters --names "HostedZoneName"
```

The Build stage uses the CodeBuild project (defined as the ConfigFileBuild action) to run the Ruby script that will modify the configuration file and replace the variable tokens inside of it with the requested parameters from the Parameter Store.

In a real-world situation you would never want to return any password displayed in its plain text because that can present security issues and is bad practice in general.

java -Dsome.property="$(\
  aws ssm get-parameters \
  --names prd.some.property \
  --with-decryption \
  --output text \
  --query Parameters[0].Value \
)" -jar someapp.jar

Maximum number of parameters per account - 10k


One example of injecting from PS

```bash
password=$(aws ssm get-parameters --region us-east-1 --names MySecureSQLPassword --with-decryption --query Parameters[0].Value)
password=`echo $password | sed -e 's/^"//' -e 's/"$//'`
mysqladmin -u root password $password
```
change_password.sh script is part of the ValidateService hook. This means it is executed at the end, after the application is installed and the Apache and MySQL services have been restarted.

When you describe the task definition in a CloudFormation template, you could base the entry in the IAM role that provides access to Parameter Store, KMS key, and environment property on a single CloudFormation parameter, such as “environment type.” This approach could support a single task definition type that is based on a generic CloudFormation template.

Before the agent starts a container, it first fetches credentials for the container’s task role from the AWS credential service. The agent next sets the credentials key ID, a UUID, as the AWS_CONTAINER_CREDENTIALS_RELATIVE_URI environment variable inside the container when it is started.

Using this relative URI and UUID, containers fetch AWS credentials from the agent over HTTP. One container cannot access the authentication credentials to impersonate another container because the UUID is sufficiently difficult to guess.
