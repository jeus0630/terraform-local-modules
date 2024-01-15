locals {
  availability_zone = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"]
  count             = var.subnet_count
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name    = "saju-vpc-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = local.count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.${count.index}.0/24"
  availability_zone       = local.availability_zone[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name    = "saju-public-subnet${count.index + 1}-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_subnet" "private_subnet" {
  count                   = local.count
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.${count.index + 2}.0/24"
  availability_zone       = local.availability_zone[count.index + 2]
  map_public_ip_on_launch = true

  tags = {
    Name    = "saju-private-subnet${count.index + 1}-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name    = "saju-igw-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "saju-natgw-eip-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name    = "saju-natgw-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "saju-public-rt-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = {
    Name    = "saju-private-rt-${terraform.workspace}"
    Service = "saju-${terraform.workspace}"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = local.count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_association" {
  count          = local.count
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
