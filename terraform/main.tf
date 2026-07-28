terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# =========================================
# WEB SERVER EC2
# =========================================

resource "aws_instance" "web_server" {

  ami                         = "ami-0f58b397bc5c1f2e8"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.web_public_1.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]

  associate_public_ip_address = true

  key_name = "Suriya-key"

  tags = {
    Name = "web-server"
  }

  lifecycle {
    ignore_changes = [
      ami,
      tags
    ]
  }
}

# =========================================
# APP SERVER EC2
# =========================================

resource "aws_instance" "app_server" {

  ami                    = "ami-0f58b397bc5c1f2e8"
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.app_private_1.id
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  key_name = Suriya-key"

  tags = {
    Name = "app-server"
  }

  lifecycle {
    ignore_changes = [
      ami,
      tags
    ]
  }
}
