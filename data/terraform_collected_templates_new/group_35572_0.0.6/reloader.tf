resource "kubernetes_manifest" "deployment_reloader" {
  manifest = {
    "apiVersion" = "extensions/v1beta1"
    "kind" = "Deployment"
    "metadata" = {
      "labels" = {
        "app" = "reloader"
        "chart" = "reloader-0.0.6"
        "group" = "com.stakater.platform"
        "heritage" = "Tiller"
        "provider" = "stakater"
        "release" = "RELEASE-NAME"
        "version" = "0.0.6"
      }
      "name" = "reloader"
    }
    "spec" = {
      "replicas" = 1
      "revisionHistoryLimit" = 2
      "selector" = {
        "matchLabels" = {
          "app" = "reloader"
          "group" = "com.stakater.platform"
          "provider" = "stakater"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "reloader"
            "group" = "com.stakater.platform"
            "provider" = "stakater"
          }
        }
        "spec" = {
          "containers" = [
            {
              "env" = [
                {
                  "name" = "KUBERNETES_NAMESPACE"
                  "valueFrom" = {
                    "fieldRef" = {
                      "fieldPath" = "metadata.namespace"
                    }
                  }
                },
              ]
              "image" = "stakater/reloader:0.0.6"
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

resource "kubernetes_manifest" "serviceaccount_reloader" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "labels" = {
        "app" = "reloader"
        "chart" = "reloader-0.0.6"
        "group" = "com.stakater.platform"
        "heritage" = "Tiller"
        "provider" = "stakater"
        "release" = "RELEASE-NAME"
        "version" = "0.0.6"
      }
      "name" = "reloader"
    }
  }
}

resource "kubernetes_manifest" "role_reloader_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1beta1"
    "kind" = "Role"
    "metadata" = {
      "labels" = {
        "app" = "reloader"
        "chart" = "reloader-0.0.6"
        "group" = "com.stakater.platform"
        "heritage" = "Tiller"
        "provider" = "stakater"
        "release" = "RELEASE-NAME"
        "version" = "0.0.6"
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
          "",
          "extensions",
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
    ]
  }
}

resource "kubernetes_manifest" "rolebinding_reloader_role_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1beta1"
    "kind" = "RoleBinding"
    "metadata" = {
      "labels" = {
        "app" = "reloader"
        "chart" = "reloader-0.0.6"
        "group" = "com.stakater.platform"
        "heritage" = "Tiller"
        "provider" = "stakater"
        "release" = "RELEASE-NAME"
        "version" = "0.0.6"
      }
      "name" = "reloader-role-binding"
      "namespace" = var.namespace
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "Role"
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
