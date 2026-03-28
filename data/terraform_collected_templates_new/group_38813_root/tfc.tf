
resource "tfe_project" "app" {
  organization = var.tfe_organization
  name         = var.application_name
}

resource "tfe_workspace" "app_ws_dev" {
  depends_on   = [github_repository.app-enviroment, github_repository_file.tf-dev]
  name         = "${var.application_name}-dev"
  organization = var.tfe_organization
  # tag_names    = ["${var.application_name}", "dev"]
  project_id = tfe_project.app.id
  force_delete = true
  auto_apply = true
  vcs_repo {
    branch         = "dev"
    identifier     = github_repository.app-enviroment.full_name
    oauth_token_id = var.tfe_oauth_token_id
  }

}

resource "tfe_workspace" "app_ws_qa" {
  depends_on   = [github_repository.app-enviroment, github_repository_file.tf-qa]
  name         = "${var.application_name}-qa"
  organization = var.tfe_organization
  # tag_names    = ["${var.application_name}", "qa"]
  project_id = tfe_project.app.id
  auto_apply = true
  force_delete = true
  vcs_repo {
    branch         = "qa"
    identifier     = github_repository.app-enviroment.full_name
    oauth_token_id = var.tfe_oauth_token_id
  }

}

resource "tfe_workspace" "app_ws_preprod" {
  depends_on   = [github_repository.app-enviroment, github_repository_file.tf-preprod]
  name         = "${var.application_name}-preprod"
  organization = var.tfe_organization
  # tag_names    = ["${var.application_name}", "preprod"]
  project_id = tfe_project.app.id
  auto_apply = true
  force_delete = true
  vcs_repo {
    branch         = "preprod"
    identifier     = github_repository.app-enviroment.full_name
    oauth_token_id = var.tfe_oauth_token_id
  }

}

resource "tfe_workspace" "app_ws_prod" {
  depends_on   = [github_repository.app-enviroment]
  name         = "${var.application_name}-prod"
  organization = var.tfe_organization
  # tag_names    = ["${var.application_name}", "prod"]
  project_id = tfe_project.app.id
  auto_apply = true
  force_delete = true
  vcs_repo {
    branch         = "main"
    identifier     = github_repository.app-enviroment.full_name
    oauth_token_id = var.tfe_oauth_token_id
  }

}

resource "tfe_team" "app_team" {
  name         = "${var.application_name}-team"
  organization = var.tfe_organization
}

resource "tfe_team_token" "app_team_token" {
  team_id = tfe_team.app_team.id
}


resource "tfe_team_access" "app_ws_team_access_dev" {

  access       = "read"
  team_id      = tfe_team.app_team.id
  workspace_id = tfe_workspace.app_ws_dev.id
}

resource "tfe_team_access" "app_ws_team_access_qa" {

  access       = "read"
  team_id      = tfe_team.app_team.id
  workspace_id = tfe_workspace.app_ws_qa.id
}

resource "tfe_team_access" "app_ws_team_access_preprod" {

  access       = "read"
  team_id      = tfe_team.app_team.id
  workspace_id = tfe_workspace.app_ws_preprod.id
}

resource "tfe_team_access" "app_ws_team_access_prod" {

  access       = "read"
  team_id      = tfe_team.app_team.id
  workspace_id = tfe_workspace.app_ws_prod.id
}
