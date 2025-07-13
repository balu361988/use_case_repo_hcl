terraform {
  backend "s3" {
    bucket       = "usecasefiles"
    key          = "use-case-3-backend-file/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}
