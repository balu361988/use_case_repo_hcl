output "cluster_name" {
  value = aws_eks_cluster.gfg_cluster.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.gfg_cluster.endpoint
}

