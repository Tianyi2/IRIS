// Bicep template for Log Analytics custom table: ZeroFox_CTI_disruption_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 14, Deployed columns: 14 (Type column filtered)
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

resource zerofoxctidisruptionclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_disruption_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_disruption_CL'
      description: 'Custom table ZeroFox_CTI_disruption_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_disruption_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'fqdn_s'
          type: 'string'
        }
        {
          name: 'ip_s'
          type: 'string'
        }
        {
          name: 'host_s'
          type: 'string'
        }
        {
          name: 'registrar_s'
          type: 'string'
        }
        {
          name: 'threat_type_s'
          type: 'string'
        }
        {
          name: 'http_status_d'
          type: 'real'
        }
        {
          name: 'asn_d'
          type: 'real'
        }
        {
          name: 'iana_d'
          type: 'real'
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
          name: 'category_s'
          type: 'string'
        }
        {
          name: 'network_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zerofoxctidisruptionclTable.name
output tableId string = zerofoxctidisruptionclTable.id
output provisioningState string = zerofoxctidisruptionclTable.properties.provisioningState
