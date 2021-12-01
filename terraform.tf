provider "aws" {
  region     = "us-east-1"
  access_key = "AKIARC5WYXMBHMCY5ZB4"
  secret_key = "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"
}
resource "aws_instance" "instance1" {
  ami           = "ami-04902260ca3d33422"
  instance_type = "t2.micro"
}
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.18.2"
    }
  }
}

provider "github" {
  token = "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"
}
resource "github_repository" "example" {
  name        = "terraform-repo"
  description = "My awesome codebase"

  visibility = "private"

}
