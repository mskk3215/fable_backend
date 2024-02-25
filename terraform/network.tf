# ----------------------
# VPC
# ----------------------
resource "aws_vpc" "vpc" {
  cidr_block                       = "10.0.0.0/19"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  assign_generated_ipv6_cidr_block = false
  tags = {
    Name    = "${var.project}-${var.environment}-vpc"
    Project = var.project
    Env     = var.environment
  }
}
# ----------------------
# subnets
# ----------------------
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true #自動割り当てIP設定
  tags = {
    Name    = "${var.project}-${var.environment}-public-subnet-1a"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}
resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name    = "${var.project}-${var.environment}-public-subnet-1c"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}
resource "aws_subnet" "public_subnet_1d" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1d"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name    = "${var.project}-${var.environment}-public-subnet-1d"
    Project = var.project
    Env     = var.environment
    Type    = "public"
  }
}
resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name    = "${var.project}-${var.environment}-private-subnet-1a"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}
resource "aws_subnet" "private_subnet_1c" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1c"
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name    = "${var.project}-${var.environment}-private-subnet-1c"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}
resource "aws_subnet" "private_subnet_1d" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1d"
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = false
  tags = {
    Name    = "${var.project}-${var.environment}-private-subnet-1d"
    Project = var.project
    Env     = var.environment
    Type    = "private"
  }
}
