terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-2"
}


variable "vpc_id" {}

variable "key_name" {
  description = "key pair name from AWS"
  type = string
}

variable "ingress_ip" {
  description = "ip address cidr block that is allowed to access the created EC2 instance"
  type = string
}

resource "aws_security_group" "test_group" {
  name = "test_ec2_access"
  vpc_id = var.vpc_id
  
  tags = {
    Name = "SEQAX409"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ingress_ip]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name = "name"
    values = ["debian-12-amd64-*"]
  }

  owners = ["amazon"]
}


resource "aws_instance" "app_server" {
  ami           = data.aws_ami.debian.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.test_group.id]
  key_name = var.key_name

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

output "hostid" {
  value = aws_instance.app_server.*.public_dns
}
