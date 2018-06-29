efs filesystem - creation token

efs mount target - file system id, subnet id

need to access efs from vpc private subnets

efs dns name, mount point = /efs

for jenkins: host_path:  host_path = /efs/jenkins_home

EBS
--------
After you create a volume, you can attach it to any EC2 instance in the same Availability Zone.

The instance can format the EBS volume with a file system, such as ext3, and then install applications.

