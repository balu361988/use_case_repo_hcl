terraform {
  backend "s3" {
    bucket  = "usecasebackupfile"
    key     = "usecase-11-hcl/terraform.tfstate"
    region  = "us-east-1"
  }
}
