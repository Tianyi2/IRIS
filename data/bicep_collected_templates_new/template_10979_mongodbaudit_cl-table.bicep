// Bicep template for Log Analytics custom table: MongoDBAudit_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 16, Deployed columns: 16 (Type column filtered)
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

resource mongodbauditclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MongoDBAudit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MongoDBAudit_CL'
      description: 'Custom table MongoDBAudit_CL - imported from JSON schema'
      displayName: 'MongoDBAudit_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventCount'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
        }
        {
          name: 'DvcAction'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcPortNumber'
          type: 'real'
        }
        {
          name: 'DstIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'DstPortNumber'
          type: 'real'
        }
        {
          name: 'Users'
          type: 'string'
        }
        {
          name: 'Roles'
          type: 'string'
        }
        {
          name: 'Parameters'
          type: 'string'
        }
        {
          name: 'EventResultCode'
          type: 'string'
        }
        {
          name: 'EventResult'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = mongodbauditclTable.name
output tableId string = mongodbauditclTable.id
output provisioningState string = mongodbauditclTable.properties.provisioningState
