# userprofile DEPLOYMENT

# Create kubernetes Name space for userprofile

resource "kubernetes_namespace" "kube-namespace-userprofile" {
  metadata {
    name = "userprofile-namespace"
    labels = {
      app = "userprofile"
    }
  }
}

# Create kubernetes deployment for userprofile

resource "kubernetes_deployment" "kube-deployment-userprofile" {
  metadata {
    name      = "userprofile"
    namespace = kubernetes_namespace.kube-namespace-userprofile.id
    labels = {
      app = "userprofile"
    } 
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "userprofile"
      }
    }
    template {
      metadata {
        labels = {
          app = "userprofile"
        }
      }
      spec {
        container {
          image = var.image
          name  = "userprofile"
          env {
            name  = "MYSQL_HOST"
            value = "mysql"
          }
          env {
            name  = "MYSQL_PORT"
            value = "3306"
          }
        }
      }
    }
  }
}

# Create kubernetes service for userprofile

resource "kubernetes_service" "kube-service-userprofile" {
  metadata {
    name      = "userprofile"
    namespace = kubernetes_namespace.kube-namespace-userprofile.id
  }
  spec {
    selector = {
      app = "userprofile"
    }
    port {
      name = "metrics"
      port        = 80
      target_port = 80
    }
    port {
      name = "mysql"
      port        = 3306
      target_port = 3306
    }
    type = "LoadBalancer"
  }
}

# MYSQL database for userprofile app

resource "kubernetes_deployment" "userprofile-db" {
  metadata {
    name = "mysql"
    namespace = kubernetes_namespace.kube-namespace-userprofile.id
    labels = {
      app = "mysql"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mysql"
      }
    }
    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }

      spec {
        container {
          name = "mysql"
          image = "mysql:latest"

          env {
            name = "MYSQL_ROOT_PASSWORD"
            value = var.mysql-password
          }

          port {
            name = "mysql"
            container_port = 3306
          }

          volume_mount {
            name = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }
        }

        volume {
          name = "mysql-persistent-storage"
          empty_dir {
            medium = "Memory"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "userprofile-db-service" {
  metadata {
    name = "mysql"
    namespace = kubernetes_namespace.kube-namespace-userprofile.id
  }

  spec {
    selector = {
      app = "mysql"
    }

    port {
      name = "mysql"
      port = 3306
      target_port = 3306
    }

    type = "ClusterIP"
  }
}

# SOCKS SHOP DEPLOYMENT

# Create kubernetes Name space for socks shop app

resource "kubernetes_namespace" "kube-namespace-socks" {
  metadata {
    name = "sock-shop"
  }
}

# Create kubectl deployment for socks app

data "kubectl_file_documents" "docs" {
    content = file("complete-demo.yaml")
}

resource "kubectl_manifest" "kube-deployment-socks" {
    for_each  = data.kubectl_file_documents.docs.manifests
    yaml_body = each.value
}

# Create separate kubernetes service for socks shop frontend

resource "kubernetes_service" "kube-service-socks" {
  metadata {
    name      = "front-end"
    namespace = kubernetes_namespace.kube-namespace-socks.id
    annotations = {
      "prometheus.io/scrape" = "true"
    }
    labels = {
      name = "front-end"
    }
  }
  spec {
    selector = {
      name = "front-end"
    }
    port {
      name = "metrics"
      port        = 80
      target_port = 8079
    }
    type = "LoadBalancer"
  }
}

# Print out loadbalancer DNS hostname for userprofile deployment

output "userprofile_load_balancer_hostname" {
  value = kubernetes_service.kube-service-userprofile.status.0.load_balancer.0.ingress.0.hostname
}

# Print out loadbalancer DNS hostname for socks deployment

output "socks_load_balancer_hostname" {
  value = kubernetes_service.kube-service-socks.status.0.load_balancer.0.ingress.0.hostname
}
