resource "kubernetes_secret_v1" "external_dns_cloudflare" {
  count = var.dns_provider == "cloudflare" ? 1 : 0

  metadata {
    name      = "external-dns-cloudflare"
    namespace = var.namespace
  }

  type = "Opaque"

  data = {
    "api-token" = var.cloudflare_token
  }
}
