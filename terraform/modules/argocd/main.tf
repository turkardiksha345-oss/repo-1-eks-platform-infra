# eks-platform-infra/terraform/modules/argocd/main.tf

resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_chart_version
  namespace        = var.argocd_namespace
  create_namespace = true

  set {
    name  = "server.metrics.enabled"
    value = "true"
  }

  set {
    name  = "server.metrics.serviceMonitor.enabled"
    value = "true"
  }

  set {
    name  = "controller.metrics.enabled"
    value = "true"
  }

  set {
    name  = "controller.metrics.serviceMonitor.enabled"
    value = "true"
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = "true" # Behind Ingress NLB TLS
  }

  set {
    name  = "server.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "crds.install"
    value = "true"
  }
}
