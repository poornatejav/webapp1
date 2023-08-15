resource "aws_eip" "eip_for_nat_gateway" {
  domain    = "vpc"

  tags   = {
    Name = "Nat eip"
  }
}


resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_for_nat_gateway.id
  subnet_id     = var.public_subnet_id

  tags   = {
    Name = "Nat Gateway"
  }

  depends_on = [var.internet_gateway]
}

resource "aws_route_table" "private_route_table" {
  vpc_id            = var.vpc_id

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway.id
  }

  tags   = {
    Name = "Private Route table"
  }
}

resource "aws_route_table_association" "private_subnet_route_table_association" {
  subnet_id         = var.private_subnet_id
  route_table_id    = aws_route_table.private_route_table.id
}



