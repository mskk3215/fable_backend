# ----------------------
# Terraform configuration
# ----------------------
terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }

}
# ----------------------
# Provider
# ----------------------
provider "aws" {
  profile = "fable"
  region  = "ap-northeast-1"
}
provider "aws" {
  alias   = "virginia"
  profile = "fable"
  region  = "us-east-1"
}
# ----------------------
# Variables
# ----------------------
variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "domain" {
  type = string
}
