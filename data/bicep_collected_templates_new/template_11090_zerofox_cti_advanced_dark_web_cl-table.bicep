// Bicep template for Log Analytics custom table: ZeroFox_CTI_advanced_dark_web_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 18, Deployed columns: 18 (Type column filtered)
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

resource zerofoxctiadvanceddarkwebclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_advanced_dark_web_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_advanced_dark_web_CL'
      description: 'Custom table ZeroFox_CTI_advanced_dark_web_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_advanced_dark_web_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'id_d'
          type: 'real'
        }
        {
          name: 'tags_s'
          type: 'string'
        }
        {
          name: 'actors_s'
          type: 'string'
        }
        {
          name: 'languages_s'
          type: 'string'
        }
        {
          name: 'target_industries_s'
          type: 'string'
        }
        {
          name: 'target_regions_s'
          type: 'string'
        }
        {
          name: 'target_targets_s'
          type: 'string'
        }
        {
          name: 'source_urls_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'threat_types_s'
          type: 'string'
        }
        {
          name: 'contents_s'
          type: 'string'
        }
        {
          name: 'tlp'
          type: 'string'
        }
        {
          name: 'reliability_s'
          type: 'string'
        }
        {
          name: 'confidence_s'
          type: 'string'
        }
        {
          name: 'title_s'
          type: 'string'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
        {
          name: 'comments_s'
          type: 'string'
        }
        {
          name: 'source_names_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zerofoxctiadvanceddarkwebclTable.name
output tableId string = zerofoxctiadvanceddarkwebclTable.id
output provisioningState string = zerofoxctiadvanceddarkwebclTable.properties.provisioningState
