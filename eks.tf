module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "16.0.0"

  cluster_name     = "my-eks-cluster"
  cluster_version  = "1.26"

  vpc_id   = module.vpc.vpc_id
  subnets  = module.vpc.private_subnets

  worker_groups = [
    {
      instance_type = "t3.micro"
      asg_max_size  = 3
      asg_min_size  = 1
    }
  ]
}

resource "null_resource" "generate_kubeconfig" {
  triggers = {
    eks_cluster_id = module.eks_cluster.cluster_id
  }

  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${module.eks_cluster.cluster_id} --kubeconfig kubeconfig.yaml --region ${var.region}"
  }
}

output "kubeconfig_path" {
  value = null_resource.generate_kubeconfig.triggers["eks_cluster_id"] != "" ? "./kubeconfig.yaml" : null
}
