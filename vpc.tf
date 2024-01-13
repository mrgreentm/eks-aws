resource "aws_vpc" "minha_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.prefix}-VPC-fc"
  }
}

data "aws_availability_zones" "available" {}
resource "aws_subnet" "subnets" {
  count = 2
  availability_zone =  data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.minha_vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.prefix}-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "new-internet-gateway" {
  vpc_id = aws_vpc.minha_vpc.id
  tags = {
    Name = "${var.prefix}-igw"
  } 
}

resource "aws_route_table" "new-route-table" {
  vpc_id = aws_vpc.minha_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.new-internet-gateway.id
  }
  tags = {
    Name = "${var.prefix}-rtb"
  }
}