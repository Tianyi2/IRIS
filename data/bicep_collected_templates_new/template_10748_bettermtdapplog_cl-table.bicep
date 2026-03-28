// Bicep template for Log Analytics custom table: BetterMTDAppLog_CL
// Generated on 2025-09-19 14:13:50 UTC
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

resource bettermtdapplogclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BetterMTDAppLog_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BetterMTDAppLog_CL'
      description: 'Custom table BetterMTDAppLog_CL - imported from JSON schema'
      displayName: 'BetterMTDAppLog_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'AppName'
          type: 'string'
        }
        {
          name: 'AppStatus_s'
          type: 'string'
        }
        {
          name: 'BundleId'
          type: 'string'
        }
        {
          name: 'CompanyId'
          type: 'real'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'DateAdded'
          type: 'dateTime'
        }
        {
          name: 'DeviceUDID'
          type: 'string'
        }
        {
          name: 'IsMdm'
          type: 'real'
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
          name: 'Platform'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'Version'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = bettermtdapplogclTable.name
output tableId string = bettermtdapplogclTable.id
output provisioningState string = bettermtdapplogclTable.properties.provisioningState
