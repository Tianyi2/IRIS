// Bicep template for Log Analytics custom table: PaloAltoPrismaCloudAudit_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 18, Deployed columns: 16 (Type column filtered)
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

resource paloaltoprismacloudauditclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'PaloAltoPrismaCloudAudit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'PaloAltoPrismaCloudAudit_CL'
      description: 'Custom table PaloAltoPrismaCloudAudit_CL - imported from JSON schema'
      displayName: 'PaloAltoPrismaCloudAudit_CL'
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
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'user_g'
          type: 'string'
        }
        {
          name: 'resourceName_g'
          type: 'string'
          dataTypeHint: 2
        }
        {
          name: 'timestamp_s'
          type: 'string'
        }
        {
          name: 'user_s'
          type: 'string'
        }
        {
          name: 'IPAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ResourceType'
          type: 'string'
        }
        {
          name: 'resourceName_s'
          type: 'string'
          dataTypeHint: 2
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'result_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = paloaltoprismacloudauditclTable.name
output tableId string = paloaltoprismacloudauditclTable.id
output provisioningState string = paloaltoprismacloudauditclTable.properties.provisioningState
