// Bicep template for Log Analytics custom table: ZeroFox_CTI_threat_actors_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 13, Deployed columns: 13 (Type column filtered)
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

resource zerofoxctithreatactorsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_threat_actors_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_threat_actors_CL'
      description: 'Custom table ZeroFox_CTI_threat_actors_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_threat_actors_CL'
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
          name: 'mitre_id_s'
          type: 'string'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
        {
          name: 'updated_at_t'
          type: 'dateTime'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'references_s'
          type: 'string'
        }
        {
          name: 'software_s'
          type: 'string'
        }
        {
          name: 'associated_groups_s'
          type: 'string'
        }
        {
          name: 'target_geo_s'
          type: 'string'
        }
        {
          name: 'target_industries_s'
          type: 'string'
        }
        {
          name: 'mitre_ttps_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zerofoxctithreatactorsclTable.name
output tableId string = zerofoxctithreatactorsclTable.id
output provisioningState string = zerofoxctithreatactorsclTable.properties.provisioningState
