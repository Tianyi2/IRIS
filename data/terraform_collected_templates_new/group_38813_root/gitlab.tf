resource "gitlab_project" "app" {
  name             = var.application_name
  description      = "My awesome codebase"
  visibility_level = "public"
}



resource "gitlab_repository_file" "app" {
  project   = gitlab_project.app.id
  file_path = ".gitlab-ci.yml"
  branch    = "main"
  // content will be auto base64 encoded
  content        = <<EOT
 ijob:
  variables:
    VAULT_SERVER_URL: ${var.vault_address}
    VAULT_AUTH_PATH: ${vault_jwt_auth_backend.gitlab.path}  # or "jwt" if you used method B
    VAULT_AUTH_ROLE: myproject-staging
  id_tokens:
    VAULT_ID_TOKEN:
      aud: https://gitlab.com
  secrets:
    PASSWORD:
      vault:
        engine:
          name: kv-v1
          path: secret
        field: password
        path: myproject/staging/db
      file: false
  EOT
  commit_message = "initial CI/CD commit"
}

