output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "region" {
  value = var.region
}

output "project" {
  value = var.project
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet[*].id
}

output "internet_gateway" {
  value = aws_internet_gateway.internet_gateway
}
