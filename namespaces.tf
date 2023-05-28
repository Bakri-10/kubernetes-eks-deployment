resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev"
  }
}

resource "kubernetes_namespace" "prod" {
  metadata {
    name = "prod"
  }

  depends_on = [module.eks_cluster]  # Wait for EKS cluster creation
}
