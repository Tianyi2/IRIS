resource "kubernetes_config_map" "context" {
  depends_on = [
    kubernetes_namespace.context,
    module.storage
  ]
  metadata {
    name      = local.platform_context_configmap_name
    namespace = kubernetes_namespace.context.metadata[0].name
  }

  data = {
    # primary_storage_class_name           = kubernetes_storage_class.service.metadata[0].name
    primary_storage_class_name           = module.storage.longhorn_storage_class_name
    primary_storage_class_reclaim_policy = module.storage.longhorn_storage_class_reclaim_policy
  }
}
