/* output "public_subnet1_id" {
  value = aws_subnet.subnets_public["subnet1"].id
}

output "public_subnet2_id" {
  value = aws_subnet.subnets_public["subnet3"].id
}

output "private_subnet1_id" {
  value = aws_subnet.subnets_private["subnet2"].id
}

output "private_subnet2_id" {
  value = aws_subnet.subnets_private["subnet4"].id
} */  

output "endpoint" {
  value = aws_eks_cluster.Devops-eks.endpoint
}

/* output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.Devops-eks.certificate_authority[0].data
} */ 