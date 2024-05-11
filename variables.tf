variable "subnet_id" {
  description = "Public Subnet where bastion will live"
  type        = string
}
variable "key_pair_name" {
  type    = string
  default = null
}
variable "name" {
  description = "Name for ec2 instance. also is prefix for SG"
  default     = "Bastion"
  type        = string
}

variable "ami" {
  description = "Use a custom ami"
  default     = null
  type        = string
}
variable "tags" {
  default = null
}

variable "associate_public_ip_address" {
  description = "If true this module will create an ec2 instance as bastion. If false just create a local-network instance"
  default     = true
  type        = bool
}

variable "security_groups" {
  description = "List of security groups to attach to the instance"
  type        = list(string)
  default     = []
}