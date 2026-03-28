// Bicep template for Log Analytics custom table: SophosCloudOptix_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 21 (Type column filtered)
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

resource sophoscloudoptixclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SophosCloudOptix_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SophosCloudOptix_CL'
      description: 'Custom table SophosCloudOptix_CL - imported from JSON schema'
      displayName: 'SophosCloudOptix_CL'
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
          name: 'lastSeen_s'
          type: 'string'
        }
        {
          name: 'firstSeen_s'
          type: 'string'
        }
        {
          name: 'alertType_s'
          type: 'string'
        }
        {
          name: 'alertSummary_s'
          type: 'string'
        }
        {
          name: 'alertState_s'
          type: 'string'
        }
        {
          name: 'alertRemediation_s'
          type: 'string'
        }
        {
          name: 'alertLink_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'alertId_s'
          type: 'string'
        }
        {
          name: 'alertDescription_s'
          type: 'string'
        }
        {
          name: 'affectedResources_s'
          type: 'string'
        }
        {
          name: 'accountName_s'
          type: 'string'
        }
        {
          name: 'accountId_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'policyTagName_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = sophoscloudoptixclTable.name
output tableId string = sophoscloudoptixclTable.id
output provisioningState string = sophoscloudoptixclTable.properties.provisioningState
