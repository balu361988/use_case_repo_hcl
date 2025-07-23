terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket = "usecasefiles"
    key    = "use_case_4/terraform.tfstate"
    region = "ap-south-1"
  }
}

