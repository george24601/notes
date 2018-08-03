variable "region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

#CentOS 1703_01
variable "aws_amis" {
  default = {
    "us-east-1" = "ami-ae7bfdb8"
    "us-east-2" = "ami-9cbf9bf9"
  }
}
