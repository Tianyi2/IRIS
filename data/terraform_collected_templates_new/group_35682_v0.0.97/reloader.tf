resource "kubernetes_manifest" "serviceaccount_stakater_reloader" {
  manifest = {
    "apiVersion" = "v1"
    "kind" = "ServiceAccount"
    "metadata" = {
      "annotations" = {
        "meta.helm.sh/release-name" = "stakater"
        "meta.helm.sh/release-namespace" = "default"
      }
      "labels" = {
        "app" = "stakater-reloader"
        "app.kubernetes.io/managed-by" = "Helm"
        "chart" = "reloader-v0.0.97"
        "heritage" = "Helm"
        "release" = "stakater"
      }
      "name" = "stakater-reloader"
    }
  }
}

resource "kubernetes_manifest" "clusterrole_stakater_reloader_role" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRole"
    "metadata" = {
      "annotations" = {
        "meta.helm.sh/release-name" = "stakater"
        "meta.helm.sh/release-namespace" = "default"
      }
      "labels" = {
        "app" = "stakater-reloader"
        "app.kubernetes.io/managed-by" = "Helm"
        "chart" = "reloader-v0.0.97"
        "heritage" = "Helm"
        "release" = "stakater"
      }
      "name" = "stakater-reloader-role"
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

resource "kubernetes_manifest" "clusterrolebinding_stakater_reloader_role_binding" {
  manifest = {
    "apiVersion" = "rbac.authorization.k8s.io/v1"
    "kind" = "ClusterRoleBinding"
    "metadata" = {
      "annotations" = {
        "meta.helm.sh/release-name" = "stakater"
        "meta.helm.sh/release-namespace" = "default"
      }
      "labels" = {
        "app" = "stakater-reloader"
        "app.kubernetes.io/managed-by" = "Helm"
        "chart" = "reloader-v0.0.97"
        "heritage" = "Helm"
        "release" = "stakater"
      }
      "name" = "stakater-reloader-role-binding"
      "namespace" = var.namespace
    }
    "roleRef" = {
      "apiGroup" = "rbac.authorization.k8s.io"
      "kind" = "ClusterRole"
      "name" = "stakater-reloader-role"
    }
    "subjects" = [
      {
        "kind" = "ServiceAccount"
        "name" = "stakater-reloader"
        "namespace" = var.namespace
      },
    ]
  }
}

resource "kubernetes_manifest" "deployment_stakater_reloader" {
  manifest = {
    "apiVersion" = "apps/v1"
    "kind" = "Deployment"
    "metadata" = {
      "annotations" = {
        "meta.helm.sh/release-name" = "stakater"
        "meta.helm.sh/release-namespace" = "default"
      }
      "labels" = {
        "app" = "stakater-reloader"
        "app.kubernetes.io/managed-by" = "Helm"
        "chart" = "reloader-v0.0.97"
        "group" = "com.stakater.platform"
        "heritage" = "Helm"
        "provider" = "stakater"
        "release" = "stakater"
        "version" = "v0.0.97"
      }
      "name" = "stakater-reloader"
    }
    "spec" = {
      "replicas" = 1
      "revisionHistoryLimit" = 2
      "selector" = {
        "matchLabels" = {
          "app" = "stakater-reloader"
          "release" = "stakater"
        }
      }
      "template" = {
        "metadata" = {
          "labels" = {
            "app" = "stakater-reloader"
            "app.kubernetes.io/managed-by" = "Helm"
            "chart" = "reloader-v0.0.97"
            "group" = "com.stakater.platform"
            "heritage" = "Helm"
            "provider" = "stakater"
            "release" = "stakater"
            "version" = "v0.0.97"
          }
        }
        "spec" = {
          "containers" = [
            {
              "image" = "stakater/reloader:v0.0.97"
              "imagePullPolicy" = "IfNotPresent"
              "livenessProbe" = {
                "failureThreshold" = 5
                "httpGet" = {
                  "path" = "/metrics"
                  "port" = "http"
                }
                "periodSeconds" = 10
                "successThreshold" = 1
                "timeoutSeconds" = 5
              }
              "name" = "stakater-reloader"
              "ports" = [
                {
                  "containerPort" = 9090
                  "name" = "http"
                },
              ]
              "readinessProbe" = {
                "failureThreshold" = 5
                "httpGet" = {
                  "path" = "/metrics"
                  "port" = "http"
                }
                "periodSeconds" = 10
                "successThreshold" = 1
                "timeoutSeconds" = 5
              }
            },
          ]
          "securityContext" = {
            "runAsNonRoot" = true
            "runAsUser" = 65534
          }
          "serviceAccountName" = "stakater-reloader"
        }
      }
    }
  }
}
