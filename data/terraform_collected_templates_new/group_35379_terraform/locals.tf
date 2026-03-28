locals {
  # OpenEBS ZFS configuration
  zfs_pool_name = "zfspv-pool"
}

locals {
  # Platform storage configuration
  openebs_namespace = "openebs"

  minio_operator_namespace = "minio-operator"

  velero_namespace = "velero"
  velero_minio_pool_user_id = 2150
  velero_minio_pool_group_id = 2150
  velero_minio_pool_size_gb = 16
  velero_minio_pool_server_count = 1
  velero_minio_pool_volume_count = 1
  velero_minio_pool_node_selector = {
    "node-role.kubernetes.io/control-plane" = ""
  }
  velero_minio_pool_tolerations = [
    { # Tolerate control-plane nodes, to allow creation of backup storage on control-plane node
      key      = "node-role.kubernetes.io/control-plane"
      operator = "Exists"
      effect   = "NoSchedule"
    }
  ]

  velero_internal_kubectl_repository = "bitnamilegacy/kubectl"
  velero_internal_kubectl_tag = "1.33.4" # Old kubectl version as newest container version isn't available through bitnamilegacy/kubectl

  velero_scheduled_backups = {
    "daily" = {
      schedule = ["0", "2", "*", "*", "*"] # At 02:00 every day
      ttl_minutes = 100080 # 7 days
      included_namespaces = ["*"]
      excluded_namespaces = []
      included_resources = ["*"]
      excluded_resources = []
      include_cluster_resources = true
      selected_labels = {}
      schedule_labels = {
        "backup-type" = "daily"
      }
      schedule_annotations = {}
    }
  }
  velero_scheduled_backup_common_labels = {}
  velero_scheduled_backup_common_annotations = {}
}

locals {
  # Storage class configuration for services
  service_storageclass_name = "service-sc"
  service_storageclass_volume_binding_mode = "WaitForFirstConsumer"
  service_storageclass_reclaim_policy = "Delete"
  service_storageclass_provisioner = "zfs.csi.openebs.io"
  service_storageclass_parameters = {
    poolname      = local.zfs_pool_name
    recordsize    = "128K"
    compression   = "off"
    deduplication = "off"
    fstype        = "zfs"
  }
  service_storageclass_annotations = {}
  service_storageclass_labels = {}
}

locals {
  # Storage class configuration for Velero
  velero_storageclass_name = "velero-sc"
  velero_storageclass_provisioner = "kubernetes.io/no-provisioner"
  velero_storageclass_reclaim_policy = "Retain"
  velero_storageclass_volume_binding_mode = "WaitForFirstConsumer"
  velero_storageclass_parameters = {}
  velero_storageclass_annotations = {}
  velero_storageclass_labels = {}
}

locals {
  # Persistent volume configuration for Velero
  velero_persistentvolume_name = "velero-pv"
  velero_persistentvolume_reclaim_policy = "Retain"
  velero_persistentvolume_host_path = "/mnt/minio-velero-data"
  velero_persistentvolume_host_path_type = "DirectoryOrCreate"
  velero_persistentvolume_access_modes = ["ReadWriteOnce"]
  velero_persistentvolume_node_affinity_matched_expressions = {
    key = "node-role.kubernetes.io/control-plane"
    operator = "Exists"
  }
  velero_persistentvolume_capacity_gb = 32
}

locals {
  platform_context_namespace = "platform-storage"
  platform_context_configmap_name = "context"
}

locals {
  # Network reference
  external_domain = data.kubernetes_config_map.network_context.data.external_domain
  external_ingress_ip = data.kubernetes_config_map.network_context.data.external_ingress_ip

  pod_network_cidr = data.kubernetes_config_map.network_context.data.pod_network_cidr
  service_network_cidr = data.kubernetes_config_map.network_context.data.service_network_cidr
  cluster_domain = data.kubernetes_config_map.network_context.data.cluster_domain

  cluster_issuer_created = tobool(data.kubernetes_config_map.network_context.data.cert_manager_cluster_issuer_created)
  cluster_issuer_name = data.kubernetes_config_map.network_context.data.cert_manager_cluster_issuer_name

  dns_records_default_comment = data.kubernetes_config_map.network_context.data.dns_records_default_comment
  dns_records_proxy_enabled = tobool(data.kubernetes_config_map.network_context.data.dns_records_proxy_enabled)
  dns_ttl_seconds = tonumber(data.kubernetes_config_map.network_context.data.dns_ttl_seconds)

  ingress_class_name = data.kubernetes_config_map.network_context.data.primary_ingress_class_name

  create_dns_records = true
}

locals {
  longhorn_namespace = "longhorn-system"

  longhorn_ingress_enabled = true
  longhorn_ingress_class_name = local.ingress_class_name
  longhorn_ingress_host_address = "longhorn.k8s.${local.external_domain}"
  longhorn_ingress_tls_enabled = true
  longhorn_ingress_annotations = local.cluster_issuer_created ? {
    "cert-manager.io/cluster-issuer" = local.cluster_issuer_name
  } : {}

  longhorn_storage_class_name = "longhorn"
  longhorn_storage_replica_count = 1
  longhorn_storage_reclaim_policy = "Delete"
  longhorn_storage_default_path = "/mnt/longhorn"
}
