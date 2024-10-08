// Subnets for frontend
// Availibility zone requires at least 2 subnets ie Autoscaling group
variable "public_subnet_cidrs" {
 type        = list(string)
 description = "Public Subnet CIDR values"
 default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
 
// Subnets for backend and database later
// Availibility zone requires at least 2 subnets ie. Autoscaling group
variable "private_subnet_cidrs" {
 type        = list(string)
 description = "Private Subnet CIDR values"
 default     = ["10.0.3.0/24", "10.0.4.0/24",  "10.0.5.0/24",  "10.0.6.0/24", "10.0.7.0/24"]
}

// Availibility zones for autoscaling groups
variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     = ["us-west-2a", "us-west-2b"]
}