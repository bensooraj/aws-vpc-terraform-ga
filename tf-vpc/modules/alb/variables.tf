variable "sg_id" {
    description = "The security group ID to attach to the ALB"
    type = string
}

variable "subnet_ids" {
    description = "The subnet IDs to attach to the ALB"
    type = list(string)
}

variable "vpc_id" {
    description = "The VPC ID to attach to the ALB"
    type = string
}

variable "instance_ids" {
    description = "The instance IDs to attach to the ALB"
    type = list(string)
}