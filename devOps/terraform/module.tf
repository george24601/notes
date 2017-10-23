#this block can be replaced by environment variables
provider "aws" {
  access_key = "AWS ACCESS KEY"
  secret_key = "AWS SECRET KEY"
  region     = "AWS REGION"
}

#use terraform get to get the module first
module "consul" {
  source = "github.com/hashicorp/consul/terraform/aws"

  key_name = "AWS SSH KEY NAME"
  key_path = "PATH TO ABOVE PRIVATE KEY"
  region   = "us-east-1"
  servers  = "3"
}
