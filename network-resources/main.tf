
// Create internet gateway for project
resource "aws_vpc" "main" {
 cidr_block = "10.0.0.0/16"
 
 tags = {
   Name = "TF-waitonline"
 }
}

// Public subnet for frontend deployment
resource "aws_subnet" "public_subnets" {
 count              = length(var.public_subnet_cidrs)
 vpc_id             = aws_vpc.main.id
 cidr_block         = element(var.public_subnet_cidrs, count.index)
 availability_zone  = element(var.azs, count.index)
 tags = {
   Name = "Public Subnet ${count.index + 1}"
 }
}
// Private subnet for backend deployment, backend and database layer
resource "aws_subnet" "private_subnets" {
 count              = length(var.private_subnet_cidrs)
 vpc_id             = aws_vpc.main.id
 cidr_block         = element(var.private_subnet_cidrs, count.index)
 availability_zone  = element(var.azs, count.index)
 tags = {
   Name = "Private Subnet ${count.index + 1}"
 }
}

// Create a internet gateway with the aws_vpc id linking 
resource "aws_internet_gateway" "gw" {
 vpc_id = aws_vpc.main.id
 tags = {
   Name = "TF-internet-gateway"
 }
}

// Create a route table to allow traffic from 0.0.0.0/0 (Anywhere) to the VPC
// Assign public network traffic to gateway
resource "aws_route_table" "public_tb" {
 vpc_id = aws_vpc.main.id
 
 // Route from 0.0.0.0/0 to my internet gateway
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }
 tags = {
   Name = "Public Route Table"
 }
}

// Create a route table for private subnets
// Assign public network traffic to gateway
resource "aws_route_table" "private_tb" {
 vpc_id = aws_vpc.main.id
 
 // Route from 0.0.0.0/0 to my internet gateway
 route {
   cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
 }
 tags = {
   Name = "Private Route Table"
 }
}

// NAT gateway requires a elastic ip for public facing gatways
resource "aws_eip" "lb" {
  domain   = "vpc"
}

// Associate explicit subnets to public route tabe "public_tb"
// This should hold frontend_1, frontend_2
resource "aws_route_table_association" "public_subnet_asso" {
 count = length(var.public_subnet_cidrs)
 subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
 route_table_id = aws_route_table.public_tb.id
}

// Associate explicit subnets to private route tabe "private_tb"
// This should hold business_backend_1, business_backend_2, client_backend_1, client_backend_2, database_1
resource "aws_route_table_association" "private_subnet_asso" {
 count = length(var.private_subnet_cidrs)
 subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
 route_table_id = aws_route_table.private_tb.id
}

// Associate aws_subnets directly from "aws_subnet" "public_subnets". Using the first subnet id.
resource "aws_nat_gateway" "TF_internet-access" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.public_subnets[0].id
  tags = {
    Name = "gw NAT"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  # Added internet gateway from 
  depends_on = [aws_internet_gateway.gw]
}







