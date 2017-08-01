provider "aws" {
  region     = "${var.region}"
}

resource "aws_instance" "example" {
 # ami           = "ami-2757f631"
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
}
