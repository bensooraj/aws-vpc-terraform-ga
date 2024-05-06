variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidrs" {
  description = "The CIDR blocks for the subnets"
  type        = list(string)
}

variable "subnet_names" {
  description = "The names for the subnets"
  type        = list(string)
  default     = ["public-subnet-1", "public-subnet-2"]
}
