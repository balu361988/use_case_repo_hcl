provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket         = "hclterraformbackend"
    key            = "vpc-project/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                 = ["ap-south-1a", "ap-south-1b"]
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP and SSH"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = "ami-021a584b49225376d" 
  instance_type      = "t2.micro"
  subnet_ids         = module.vpc.public_subnets
  key_name           = "mumbai-new-aws-key" 
  security_group_id  = aws_security_group.web_sg.id
}

module "rds" {
  source           = "./modules/rds"
  private_subnets  = module.vpc.private_subnets
  vpc_id           = module.vpc.vpc_id
  web_sg_id        = aws_security_group.web_sg.id
  db_username      = var.db_username
  db_password      = var.db_password
}
