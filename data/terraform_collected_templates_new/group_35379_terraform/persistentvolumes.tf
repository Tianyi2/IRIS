resource "kubernetes_persistent_volume" "velero" {
  depends_on = [
    kubernetes_storage_class.velero
  ]
  metadata {
    name = local.velero_persistentvolume_name
  }

  spec {
    capacity = {
      storage = "${local.velero_persistentvolume_capacity_gb}Gi"
    }
    access_modes = local.velero_persistentvolume_access_modes
    storage_class_name = kubernetes_storage_class.velero.metadata[0].name
    persistent_volume_reclaim_policy = local.velero_persistentvolume_reclaim_policy
    persistent_volume_source {
      host_path {
        path = local.velero_persistentvolume_host_path
        type = local.velero_persistentvolume_host_path_type
      }
    }
    node_affinity {
      required {
        node_selector_term {
          dynamic "match_expressions" {
            for_each = [local.velero_persistentvolume_node_affinity_matched_expressions]
            content {
              key      = match_expressions.value.key
              operator = match_expressions.value.operator
              values   = lookup(match_expressions.value, "values", null)
            }
          }
        }
      }
    }
  }
}
