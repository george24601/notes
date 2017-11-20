In Grant permissions, choose Attach existing policies directly. Select AWSCodeCommitFullAccess from the list of policies
To use Git credentials to connect to AWS CodeCommit, select the IAMSelfManageServiceSpecificCredentials and IAMReadOnlyAccess managed policies.
To use SSH to connect to AWS CodeCommit, select the IAMUserSSHKeys and IAMReadOnlyAccess managed policies.

Repositories are specific to an AWS region

You associate the public key with your IAM user. You store the private key on your local machine

```
Host git-codecommit.*.amazonaws.com
  User APKAEIBAERJR2EXAMPLE
  IdentityFile ~/.ssh/codecommit_rsa
```

IAM user: recommended way to work with ACC
With Git credentials, you generate a static user name and password in IAM. You then use these credentials for HTTPS connections with Git and any third-party tool that supports Git user name and password authentication.

IAM role:  It is similar to an IAM user, but it is not associated with a specific person. Unlike an IAM user identity, you cannot use Git credentials or SSH keys with this identity type. However, an IAM role enables you to obtain temporary access keys that you can use to access AWS services and resources. IAM roles with temporary credentials are useful in the following situations

You can use an IAM role in your account to grant another AWS account permissions to access your account’s resources

To assign an AWS role to an EC2 instance and make it available to all of its applications, you can create an instance profile that is attached to the instance. An instance profile contains the role and enables programs running on the EC2 instance to get temporary credentials

. A role that a service assumes to perform actions on your behalf is called a service role. When a role serves a specialized purpose for a service, it is categorized as a service role for EC2 instances


DefaultAWSCredentialsProviderChain Sequences
-------
1. Environment variables–AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
2. Java system properties–aws.accessKeyId and aws.secretKey
3. The default credential profiles file– typically located at ~/.aws/credentials
4. Amazon ECS container credentials– loaded from the Amazon ECS if the environment variable AWS_CONTAINER_CREDENTIALS_RELATIVE_URI is set
5. Instance profile credentials– used on EC2 instances, and delivered through the Amazon EC2 metadata service. The AWS SDK for Java uses the InstanceProfileCredentialsProvider to load these credentials.

TRUSTED ENTITY?

When you create the role, you define the Development account as a trusted entity and specify a permissions policy that allows trusted users to update the productionapp bucket.

you can and should use an IAM role to manage temporary credentials for applications that run on an EC2 instance. When you use a role, you don't have to distribute long-term credentials to an EC2 instance. Instead, the role supplies temporary permissions that applications can use when they make calls to other AWS resources. When you launch an EC2 instance, you specify an IAM role to associate with the instance. Applications that run on the instance can then use the role-supplied temporary credentials to sign API requests.

The instance profile contains the role and can provide the role's credentials to an application that runs on the instance. Those credentials can then be used in the application's API calls to access resources and to limit access to only those resources that the role specifies. Note that only one role can be assigned to an EC2 instance at a time, and all applications on the instance share the same role and permissions.

a role can also be attached to an EC2 instance that is already running

Alternatively, the application can get the temporary credentials directly from the instance metadata of the EC2 instance. Credentials and related values are available from the iam/security-credentials/role-name category (in this case, iam/security-credentials/Get-pics) of the metadata. If the application gets the credentials from the instance metadata, it can cache the credentials.

iam role to access codecommit repo: AWSCodeCommitFullAccess

The automatic credentials refresh happens only when you use the default client constructor, which creates its own InstanceProfileCredentialsProvider as part of the default provider chain, or when you pass an InstanceProfileCredentialsProvider instance directly to the client constructor. If you use another method to obtain or pass instance profile credentials, you are responsible for checking for and refreshing expired credentials.

You can specify a credential provider that is different from the default credential provider chain by using the client builder.


Making API requests with IAM roles
-----------
1. Create an IAM role.
2. Define which accounts or AWS services can assume the role.
3. Define which API actions and resources the application can use after assuming the role.
4. Specify the role when you launch your instance, or attach the role to a running or stopped instance.
5. Have the application retrieve a set of temporary credentials and use them

An application on the instance retrieves the security credentials provided by the role from the instance metadata item iam/security-credentials/role-name

To view all categories of instance metadata from within a running instance,

```
curl http://169.254.169.254/latest/meta-data/
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
```
An account administrator can attach permissions policies to IAM identities (that is, users, groups, and roles).

The AWS account owns the resources that are created in the account, regardless of who created them

If you create an IAM user in your AWS account and grant permissions to create AWS CodeCommit resources to that user, the user can create AWS CodeCommit resources. However, your AWS account, to which the user belongs, owns the AWS CodeCommit resources.

Currently, AWS CodeCommit supports only identity-based policies (IAM policies).

 A trust policy specifies which trusted accounts are allowed to grant its users permissions to assume the role.

For example, the administrator in Account A can create a role to grant cross-account permissions to another AWS account (for example, Account B) or an AWS service as follows:
Account A administrator creates an IAM role and attaches a permissions policy to the role that grants permissions on resources in Account A.
Account A administrator attaches a trust policy to the role identifying Account B as the principal who can assume the role.
Account B administrator can then delegate permissions to assume the role to any users in Account B. Doing this allows users in Account B to create or access resources in Account A. If you want to grant an AWS service permissions to assume the role, the principal in the trust policy can also be an AWS service principal. For more information, see Delegation in IAM Terms and Concepts.

Principal – In identity-based policies (IAM policies), the only type of policies that AWS CodeCommit supports, the user that the policy is attached to is the implicit principal.

Data sent or received is transmitted using the HTTPS or SSH encrypted network protocols.

The first time you create an AWS CodeCommit repository in a new region in your AWS account, AWS CodeCommit creates an AWS-managed key in that same region in AWS Key Management Service (AWS KMS) that is used only by AWS CodeCommit (the aws/codecommit key). This key is created and stored in your AWS account. AWS CodeCommit uses this AWS-managed key to encrypt and decrypt the data in this and all other AWS CodeCommit repositories within that region in your AWS account.

AWS CodeCommit performs the following AWS KMS actions against the default key aws/codecommit. An IAM user does not need explicit permissions for these actions, but the user must not have any attached policies that deny these actions for the aws/codecommit key
