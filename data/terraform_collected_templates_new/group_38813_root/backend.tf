# Using a single workspace:

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "emea-se-playground-2019"
    workspaces {
      name = "GUY-COM-Showcase"
    }
  }
  required_providers {
    dockerhub = {
      source = "BarnabyShearer/dockerhub"
    }

    gitlab = {
      source = "gitlabhq/gitlab"
    }
    okta = {
      source  = "okta/okta"
      version = "~> 3.15"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }

  }
}

# // Workspace Data
# data "terraform_remote_state" "demostack" {
#   backend = "remote"
#   config = {
#     hostname     = "app.terraform.io"
#     organization = "emea-se-playground-2019"
#     workspaces = {
#       name = "Guy-hcp-demostack-from-gitlab"
#     }
#   } //config
# }


# data "tfe_outputs" "demostack" {
#   organization = "emea-se-playground-2019"
#   workspace = "Guy-hcp-demostack-from-gitlab"
# }
# # to consume data.tfe_outputs.demostack.values.HCP_Vault_Public_address
