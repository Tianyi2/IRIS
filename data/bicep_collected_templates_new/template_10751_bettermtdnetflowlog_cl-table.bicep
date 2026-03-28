// Bicep template for Log Analytics custom table: BetterMTDNetflowLog_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 36, Deployed columns: 34 (Type column filtered)
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

resource bettermtdnetflowlogclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BetterMTDNetflowLog_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BetterMTDNetflowLog_CL'
      description: 'Custom table BetterMTDNetflowLog_CL - imported from JSON schema'
      displayName: 'BetterMTDNetflowLog_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Account'
          type: 'string'
        }
        {
          name: 'UrlStatus'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'Url'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'UDID'
          type: 'string'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'Status_s'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'SourceLon'
          type: 'real'
        }
        {
          name: 'SourceLat'
          type: 'real'
        }
        {
          name: 'SourceCountryCode'
          type: 'string'
        }
        {
          name: 'SourceCountry'
          type: 'string'
        }
        {
          name: 'SourceClient'
          type: 'string'
        }
        {
          name: 'Scheme'
          type: 'string'
        }
        {
          name: 'Reason'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Username'
          type: 'string'
        }
        {
          name: 'Port'
          type: 'real'
        }
        {
          name: 'NetworkType'
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
          name: 'Host'
          type: 'string'
        }
        {
          name: 'DeviceName'
          type: 'string'
        }
        {
          name: 'DestinationLon'
          type: 'real'
        }
        {
          name: 'DestinationLat'
          type: 'real'
        }
        {
          name: 'DestinationCountryCode'
          type: 'string'
        }
        {
          name: 'DestinationCountry'
          type: 'string'
        }
        {
          name: 'Destination'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'Cid'
          type: 'real'
        }
        {
          name: 'AppName'
          type: 'string'
        }
        {
          name: 'AppIdentifier'
          type: 'string'
        }
        {
          name: 'Path'
          type: 'string'
        }
        {
          name: 'UUId'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bettermtdnetflowlogclTable.name
output tableId string = bettermtdnetflowlogclTable.id
output provisioningState string = bettermtdnetflowlogclTable.properties.provisioningState
