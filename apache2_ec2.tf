provider "aws" {
region = "ap-south-1"
profile = "myaws"
}

resource "aws_instance" "myinstance" {
  ami           = "ami-06a0b4e3b7eb7a300"
  instance_type = "t2.micro"
  tags = {
    Name = "My first terraform instance"
  }
  vpc_security_group_ids = [ "sg-17feba68" ]
  user_data = "${file("install_apache.sh")}"
  key_name = "demo"
}
