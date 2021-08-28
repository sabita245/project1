provider "aws" {
  region  = "ap-south-1"
  profile = "myaws"
}
resource "aws_default_vpc" "main" {
   tags = {
    Name = "main"
  }
}
resource "aws_instance" "terraform_ec2" {
  ami             = "ami-06a0b4e3b7eb7a300"
  instance_type   = "t2.micro"
  security_groups = [ "${aws_security_group.my_security_group.name}" ]
  tags = {
    Name = "terraform_ec2"
  }

}
resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "creating one security group"
  vpc_id      = aws_default_vpc.main.id

  ingress {
    description = "inbound from vpc"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.main.cidr_block]
  }

  ingress {
    description = "inbound http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.main.cidr_block]
}
ingress {
    description = "inbound ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "my_security_group"
    instance_name = "terraform_ec2"
  }
}
