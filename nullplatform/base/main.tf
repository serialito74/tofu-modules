############################################
# Namespaces
# Pre-create namespaces to avoid race condition
# with Helm chart's lookup function (chart v2.36.0+)
############################################

resource "kubernetes_namespace_v1" "nullplatform_tools" {
  metadata {
    name = var.namespace
    labels = {
      name                           = var.namespace
      "app.kubernetes.io/managed-by" = "Helm"
    }
    annotations = {
      "openshift.io/cluster-monitoring" = "true"
      "meta.helm.sh/release-name"       = "nullplatform-base"
      "meta.helm.sh/release-namespace"  = var.namespace
    }
  }
}

resource "kubernetes_namespace_v1" "nullplatform_applications" {
  metadata {
    name = "nullplatform"
    labels = {
      name = "nullplatform"
    }
  }
}

############################################
# Helm Release
############################################

resource "helm_release" "base" {
  name = "nullplatform-base"
  # Vendored fork with gateway.public/internal.extraListeners support (SNI
  # multi-cert listeners), not yet merged upstream — see
  # nullplatform/helm-charts PR from GaliciaSeguros. Swap chart/repository
  # back to the official values once that lands.
  chart      = "${path.module}/vendor/nullplatform-base-2.44.1.tgz"
  namespace  = var.namespace

  wait_for_jobs     = true
  timeout           = 600
  reset_values      = true
  dependency_update = true
  max_history       = 10
  values            = [local.nullplatform_base_values]

  depends_on = [
    kubernetes_namespace_v1.nullplatform_tools,
    kubernetes_namespace_v1.nullplatform_applications
  ]
}
