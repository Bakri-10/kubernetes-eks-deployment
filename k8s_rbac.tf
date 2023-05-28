resource "kubernetes_cluster_role_binding" "admin_binding" {
  metadata {
    name = "admin-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }

  subject {
    kind      = "User"  # Change to "Group" if using a group
    name      = "YOUR_IDENTITY"  # Replace with identity (IAM user or role ARN)
    api_group = "rbac.authorization.k8s.io"
  }
}
