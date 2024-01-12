resource "aws_vpc" "minha_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-fc"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.minha_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "Main"
  }
}
