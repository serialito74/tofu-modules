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

resource "kubernetes_secret_v1" "external_dns_oci_config" {
  count = var.dns_provider == "oci" ? 1 : 0

  metadata {
    name      = "external-dns-config"
    namespace = var.namespace
  }

  data = {
    "oci.yaml" = <<-EOT
auth:
  region: ${var.oci_region}
  useWorkloadIdentity: true
compartment: ${var.oci_compartment_ocid}
EOT
  }

  depends_on = [kubernetes_namespace_v1.external_dns]
}