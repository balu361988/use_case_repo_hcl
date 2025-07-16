terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.0.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}
