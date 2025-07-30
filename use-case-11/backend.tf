terraform {
  backend "s3" {
    bucket  = "usecasebackupfile-1"
    key     = "usecase-11-hcl/terraform.tfstate"
    region  = "us-east-1"
  }
}
