resource "aws_eip" "eip_for_nat_gateway" {
  count     = length(var.public_subnet_ids)
  domain    = "vpc"

  tags = {
    Name = "Nat eip ${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count          = length(var.public_subnet_ids)
  allocation_id = aws_eip.eip_for_nat_gateway[count.index].id
  subnet_id     = var.public_subnet_ids[count.index]

  tags = {
    Name = "Nat Gateway ${count.index + 1}"
  }

  depends_on = [var.internet_gateway]
}

resource "aws_route_table" "private_route_table" {
  count     = length(var.private_subnet_ids)
  vpc_id    = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name = "Private Route table ${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_subnet_route_table_association" {
  count         = length(var.private_subnet_ids)
  subnet_id     = var.private_subnet_ids[count.index]
  route_table_id = aws_route_table.private_route_table[count.index].id
}