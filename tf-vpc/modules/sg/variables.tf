variable "vpc_id" {
  description = "VPC ID for the security group"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "all_ipv4_cidr" {
  description = "The CIDR block to denote all IPv4 addresses"
  type        = string
}