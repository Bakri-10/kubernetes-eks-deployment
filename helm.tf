resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  version    = "6.20.3"

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "aws.region"
    value = "us-west-2"
  }

  debug = true  # Enable debug mode for the Helm release
}

resource "helm_release" "nginx" {
  name       = "nginx-release"
  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"
  version    = "0.16.1"

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  debug = true  # Enable debug mode for the Helm release
}
