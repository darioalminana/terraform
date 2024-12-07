terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}

provider "aws" {
  region  = "us-west-2"
  access_key = "CHANGE ME"
  secret_key = "CHANGE ME"
}

resource "aws_instance" "wpt" {
  ami           = "ami-055e3d4f0bbeb5878"
  instance_type = "t2.micro"
  subnet_id        = "subnet-073aa4fcf235ba614"
}