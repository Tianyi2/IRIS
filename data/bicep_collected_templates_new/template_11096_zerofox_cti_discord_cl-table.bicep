// Bicep template for Log Analytics custom table: ZeroFox_CTI_discord_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 7, Deployed columns: 7 (Type column filtered)
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

resource zerofoxctidiscordclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_discord_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_discord_CL'
      description: 'Custom table ZeroFox_CTI_discord_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_discord_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'author_id_s'
          type: 'string'
        }
        {
          name: 'author_username_s'
          type: 'string'
        }
        {
          name: 'channel_name_s'
          type: 'string'
        }
        {
          name: 'content_s'
          type: 'string'
        }
        {
          name: 'server_name_s'
          type: 'string'
        }
        {
          name: 'timestamp_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = zerofoxctidiscordclTable.name
output tableId string = zerofoxctidiscordclTable.id
output provisioningState string = zerofoxctidiscordclTable.properties.provisioningState
