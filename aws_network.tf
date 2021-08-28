provider "aws" {
  region  = "ap-south-1"
  profile = "myaws"
}

resource "aws_vpc" "terraform-vpc" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "terraform-demo-vpc"
  }
}

output "aws_vpc_id" {
  value = aws_vpc.terraform-vpc.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "my-test-igw"
  }
}

resource "aws_security_group" "terraform_private_sg" {
  description = "Allow limited inbound external traffic"
  vpc_id      = aws_vpc.terraform-vpc.id
  name        = "terraform_ec2_private_sg"

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
  }
ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    to_port     = 8080
  }

  ingress {
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
  }

  egress {
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }

  tags = {
    Name = "ec2-private-sg"
  }
}
output "aws_security_gr_id" {
  value = aws_security_group.terraform_private_sg.id
}

## Create Subnets ##
resource "aws_subnet" "terraform-subnet_1" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "172.16.10.0/24"
tags = {
    Name = "terraform-subnet_1"
  }
}

output "aws_subnet_subnet_1" {
  value = aws_subnet.terraform-subnet_1.id
}

resource "aws_network_interface" "terraform_network_interface" {
  subnet_id       = aws_subnet.terraform-subnet_1.id
  security_groups = [aws_security_group.terraform_private_sg.id]

}

resource "aws_instance" "terraform_wapp" {
  ami                         = "ami-06a0b4e3b7eb7a300"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["${aws_security_group.terraform_private_sg.id}"]
  subnet_id                   = aws_subnet.terraform-subnet_1.id
  key_name                    = "demo"
  count                       = 1
  associate_public_ip_address = true
  tags = {
    Name        = "terraform_ec2_wapp_awsdev"
    Environment = "development"
    Project     = "DEMO-TERRAFORM"
  }
}

output "instance_id_list" { value = ["${aws_instance.terraform_wapp.*.id}"] }


  
  
  
  
