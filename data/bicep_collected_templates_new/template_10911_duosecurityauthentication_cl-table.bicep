// Bicep template for Log Analytics custom table: DuoSecurityAuthentication_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 27, Deployed columns: 27 (Type column filtered)
// Underscore columns filtered out
// dataTypeHint values: 0=Uri, 1=Guid, 2=ArmPath, 3=IP

@description('Log Analytics Workspace name')
param workspaceName string

@description('Table plan - Analytics or Basic')
@allowed(['Analytics', 'Basic'])
param tablePlan string = 'Analytics'

@description('Data retention period in days')
@minValue(4)
@maxValue(730)
param retentionInDays int = 30

@description('Total retention period in days')
@minValue(4)
@maxValue(4383)
param totalRetentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' existing = {
  name: workspaceName
}

resource duosecurityauthenticationclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'DuoSecurityAuthentication_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'DuoSecurityAuthentication_CL'
      description: 'Custom table DuoSecurityAuthentication_CL - imported from JSON schema'
      displayName: 'DuoSecurityAuthentication_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'access_device_browser_s'
          type: 'string'
        }
        {
          name: 'user_name_s'
          type: 'string'
        }
        {
          name: 'user_key_s'
          type: 'string'
        }
        {
          name: 'user_groups_s'
          type: 'string'
        }
        {
          name: 'txid_g'
          type: 'string'
        }
        {
          name: 'timestamp_d'
          type: 'real'
        }
        {
          name: 'result_s'
          type: 'string'
        }
        {
          name: 'reason_s'
          type: 'string'
        }
        {
          name: 'isotimestamp_t'
          type: 'dateTime'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'email_s'
          type: 'string'
        }
        {
          name: 'application_name_s'
          type: 'string'
        }
        {
          name: 'application_key_s'
          type: 'string'
        }
        {
          name: 'alias_s'
          type: 'string'
        }
        {
          name: 'access_device_os_version_s'
          type: 'string'
        }
        {
          name: 'access_device_os_s'
          type: 'string'
        }
        {
          name: 'access_device_location_state_s'
          type: 'string'
        }
        {
          name: 'access_device_location_country_s'
          type: 'string'
        }
        {
          name: 'access_device_location_city_s'
          type: 'string'
        }
        {
          name: 'access_device_is_password_set_s'
          type: 'string'
        }
        {
          name: 'access_device_is_firewall_enabled_s'
          type: 'string'
        }
        {
          name: 'access_device_is_encryption_enabled_s'
          type: 'string'
        }
        {
          name: 'access_device_ip_s'
          type: 'string'
        }
        {
          name: 'access_device_browser_version_s'
          type: 'string'
        }
        {
          name: 'auth_device_name_s'
          type: 'string'
        }
        {
          name: 'factor_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = duosecurityauthenticationclTable.name
output tableId string = duosecurityauthenticationclTable.id
output provisioningState string = duosecurityauthenticationclTable.properties.provisioningState
