# Namespace
resource "kubernetes_namespace_v1" "beginner" {
  metadata {
    name = var.namespace_name
  }
  lifecycle {
    prevent_destroy = false
  }
}

# Deployment 
resource "kubernetes_deployment_v1" "nginx" {
    metadata {
        name = "nginx-deployment"
        namespace = kubernetes_namespace_v1.beginner.metadata[0].name
    }
    spec {
        replicas = var.replicas
        selector {
            match_labels = {
                app = "nginx"
            }
        }
        template {
            metadata {
                labels = {
                    app = "nginx"
                }
            }
            spec {
                container {
                    image = var.app_image
                    name = "nginx"
                    port {
                        container_port = 80
                    }
                }
            }
        }
    }
}

# Service
resource "kubernetes_service_v1" "nginx" {
  metadata {
    name      = "nginx-service"
    namespace = kubernetes_namespace_v1.beginner.metadata[0].name
  }
  spec {
    selector = {
      app = "nginx"
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}

# ConfigMap - Terraform Data Source
data "kubernetes_namespace_v1" "existing" {
  metadata {
    name = "existing-ns"
  }
}

# ConfigMap - Terraform Count
resource "kubernetes_config_map_v1" "count" {
  count = 3
  metadata {
    name      = "count-config-${count.index}"
    namespace = kubernetes_namespace_v1.beginner.metadata[0].name
  }
  data = {
    environment = "dev"
    index       = tostring(count.index)
  }
}

# ConfigMap - Terraform For Each
locals {
  services = {
    frontend = "react"
    backend  = "nodejs"
    cache    = "redis"
  }
}
resource "kubernetes_config_map_v1" "foreach" {
  for_each = local.services
  metadata {
    name      = "${each.key}-config"
    namespace = kubernetes_namespace_v1.beginner.metadata[0].name
  }
  data = {
    service = each.value
  }
}