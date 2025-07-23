terraform {
  backend "s3" {
    bucket         = "usecasebackupfiles.tf"
    key            = "use-case-7/dev/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "terraform-lock-table"
  }
}

