variable "rest_api_name" {
  type        = string
  description = "Name of the REST API"
}

variable "lambda_function_name" {
  type        = string
  description = "Name of lambda function"
}

variable "lambda_function_arn" {
  type        = string
  description = "arn of the lambda function"
}

variable "rest_api_stage_name" {
  type        = string
  description = "stage name of the rest api"
}

variable "vpce_id" {
  type        = string
  description = "VPC Endpoint ID for the API Gateway"
}