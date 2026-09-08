# eks-platform-infra/terraform/modules/observability/main.tf

# -----------------------------------------------------------------------------
# kube-prometheus-stack (Prometheus, Grafana, Alertmanager)
# -----------------------------------------------------------------------------
resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  version          = var.kube_prometheus_stack_version
  namespace        = var.monitoring_namespace
  create_namespace = true

  values = [
    yamlencode({
      grafana = {
        enabled       = true
        adminPassword = var.grafana_admin_password
        service = {
          type = "ClusterIP"
        }
        additionalDataSources = [
          {
            name      = "Loki"
            type      = "loki"
            url       = "http://loki-gateway.${var.monitoring_namespace}.svc.cluster.local"
            access    = "proxy"
            isDefault = false
            jsonData = {
              maxLines = 1000
            }
          }
        ]
        dashboardProviders = {
          "dashboardproviders.yaml" = {
            apiVersion = 1
            providers = [
              {
                name            = "default"
                orgId           = 1
                folder          = ""
                type            = "file"
                disableDeletion = false
                editable        = true
                options = {
                  path = "/var/lib/grafana/dashboards/default"
                }
              }
            ]
          }
        }
      }
      prometheus = {
        prometheusSpec = {
          serviceMonitorSelectorNilUsesHelmValues = false
          podMonitorSelectorNilUsesHelmValues     = false
          ruleSelectorNilUsesHelmValues           = false
          retention                               = "15d"
          resources = {
            requests = {
              cpu    = "250m"
              memory = "512Mi"
            }
            limits = {
              cpu    = "1"
              memory = "2Gi"
            }
          }
        }
      }
      alertmanager = {
        enabled = true
      }
    })
  ]
}

# -----------------------------------------------------------------------------
# Loki (Log Aggregator)
# -----------------------------------------------------------------------------
resource "helm_release" "loki" {
  name             = "loki"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "loki"
  version          = var.loki_version
  namespace        = var.monitoring_namespace
  create_namespace = true

  values = [
    yamlencode({
      deploymentMode = "SingleBinary"
      loki = {
        commonConfig = {
          replication_factor = 1
        }
        storage = {
          type = "filesystem"
        }
        schemaConfig = {
          configs = [
            {
              from         = "2024-01-01"
              store        = "tsdb"
              object_store = "filesystem"
              schema       = "v13"
              index = {
                prefix = "index_"
                period = "24h"
              }
            }
          ]
        }
      }
      singleBinary = {
        replicas = 1
        resources = {
          requests = {
            cpu    = "100m"
            memory = "256Mi"
          }
          limits = {
            cpu    = "500m"
            memory = "1Gi"
          }
        }
      }
      gateway = {
        enabled = true
      }
      backend = {
        replicas = 0
      }
      read = {
        replicas = 0
      }
      write = {
        replicas = 0
      }
    })
  ]

  depends_on = [helm_release.kube_prometheus_stack]
}

# -----------------------------------------------------------------------------
# Promtail (Log Collector DaemonSet)
# -----------------------------------------------------------------------------
resource "helm_release" "promtail" {
  name             = "promtail"
  repository       = "https://grafana.github.io/helm-charts"
  chart            = "promtail"
  version          = var.promtail_version
  namespace        = var.monitoring_namespace
  create_namespace = true

  values = [
    yamlencode({
      config = {
        clients = [
          {
            url = "http://loki-gateway.${var.monitoring_namespace}.svc.cluster.local/loki/api/v1/push"
          }
        ]
        snippets = {
          extraScrapeConfigs = ""
        }
      }
    })
  ]

  depends_on = [helm_release.loki]
}
