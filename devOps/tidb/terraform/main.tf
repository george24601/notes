provider "aws" {
  region     = "${var.region}"
}

#PD has no persistant state, so we use instance store
resource "aws_instance" "pd" {
  instance_type = "c3.large"
  ami           = "${lookup(var.aws_amis, var.region)}"
}

/*
resource "aws_instance" "tikv" {
  instance_type = "m1.small"
  ami           = "${lookup(var.aws_amis, var.region)}"

  # This will create 3 instances
  count = 3
}
*/
