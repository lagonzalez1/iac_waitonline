

variable "security_group_id" {
  description = "ID of the security group to attach to the launch template"
  type        = string
}

variable "iam_instance_profile_name" {
    description = "IAM profile for appropriate permissions"
    type        = string
}

variable "public_subnet_id_array" {
    description = "Public subnet list from VPC"
    type        = list(string)
}