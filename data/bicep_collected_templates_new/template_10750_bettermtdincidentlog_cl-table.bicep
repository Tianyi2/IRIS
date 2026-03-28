// Bicep template for Log Analytics custom table: BetterMTDIncidentLog_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 25, Deployed columns: 22 (Type column filtered)
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

resource bettermtdincidentlogclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BetterMTDIncidentLog_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BetterMTDIncidentLog_CL'
      description: 'Custom table BetterMTDIncidentLog_CL - imported from JSON schema'
      displayName: 'BetterMTDIncidentLog_CL'
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
          name: 'Status'
          type: 'string'
        }
        {
          name: 'UserEmail'
          type: 'string'
        }
        {
          name: 'DevicePlatform'
          type: 'string'
        }
        {
          name: 'DeviceId'
          type: 'string'
        }
        {
          name: 'DeviceOS'
          type: 'string'
        }
        {
          name: 'CompanyName'
          type: 'string'
        }
        {
          name: 'CompanyId'
          type: 'real'
        }
        {
          name: 'ThreatDescription'
          type: 'string'
        }
        {
          name: 'EventTimeStamp'
          type: 'dateTime'
        }
        {
          name: 'ThreatCategory'
          type: 'string'
        }
        {
          name: 'ThreatTitle'
          type: 'string'
        }
        {
          name: 'ThreatType'
          type: 'string'
        }
        {
          name: 'ThreatId'
          type: 'real'
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
          name: 'ThreatSeverity'
          type: 'string'
        }
        {
          name: 'LogTimeStamp'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = bettermtdincidentlogclTable.name
output tableId string = bettermtdincidentlogclTable.id
output provisioningState string = bettermtdincidentlogclTable.properties.provisioningState
