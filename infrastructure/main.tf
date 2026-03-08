terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# Create Security Group with HTTP and SSH rules
resource "aws_security_group" "portfolio_web_sg" {
  name        = "portfolio-web-sg-${random_string.suffix.result}"
  description = "Security group with HTTP and SSH access"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "aws_instance" "web_server" {
  ami                    = "ami-02b8269d5e85954ef" 
  instance_type          = var.instance_type
  key_name               = "Nishant-ubuntu" # Note: Ensure students use their own key pair name here
  vpc_security_group_ids = [aws_security_group.portfolio_web_sg.id]

  tags = {
    Name = "Portfolio-Automated-EC2"
  }
}

output "instance_public_ip" {
  value = aws_instance.web_server.public_ip
}