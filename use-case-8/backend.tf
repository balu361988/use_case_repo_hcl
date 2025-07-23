terraform {
  backend "s3" {
    bucket         = "use-case-backup-file"
    key            = "usecase-8/terraform.tfstate"
    region         = "us-east-1"                
    use_lockfile = true

  }
}
