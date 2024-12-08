terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}

provider "aws" {
  region     = "us-west-2"
  access_key = var.access_key
  secret_key = var.secret_key
}

locals {
  tag = "Tf-test-resource"
}

resource "aws_instance" "wpt" {
  for_each                    = var.service_names
  ami                         = "ami-055e3d4f0bbeb5878"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.terraform-sg.security_group_id]
  associate_public_ip_address = true
  tags = {
    Type = local.tag
    Name = "EC2-${each.key}"
  }
}

resource "aws_cloudwatch_log_group" "ec2_log_group" {
  for_each = var.service_names
  tags = {
    Environment = "Tf-test"
    Service     = each.key
  }
  lifecycle {
    create_before_destroy = true
  }
}