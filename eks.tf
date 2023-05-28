module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "16.0.0"

  cluster_name     = "my-eks-cluster"
  cluster_version  = "1.26"

  vpc_id = module.vpc.vpc_id

  subnets = module.vpc.private_subnets

  worker_groups = [
    {
      instance_type = "t3.micro"
      asg_max_size  = 3
      asg_min_size  = 1
    }
  ]

  kubeconfig_aws_authenticator_additional_args = ["--disable-prompt"]
  config_output_path                          = "./kubeconfig.yaml"

  enable_irsa = true

  tags = {
    Name = "my-eks-cluster"
  }
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks_cluster.cluster_certificate_authority_data
}

output "aws_authenticator_token" {
  value = module.eks_cluster.aws_authenticator_token
}
