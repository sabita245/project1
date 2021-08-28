provider "aws" {
  region = "us-east-2"
}
provider "aws" {
  region = "us-east-1"
  alias  = "virginia"
}

resource "aws_instance" "ohio" {
  ami           = "ami-0ba62214afa52bec7"
  instance_type = "t2.micro"
  tags = {
    "Name" = "hello-ohio"
  }
}
resource "aws_instance" "usa" {
  ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  provider      = aws.virginia
  tags = {
    "Name" = "hello-virginia"
  }
}
