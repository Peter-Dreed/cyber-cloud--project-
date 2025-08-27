resource "aws_vpc" "spring_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "Springboot_VPC" {
  vpc_id = aws_vpc.spring_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_subnet" "public" {
    vpc_id            = aws_vpc.spring_vpc.id
    cidr_block        = var.public_subnet_cidr
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.vpc_name}-public-subnet"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.spring_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Springboot_VPC.id
    }

    tags = {
        Name = "${var.vpc_name}-public-route-table"
    }
}   

resource "aws_route_table_association" "public" {
    subnet_id      = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}