variable "cidr_block" {
  type        = string
  description = "CIDR Block for the VPC"
}

variable "public_subnet_a_cidr" {
  type        = string
  description = "Public Subnet A CIDR Block"
}

variable "public_subnet_b_cidr" {
  type        = string
  description = "Public Subnet B CIDR Block"
}

variable "private_subnet_a_cidr" {
  type        = string
  description = "Private Subnet A CIDR Block"
}

variable "private_subnet_b_cidr" {
  type        = string
  description = "Private Subnet B CIDR Block"
}