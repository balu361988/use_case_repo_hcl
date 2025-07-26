terraform {
  backend "s3" {
    bucket         = "usecasebackupfile"
    key            = "use-case-10/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}

