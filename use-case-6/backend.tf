terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket = "usecasefiles"
    key    = "usecase6/terraform.tfstate"
    region = "ap-south-1"
  }
}
