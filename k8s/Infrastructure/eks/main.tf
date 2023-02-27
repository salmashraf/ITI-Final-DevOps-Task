 

resource "aws_iam_role" "eksrole" {
 name = var.master-role

 
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}



resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role    = aws_iam_role.eksrole.name
}
/* resource "aws_iam_role_policy_attachment" "eksrole-AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.eksrole.name
} */ 

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eksrole.name
}

resource "aws_eks_cluster" "Devops-eks" {
 name = var.master
 role_arn = aws_iam_role.eksrole.arn

 vpc_config {
  subnet_ids   = var.priv_subnet_ids
   endpoint_public_access  = true
   endpoint_private_access = true
   public_access_cidrs = ["0.0.0.0/0"]
 }

 depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
 ]
}




#---------------------------------------------------------------------------------



resource "aws_iam_role" "eks-node-group" {
  name = "eks-node-group"


  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group.name
}



#------------------------------------------------------------------------
resource "aws_eks_node_group" "worker-node-cluster" {
  cluster_name  = aws_eks_cluster.Devops-eks.name
  node_group_name = var.nodes_name
  node_role_arn  = aws_iam_role.eks-node-group.arn
  subnet_ids   = var.priv_subnet_ids

  instance_types = ["t3.small"]
 
  scaling_config {  # 3 for best practice
   desired_size = 1
   max_size   = 2
   min_size   = 1
  }
  capacity_type  = "ON_DEMAND"

  update_config {
    max_unavailable = 1
  }
  
  remote_access {
    ec2_ssh_key = "ansible-key"
  }

  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }
