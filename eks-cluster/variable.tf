variable "region" {
  default = "ap-south-1"
}

variable "cluster_name" {
  default = "gfg_eks_cluster"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-04076060ef1b01a00", "subnet-0468cd7ad3d43a425"]  # Replace with your actual subnet IDs
}

variable "node_instance_type" {
  default = "t2.micro"
}

