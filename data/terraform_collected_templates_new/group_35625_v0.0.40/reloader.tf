resource "kubernetes_manifest" "deployment_release_name_reloader" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "RELEASE-NAME-reloader"
        "chart" = "reloader-v0.0.40"
        "group" = "com.stakater.platform"
        "heritage" = "Tiller"
        "provider" = "stakater"
        "release" = "RELEASE-NAME"
        "version" = "v0.0.40"
      }
      "name" = "RELEASE-NAME-reloader"
    }
    "spec" = {
      "replicas" = 1
      "revisionHistoryLimit" = 2
      "selector" = {
        "matchLabels" = {
          "app" = "RELEASE-NAME-reloader"
          "release" = "RELEASE-NAME"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "RELEASE-NAME-reloader"
            "chart" = "reloader-v0.0.40"
            "group" = "com.stakater.platform"
            "heritage" = "Tiller"
            "provider" = "stakater"
            "release" = "RELEASE-NAME"
            "version" = "v0.0.40"
          }
        }
        "spec" = {
          "containers" = [
            {
              "args" = null
              "env" = null
              "image" = "stakater/reloader:v0.0.40"
              "imagePullPolicy" = "IfNotPresent"
              "name" = "RELEASE-NAME-reloader"
            },
          ]
          "serviceAccountName" = "RELEASE-NAME-reloader"
        }
      }
    }
  }
}

resource "kubernetes_manifest" "clusterrole_release_name_reloader_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1beta1"
    "kind" = "ClusterRole"
    "metadata" = {
      "labels" = {
        "app" = "RELEASE-NAME-reloader"
        "chart" = "reloader-v0.0.40"
        "heritage" = "Tiller"
        "release" = "RELEASE-NAME"
      }
      "name" = "RELEASE-NAME-reloader-role"
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

resource "kubernetes_manifest" "clusterrolebinding_release_name_reloader_role_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1beta1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "RELEASE-NAME-reloader"
        "chart" = "reloader-v0.0.40"
        "heritage" = "Tiller"
        "release" = "RELEASE-NAME"
      }
      "name" = "RELEASE-NAME-reloader-role-binding"
      "namespace" = var.namespace
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "RELEASE-NAME-reloader-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "RELEASE-NAME-reloader"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "serviceaccount_release_name_reloader" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app" = "RELEASE-NAME-reloader"
        "chart" = "reloader-v0.0.40"
        "heritage" = "Tiller"
        "release" = "RELEASE-NAME"
      }
      "name" = "RELEASE-NAME-reloader"
    }
  }
}
