variable "lambda_function_name" {
  type        = string
  description = "Name of lambda function"
}

variable "handler" {
  type        = string
  default     = "index.handler"
  description = "name of the lambda handler function"
}

variable "runtime" {
  type        = string
  default     = "nodejs18.x"
  description = "runtime of the lambda function"
}