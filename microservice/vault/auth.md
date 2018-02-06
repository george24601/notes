. Based on how you attempt to authenticate, Vault will determine if you are attempting to use the ec2 or iam type.

The ec2 auth method authenticates only AWS EC2 instances and is specialized to handle EC2 instances, such as restricting access to EC2 instances from a particular AMI, EC2 instances in a particular instance profile, or EC2 instances with a specialized tag value (via the role_tag feature).


###IAM Auth####


