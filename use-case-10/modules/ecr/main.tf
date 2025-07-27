resource "aws_ecr_repository" "frontend" {
  name                 = "${var.environment}-frontend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  tags = {
    Name = "${var.environment}-frontend"
  }
}

resource "aws_ecr_repository" "backend" {
  name                 = "${var.environment}-backend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  tags = {
    Name = "${var.environment}-backend"
  }
}

resource "aws_ecr_repository" "auth" {
  name                 = "${var.environment}-auth"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  tags = {
    Name = "${var.environment}-auth"
  }
}

