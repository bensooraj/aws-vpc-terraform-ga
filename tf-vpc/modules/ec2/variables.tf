variable "sg_id" {
  description = "The ID of the security group to attach to the instance"
  type        = string
}

variable "subnet_ids" {
  description = "The ID of the subnet to launch the instance into"
  type        = list(string)
}