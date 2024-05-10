variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "The CIDR blocks for the subnets"
  type        = list(string)
}

variable "all_ipv4_cidr" {
  description = "The CIDR block to denote all IPv4 addresses"
  type        = string
}