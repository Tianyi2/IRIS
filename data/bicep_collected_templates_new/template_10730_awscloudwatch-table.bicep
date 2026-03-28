// Bicep template for Log Analytics custom table: AWSCloudWatch
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 6, Deployed columns: 5 (Type column filtered)
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

resource awscloudwatchTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'AWSCloudWatch'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'AWSCloudWatch'
      description: 'Custom table AWSCloudWatch - imported from JSON schema'
      displayName: 'AWSCloudWatch'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'ExtractedTime'
          type: 'dateTime'
        }
        {
          name: 'Message'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = awscloudwatchTable.name
output tableId string = awscloudwatchTable.id
output provisioningState string = awscloudwatchTable.properties.provisioningState
