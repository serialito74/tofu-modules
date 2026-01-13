resource "kubernetes_namespace_v1" "external_dns" {
  metadata {
    name = var.namespace
    labels = {
      name = var.namespace
    }
  }
}
