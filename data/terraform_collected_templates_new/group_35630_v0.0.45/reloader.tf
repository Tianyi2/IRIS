resource "kubernetes_manifest" "deployment_reloader_reloader" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "reloader-reloader"
        "chart" = "reloader-v0.0.45"
        "group" = "com.stakater.platform"
        "heritage" = "Tiller"
        "provider" = "stakater"
        "release" = "reloader"
        "version" = "v0.0.45"
      }
      "name" = "reloader-reloader"
    }
    "spec" = {
      "replicas" = 1
      "revisionHistoryLimit" = 2
      "selector" = {
        "matchLabels" = {
          "app" = "reloader-reloader"
          "release" = "reloader"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "reloader-reloader"
            "chart" = "reloader-v0.0.45"
            "group" = "com.stakater.platform"
            "heritage" = "Tiller"
            "provider" = "stakater"
            "release" = "reloader"
            "version" = "v0.0.45"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = null
              "env" = null
              "image" = "stakater/reloader:v0.0.45"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "reloader-reloader"
            },
          ]
          "serviceAccountName" = "reloader-reloader"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "clusterrole_reloader_reloader_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1beta1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "reloader-reloader"
        "chart" = "reloader-v0.0.45"
        "heritage" = "Tiller"
        "release" = "reloader"
      }
      "name" = "reloader-reloader-role"
      "namespace" = var.namespace
    }
    "rules" = [
      {
        "apiGroups" = [
          "",
        ]
        "resources" = [
          "secrets",
          "configmaps",
        ]
        "verbs" = [
          "list",
          "get",
          "watch",
        ]
      },
      {
        "apiGroups" = [
          "apps",
        ]
        "resources" = [
          "deployments",
          "daemonsets",
          "statefulsets",
        ]
        "verbs" = [
          "list",
          "get",
          "update",
          "patch",
        ]
      },
      {
        "apiGroups" = [
          "extensions",
        ]
        "resources" = [
          "deployments",
          "daemonsets",
        ]
        "verbs" = [
          "list",
          "get",
          "update",
          "patch",
        ]
      },
    ]
  }
}

resource "kubernetes_manifest" "clusterrolebinding_reloader_reloader_role_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1beta1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "reloader-reloader"
        "chart" = "reloader-v0.0.45"
        "heritage" = "Tiller"
        "release" = "reloader"
      }
      "name" = "reloader-reloader-role-binding"
      "namespace" = var.namespace
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "reloader-reloader-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "reloader-reloader"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "serviceaccount_reloader_reloader" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app" = "reloader-reloader"
        "chart" = "reloader-v0.0.45"
        "heritage" = "Tiller"
        "release" = "reloader"
      }
      "name" = "reloader-reloader"
    }
  }
}
