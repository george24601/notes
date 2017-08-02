provider "aws" {
  region     = "${var.region}"
}

# Our default security group to access
# the instances over SSH and HTTP
resource "aws_security_group" "default" {
  name        = "terraform_example"
  description = "Used in the terraform"
#  vpc_id      = "${aws_vpc.default.id}"

  # SSH access from anywhere
  ingress {
    from_port   = 0 
    to_port     = 0 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

#TODO: add specific access

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



#PD has no persistant state, so we use instance store
resource "aws_instance" "pd" {
  instance_type = "c3.large"
  ami           = "${lookup(var.aws_amis, var.region)}"
}
