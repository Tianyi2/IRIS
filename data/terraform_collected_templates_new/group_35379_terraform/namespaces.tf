resource "kubernetes_namespace" "context" {
  metadata {
    name = local.platform_context_namespace
  }
}
