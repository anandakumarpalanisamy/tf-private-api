variable "aws_access_key" {
  description = "access key for aws"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "secret key for aws"
  type        = string
  sensitive   = true
}

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

variable "rest_api_name" {
  type        = string
  description = "Name of the REST API"
}

variable "lambda_function_name" {
  type        = string
  description = "Name of lambda function"
}

variable "rest_api_stage_name" {
  type        = string
  description = "stage name of the rest api"
}