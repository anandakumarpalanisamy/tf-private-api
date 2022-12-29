resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_internet_gateway_attachment" "igw_attachment" {
  vpc_id              = aws_vpc.main.id
  internet_gateway_id = aws_internet_gateway.igw.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_a_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet_b_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
}

resource "aws_route_table" "public_subnet_a_route_table" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_subnet_b_route_table" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "private_subnet_a_route_table" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "private_subnet_b_route_table" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "public_subnet_a_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_subnet_a_route_table.id
}

resource "aws_route_table_association" "public_subnet_b_route_table_association" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_subnet_b_route_table.id
}

resource "aws_route_table_association" "private_subnet_a_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_subnet_a_route_table.id
}

resource "aws_route_table_association" "private_subnet_b_route_table_association" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_subnet_b_route_table.id
}

resource "aws_route" "public_subnet_a_routes" {
  route_table_id         = aws_route_table.public_subnet_a_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "public_subnet_b_routes" {
  route_table_id         = aws_route_table.public_subnet_b_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private_subnet_a_routes" {
  route_table_id = aws_route_table.private_subnet_a_route_table.id

}

resource "aws_route" "private_subnet_b_routes" {
  route_table_id = aws_route_table.private_subnet_b_route_table.id

}

resource "aws_security_group" "allow_tls_ingress_to_private_subnet" {
  name        = "allow_tls"
  description = "Allow TLS Inbound Traffic"
  vpc_id      = aws_vpc.main.id

  ingress = [{
    cidr_blocks = [aws_vpc.main.cidr_block]
    description = "Inbound TLS"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }]

  egress = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outgoing Traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }]
}

resource "aws_security_group" "all_outbound_traffic" {
  name        = "all_outbound"
  description = "Allow Outbound Traffic"
  vpc_id      = aws_vpc.main.id

  egress = [{
    cidr_blocks = ["0.0.0.0/0"]
    description = "Outgoing Traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }]
}

data "aws_region" "current" {}

resource "aws_vpc_endpoint" "amazon_api_gateway_vpce" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${data.aws_region.current.name}.execute-api"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  subnet_ids         = [aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id]
  security_group_ids = [aws_security_group.allow_tls_ingress_to_private_subnet.id]
}