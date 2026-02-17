output "cluster_name" {
  value = module.eks.cluster_name
}

output "repository_url" {
  value = aws_ecr_repository.nodejs_app.repository_url
}
