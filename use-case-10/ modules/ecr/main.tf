resource "aws_ecr_repository" "patient" {
  name = "patient-service"
}

resource "aws_ecr_repository" "appointment" {
  name = "appointment-service"
}

output "ecr_patient_url" {
  value = aws_ecr_repository.patient.repository_url
}

output "ecr_appointment_url" {
  value = aws_ecr_repository.appointment.repository_url
}
