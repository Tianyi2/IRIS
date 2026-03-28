// Bicep template for Log Analytics custom table: AWSGuardDuty
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 16 (Type column filtered)
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

resource awsguarddutyTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'AWSGuardDuty'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'AWSGuardDuty'
      description: 'Custom table AWSGuardDuty - imported from JSON schema'
      displayName: 'AWSGuardDuty'
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
          name: 'SchemaVersion'
          type: 'string'
        }
        {
          name: 'AccountId'
          type: 'string'
        }
        {
          name: 'Region'
          type: 'string'
        }
        {
          name: 'Partition'
          type: 'string'
        }
        {
          name: 'Id'
          type: 'string'
        }
        {
          name: 'Arn'
          type: 'string'
        }
        {
          name: 'ActivityType'
          type: 'string'
        }
        {
          name: 'ResourceDetails'
          type: 'dynamic'
        }
        {
          name: 'ServiceDetails'
          type: 'dynamic'
        }
        {
          name: 'Severity'
          type: 'int'
        }
        {
          name: 'TimeCreated'
          type: 'dateTime'
        }
        {
          name: 'Title'
          type: 'string'
        }
        {
          name: 'Description'
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

output tableName string = awsguarddutyTable.name
output tableId string = awsguarddutyTable.id
output provisioningState string = awsguarddutyTable.properties.provisioningState
