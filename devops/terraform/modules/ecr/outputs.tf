output "url" {
  description = "The public url for this repository"
  value       = aws_ecr_repository.main.repository_url
}
