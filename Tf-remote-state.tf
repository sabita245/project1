terraform {
  backend "s3" {
    bucket  = "myawsbucket-de"
    key     = "dev/network/terraform.tfstate"
    region  = "ap-south-1"
    profile = "myaws"
  }
}

provider "aws" {
  profile = "myaws"
  region  = "ap-south-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "terraform_vpc"
  }
}
data "aws_availability_zones" "available" {}

output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}
