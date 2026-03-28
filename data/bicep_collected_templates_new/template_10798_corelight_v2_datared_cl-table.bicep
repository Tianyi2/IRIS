// Bicep template for Log Analytics custom table: Corelight_v2_datared_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 20 (Type column filtered)
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

resource corelightv2dataredclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_datared_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_datared_CL'
      description: 'Custom table Corelight_v2_datared_CL - imported from JSON schema'
      displayName: 'Corelight_v2_datared_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'x509_red_d'
          type: 'real'
        }
        {
          name: 'weird_total_d'
          type: 'real'
        }
        {
          name: 'weird_red_d'
          type: 'real'
        }
        {
          name: 'ssl_coal_miss_d'
          type: 'real'
        }
        {
          name: 'ssl_total_d'
          type: 'real'
        }
        {
          name: 'ssl_red_d'
          type: 'real'
        }
        {
          name: 'http_total_d'
          type: 'real'
        }
        {
          name: 'x509_total_d'
          type: 'real'
        }
        {
          name: 'http_red_d'
          type: 'real'
        }
        {
          name: 'files_total_d'
          type: 'real'
        }
        {
          name: 'files_red_d'
          type: 'real'
        }
        {
          name: 'dns_coal_miss_d'
          type: 'real'
        }
        {
          name: 'dns_total_d'
          type: 'real'
        }
        {
          name: 'dns_red_d'
          type: 'real'
        }
        {
          name: 'conn_total_d'
          type: 'real'
        }
        {
          name: 'conn_red_d'
          type: 'real'
        }
        {
          name: 'files_coal_miss_d'
          type: 'real'
        }
        {
          name: 'x509_coal_miss_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2dataredclTable.name
output tableId string = corelightv2dataredclTable.id
output provisioningState string = corelightv2dataredclTable.properties.provisioningState
