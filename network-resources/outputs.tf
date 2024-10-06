

output "vpc_id" {
  value = aws_vpc.main.id
}
output "public_subnet_id" {
  value = aws_subnet.public_subnets[*].id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnets[*].id
}
output "internet_gateway" {
    value = aws_internet_gateway.gw.id
}
output "nat_gateway" {
    value = aws_nat_gateway.TF_internet-access.id
}
