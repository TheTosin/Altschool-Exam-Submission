# PORTFOLIO DEPLOYMENT

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
