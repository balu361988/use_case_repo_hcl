resource "aws_ecr_repository" "patient" {
  name                 = var.patient_repo
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "patient-ecr"
  }
}

resource "aws_ecr_repository" "appointment" {
  name                 = var.appointment_repo
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Name = "appointment-ecr"
  }
}
