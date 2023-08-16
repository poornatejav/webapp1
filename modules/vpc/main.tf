resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc_cidr 
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "${var.project}-vpc"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = aws_vpc.vpc.id

  tags      = {
    Name    = "${var.project}-igw"
  }
}

data "aws_availability_zones" "available_zones" {}

# resource "aws_subnet" "public_subnet" {
#   vpc_id    = aws_vpc.vpc.id
#   cidr_block              = var.public_cidr 
#   availability_zone       = data.aws_availability_zones.available_zones.names[0]
#   map_public_ip_on_launch = true

#   tags      = {
#     Name    = "public subnet"
#   }
# }


# resource "aws_route_table" "public_route_table" {
#   vpc_id    = aws_vpc.vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.internet_gateway.id
#   }

#   tags       = {
#     Name     = "public route table"
#   }
# }

# resource "aws_route_table_association" "public_subnet_route_table_association" {
#   subnet_id           = aws_subnet.public_subnet.id
#   route_table_id      = aws_route_table.public_route_table.id
# }


# resource "aws_subnet" "private_subnet" {
#   vpc_id    = aws_vpc.vpc.id
#   cidr_block               = var.private_cidr
#   availability_zone        = data.aws_availability_zones.available_zones.names[1]
#   map_public_ip_on_launch  = false

#   tags      = {
#     Name    = "private subnet"
#   }
# }


resource "aws_subnet" "public_subnet" {
  count      = length(var.public_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_cidr[count.index]
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_${count.index}"
  }
}

resource "aws_route_table" "public_route_table" {
  count = length(var.public_cidr)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "public_route_table_${count.index}"
  }
}

resource "aws_route_table_association" "public_subnet_route_table_association" {
  count       = length(var.public_cidr)
  subnet_id   = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table[count.index].id
}

resource "aws_subnet" "private_subnet" {
  count      = length(var.private_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_cidr[count.index]
  availability_zone = data.aws_availability_zones.available_zones.names[count.index]

  tags = {
    Name = "private_subnet_${count.index}"
  }
}