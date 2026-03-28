// Bicep template for Log Analytics custom table: ZeroFox_CTI_botnet_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 21, Deployed columns: 21 (Type column filtered)
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

resource zerofoxctibotnetclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_botnet_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_botnet_CL'
      description: 'Custom table ZeroFox_CTI_botnet_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_botnet_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'listed_at_t'
          type: 'dateTime'
        }
        {
          name: 'estimated_infected_at_t'
          type: 'dateTime'
        }
        {
          name: 'logged_at_t'
          type: 'dateTime'
        }
        {
          name: 'acquired_at_t'
          type: 'dateTime'
        }
        {
          name: 'process_elevation_s'
          type: 'string'
        }
        {
          name: 'uac_s'
          type: 'string'
        }
        {
          name: 'available_keyboards_s'
          type: 'string'
        }
        {
          name: 'current_language_s'
          type: 'string'
        }
        {
          name: 'location_s'
          type: 'string'
        }
        {
          name: 'zip_code_s'
          type: 'string'
        }
        {
          name: 'country_code_s'
          type: 'string'
        }
        {
          name: 'anti_viruses_s'
          type: 'string'
        }
        {
          name: 'operating_system_s'
          type: 'string'
        }
        {
          name: 'file_location_s'
          type: 'string'
        }
        {
          name: 'is_common_domain_b'
          type: 'boolean'
        }
        {
          name: 'c2_domain_s'
          type: 'string'
        }
        {
          name: 'c2_ip_address_s'
          type: 'string'
        }
        {
          name: 'bot_name_s'
          type: 'string'
        }
        {
          name: 'breached_at'
          type: 'dateTime'
        }
        {
          name: 'tags_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zerofoxctibotnetclTable.name
output tableId string = zerofoxctibotnetclTable.id
output provisioningState string = zerofoxctibotnetclTable.properties.provisioningState
