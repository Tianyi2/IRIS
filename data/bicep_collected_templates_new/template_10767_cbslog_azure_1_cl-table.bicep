// Bicep template for Log Analytics custom table: CBSLog_Azure_1_CL
// Generated on 2025-09-19 14:13:50 UTC
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

resource cbslogazure1clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CBSLog_Azure_1_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CBSLog_Azure_1_CL'
      description: 'Custom table CBSLog_Azure_1_CL - imported from JSON schema'
      displayName: 'CBSLog_Azure_1_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'brand_s'
          type: 'string'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'class_s'
          type: 'string'
        }
        {
          name: 'coa_s'
          type: 'string'
        }
        {
          name: 'created_date_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'remarks_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'updated_date_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = cbslogazure1clTable.name
output tableId string = cbslogazure1clTable.id
output provisioningState string = cbslogazure1clTable.properties.provisioningState
