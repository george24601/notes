provider "aws" {
  region = "${var.region}"
}

module "key-pair" {
  source  = "cloudposse/key-pair/aws"
  version = "0.3.2"

  name = "${var.cluster_name}"
  namespace = "k8s"
  stage = "prod"
  ssh_public_key_path = "${path.module}/credentials/"
  generate_ssh_key = "true"
  private_key_extension = ".pem"
  chmod_command = "chmod 600 %v"
}

resource "aws_security_group" "ssh" {
  name = "${var.cluster_name}"
  description = "Allow SSH access for bastion instance"
  vpc_id = "${var.create_vpc ? module.vpc.vpc_id : var.vpc_id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = "${var.ingress_cidr}"
  }
 egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "1.60.0"
  name = "${var.cluster_name}"
  cidr = "${var.vpc_cidr}"
  create_vpc = "${var.create_vpc}"
  azs = ["${data.aws_availability_zones.available.names[0]}", "${data.aws_availability_zones.available.names[1]}", "${data.aws_availability_zones.available.names[2]}"]
  private_subnets = "${var.private_subnets}"
  public_subnets = "${var.public_subnets}"
  enable_nat_gateway = true
  single_nat_gateway = true

  # The following tags are required for ELB
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
  vpc_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

module "ec2" {
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "1.21.0"
  name = "${var.cluster_name}-bastion"
  instance_count = "${var.create_bastion ? 1:0}"
  ami = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "${var.bastion_instance_type}"
  key_name = "${module.key-pair.key_name}"
  associate_public_ip_address = true
  monitoring = false
  user_data = "${file("bastion-userdata")}"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
  subnet_ids = "${split(",", var.create_vpc ? join(",", module.vpc.public_subnets) : join(",", var.public_subnet_ids))}"

  tags = {
    app = "tidb"
  }
}

module "eks" {
  # source = "terraform-aws-modules/eks/aws"
  # version = "2.3.1"
  # We can not use cluster autoscaler for pod with local PV due to the limitations listed here:
  # https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/FAQ.md#i-have-a-couple-of-pending-pods-but-there-was-no-scale-up
  # so we scale out by updating auto-scaling-group desired_capacity directly via the patched version of aws eks module
  source = "github.com/tennix/terraform-aws-eks?ref=v2.3.1-patch"
  cluster_name = "${var.cluster_name}"
  cluster_version = "${var.k8s_version}"
  config_output_path = "credentials/"
  subnets = "${split(",", var.create_vpc ? join(",", module.vpc.private_subnets) : join(",", var.private_subnet_ids))}"
  vpc_id = "${var.create_vpc ? module.vpc.vpc_id : var.vpc_id}"

  # instance types: https://aws.amazon.com/ec2/instance-types/
  # instance prices: https://aws.amazon.com/ec2/pricing/on-demand/

  worker_groups = [
    {
      # pd
      name = "pd_worker_group"
      key_name = "${module.key-pair.key_name}"
      # WARNING: if you change instance type, you must also modify the corresponding disk mounting in pd-userdata.sh script
      # instance_type = "c5d.xlarge" # 4c, 8G, 100G NVMe SSD
      instance_type = "${var.pd_instance_type}" # m5d.xlarge 4c, 16G, 150G NVMe SSD
      root_volume_size = "50" # rest NVMe disk for PD data
      public_ip = false
      kubelet_extra_args = "--register-with-taints=dedicated=pd:NoSchedule --node-labels=dedicated=pd,tidbc=dev1"
      asg_desired_capacity = "${var.pd_count}"
      asg_max_size  = "${var.pd_count + 2}"
      additional_userdata = "${file("userdata.sh")}"
    },
    { # tikv
      name = "tikv_worker_group"
      key_name = "${module.key-pair.key_name}"
      # WARNING: if you change instance type, you must also modify the corresponding disk mounting in tikv-userdata.sh script
      instance_type = "${var.tikv_instance_type}" # i3.2xlarge 8c, 61G, 1.9T NVMe SSD
      root_volume_type = "gp2"
      root_volume_size = "100"
      public_ip = false
      kubelet_extra_args = "--register-with-taints=dedicated=tikv:NoSchedule --node-labels=dedicated=tikv,tidbc=dev1"
      asg_desired_capacity = "${var.tikv_count}"
      asg_max_size = "${var.tikv_count + 2}"
      additional_userdata = "${file("userdata.sh")}"
    },
    { # tidb
      name = "tidb_worker_group"
      key_name = "${module.key-pair.key_name}"
      instance_type = "${var.tidb_instance_type}" # c5.4xlarge 16c, 30G
      root_volume_type = "gp2"
      root_volume_size = "100"
      public_ip = false
      kubelet_extra_args = "--register-with-taints=dedicated=tidb:NoSchedule --node-labels=dedicated=tidb,tidbc=dev1"
      asg_desired_capacity = "${var.tidb_count}"
      asg_max_size = "${var.tidb_count + 2}"
    },
    { # monitor
      name = "monitor_worker_group"
      key_name = "${module.key-pair.key_name}"
      instance_type = "${var.monitor_instance_type}" # c5.xlarge 4c, 8G
      root_volume_type = "gp2"
      root_volume_size = "100"
      public_ip = false
      asg_desired_capacity = 2
      asg_max_size = 3
    }
    ,{
      # pd
      name = "pd2_worker_group"
      key_name = "${module.key-pair.key_name}"
      # WARNING: if you change instance type, you must also modify the corresponding disk mounting in pd-userdata.sh script
      # instance_type = "c5d.xlarge" # 4c, 8G, 100G NVMe SSD
      instance_type = "${var.pd_instance_type}" # m5d.xlarge 4c, 16G, 150G NVMe SSD
      root_volume_size = "50" # rest NVMe disk for PD data
      public_ip = false
      kubelet_extra_args = "--register-with-taints=dedicated=pd:NoSchedule --node-labels=dedicated=pd,tidbc=dev2"
      asg_desired_capacity = "${var.pd_count}"
      asg_max_size  = "${var.pd_count + 2}"
      additional_userdata = "${file("userdata.sh")}"
    }
 ,{ # tikv
      name = "tikv2_worker_group"
      key_name = "${module.key-pair.key_name}"
      # WARNING: if you change instance type, you must also modify the corresponding disk mounting in tikv-userdata.sh script
      instance_type = "${var.tikv_instance_type}" # i3.2xlarge 8c, 61G, 1.9T NVMe SSD
      root_volume_type = "gp2"
      root_volume_size = "100"
      public_ip = false
      kubelet_extra_args = "--register-with-taints=dedicated=tikv:NoSchedule --node-labels=dedicated=tikv,tidbc=dev2"
      asg_desired_capacity = "${var.tikv_count}"
      asg_max_size = "${var.tikv_count + 2}"
      additional_userdata = "${file("userdata.sh")}"
    },
 { # tidb
      name = "tidb2_worker_group"
      key_name = "${module.key-pair.key_name}"
      instance_type = "${var.tidb_instance_type}" # c5.4xlarge 16c, 30G
      root_volume_type = "gp2"
      root_volume_size = "100"
      public_ip = false
      kubelet_extra_args = "--register-with-taints=dedicated=tidb:NoSchedule --node-labels=dedicated=tidb,tidbc=dev2"
      asg_desired_capacity = "${var.tidb_count}"
      asg_max_size = "${var.tidb_count + 2}"
    }
  ]


  worker_group_count = "7"

  tags = {
    app = "tidb"
  }
}

# kubernetes and helm providers rely on EKS, but terraform provider doesn't support depends_on
# follow this link https://github.com/hashicorp/terraform/issues/2430#issuecomment-370685911
# we have the following hack
resource "local_file" "kubeconfig" {
  # HACK: depends_on for the helm and kubernetes provider
  # Passing provider configuration value via a local_file
  depends_on = ["module.eks"]
  sensitive_content = "${module.eks.kubeconfig}"
  filename = "${path.module}/credentials/kubeconfig_${var.cluster_name}"
}

# kubernetes provider can't use computed config_path right now, see issue:
# https://github.com/terraform-providers/terraform-provider-kubernetes/issues/142
# so we don't use kubernetes provider to retrieve tidb and monitor connection info,
# instead we use external data source.
# provider "kubernetes" {
#   config_path = "${local_file.kubeconfig.filename}"
# }
