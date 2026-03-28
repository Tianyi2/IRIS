resource "time_static" "password_timestamp" {
  count = var.rotate_admin_state_password && var.generate_admin_password ? 1 : 0

  triggers = {
    always_run = timestamp()
  }
}

resource "terraform_data" "password_timestamp" {
  input = try(time_static.password_timestamp[*].triggers.always_run, null)
}

resource "random_password" "admin_password" {
  count = (
    (lower(var.os_type) == "windows" && var.generate_admin_password == true) ? 1 : (
      (lower(var.os_type) == "linux") && var.generate_admin_password == true && var.disable_password_authentication == false ? 1 : 0
    )
  )

  length           = 22
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  min_upper        = 2
  override_special = "!#$%&()*+,-./:;<=>?@[]^_{|}~"
  special          = true

  lifecycle {
    replace_triggered_by = [terraform_data.password_timestamp]
  }
}

#Requires that the deployment user has key vault secrets write access
resource "azurerm_key_vault_secret" "admin_password" {
  count = (((var.generate_admin_password == true) && (lower(var.os_type) == "windows") && var.generated_secrets_key_vault_secret_config != null) ||
  ((var.generate_admin_password == true) && (lower(var.os_type) == "linux") && (var.disable_password_authentication == false) && var.generated_secrets_key_vault_secret_config != null)) ? 1 : 0

  key_vault_id    = coalesce(var.generated_secrets_key_vault_secret_config.key_vault_resource_id)
  name            = coalesce(var.generated_secrets_key_vault_secret_config.name, "${var.name}-${var.admin_username}-password")
  value           = random_password.admin_password[0].result
  content_type    = var.generated_secrets_key_vault_secret_config.content_type
  expiration_date = local.generated_secret_expiration_date_utc
  not_before_date = var.generated_secrets_key_vault_secret_config.not_before_date
  tags            = var.generated_secrets_key_vault_secret_config.tags != {} ? var.generated_secrets_key_vault_secret_config.tags : var.tags

  lifecycle {
    ignore_changes = [expiration_date, value]
  }
}

#assign permissions to the managed identity if enabled and role assignments included
resource "azurerm_role_assignment" "system_managed_identity" {
  for_each = var.role_assignments_system_managed_identity

  principal_id                           = local.system_managed_identity_id
  scope                                  = each.value.scope_resource_id
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  description                            = each.value.description
  principal_type                         = each.value.principal_type
  role_definition_id                     = (length(split("/", each.value.role_definition_id_or_name))) > 3 ? each.value.role_definition_id_or_name : null
  role_definition_name                   = (length(split("/", each.value.role_definition_id_or_name))) > 3 ? null : each.value.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}

#assign permissions to the virtual machine if enabled and role assignments included
resource "azurerm_role_assignment" "this_virtual_machine" {
  for_each = var.role_assignments

  principal_id                           = each.value.principal_id
  scope                                  = local.virtualmachine_resource_id
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  description                            = each.value.description
  principal_type                         = each.value.principal_type
  role_definition_id                     = (length(split("/", each.value.role_definition_id_or_name))) > 3 ? each.value.role_definition_id_or_name : null
  role_definition_name                   = (length(split("/", each.value.role_definition_id_or_name))) > 3 ? null : each.value.role_definition_id_or_name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}