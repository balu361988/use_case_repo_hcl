terraform {
  backend "s3" {
    bucket         = "use-case-backup-file"
    key            = "use-case-8/terraform.tfstate"
    region         = "ap-south-1"                
    use_lockfile = true

  }
}
