output "frontend_repo_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "backend_repo_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "auth_repo_url" {
  value = aws_ecr_repository.auth.repository_url
}

