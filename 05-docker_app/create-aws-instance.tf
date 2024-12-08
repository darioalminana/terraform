terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "wpt" {
  ami           = "ami-0ca5c3bd5a268e7db"
  instance_type = "t2.micro"
  key_name      = "admin-key"
  vpc_security_group_ids = ["sg-076f53d633906c621","sg-af79cd83"]
  root_block_device {
    volume_size = "10"
    delete_on_termination = "true"
  }
  user_data     = "${file("setup-webtestpage-docker.sh")}"
    tags = {
      Name = "webpagetest"
    }
}
