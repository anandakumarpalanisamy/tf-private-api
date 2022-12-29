provider "aws" {
  region     = "eu-west-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  default_tags {
    tags = {
      Environment = "Test"
      Name        = "Private API"
    }
  }
}

module "vpc" {
  source = "./modules/vpc"

  cidr_block            = var.cidr_block
  public_subnet_a_cidr  = var.public_subnet_a_cidr
  public_subnet_b_cidr  = var.public_subnet_b_cidr
  private_subnet_a_cidr = var.private_subnet_a_cidr
  private_subnet_b_cidr = var.private_subnet_b_cidr
}

module "lambda" {
  source = "./modules/lambda"

  lambda_function_name = var.lambda_function_name
}

module "api-gateway" {
  source = "./modules/api-gateway"

  rest_api_name        = var.rest_api_name
  lambda_function_name = var.lambda_function_name
  lambda_function_arn  = module.lambda.lambda_function_arn
  rest_api_stage_name  = var.rest_api_stage_name
}