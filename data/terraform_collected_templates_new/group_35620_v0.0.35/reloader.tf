resource "kubernetes_manifest" "deployment_reloader" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "reloader"
        "chart" = "reloader-v0.0.35"
        "group" = "com.stakater.platform"
        "heritage" = "Tiller"
        "provider" = "stakater"
        "release" = "RELEASE-NAME"
        "version" = "v0.0.35"
      }
      "name" = "reloader"
    }
    "spec" = {
      "replicas" = 1
      "revisionHistoryLimit" = 2
      "selector" = {
        "matchLabels" = {
          "app" = "reloader"
          "release" = "RELEASE-NAME"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "reloader"
            "chart" = "reloader-v0.0.35"
            "group" = "com.stakater.platform"
            "heritage" = "Tiller"
            "provider" = "stakater"
            "release" = "RELEASE-NAME"
            "version" = "v0.0.35"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = null
              "image" = "stakater/reloader:v0.0.35"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "reloader"
            },
          ]
          "serviceAccountName" = "reloader"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "clusterrole_reloader_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1beta1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "reloader"
        "chart" = "reloader-v0.0.35"
        "heritage" = "Tiller"
        "release" = "RELEASE-NAME"
      }
      "name" = "reloader-role"
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

resource "kubernetes_manifest" "clusterrolebinding_reloader_role_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1beta1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "reloader"
        "chart" = "reloader-v0.0.35"
        "heritage" = "Tiller"
        "release" = "RELEASE-NAME"
      }
      "name" = "reloader-role-binding"
      "namespace" = var.namespace
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "reloader-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "reloader"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "serviceaccount_reloader" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app" = "reloader"
        "chart" = "reloader-v0.0.35"
        "heritage" = "Tiller"
        "release" = "RELEASE-NAME"
      }
      "name" = "reloader"
    }
  }
}
