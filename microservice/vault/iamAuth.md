The iam auth method allows you to specify a bound IAM principal ARN. Clients authenticating to Vault must have an ARN that matches the ARN bound to the role they are attempting to login to.


if the bound ARN were arn:aws:iam::123456789012:* it would allow any principal in AWS account 123456789012 to login to it. Similarly, if it were arn:aws:iam::123456789012:role/* it would allow any IAM role in the AWS account to login to it. If you wish to specify a wildcard, you must give Vault iam:GetUser and iam:GetRole permissions to properly resolve the full user path.

vault needs to be able to 

"ec2:DescribeInstances",
        "iam:GetInstanceProfile",
        "iam:GetUser",
        "iam:GetRole"


