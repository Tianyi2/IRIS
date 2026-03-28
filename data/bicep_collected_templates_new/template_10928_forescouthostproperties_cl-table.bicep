// Bicep template for Log Analytics custom table: ForescoutHostProperties_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 6, Deployed columns: 6 (Type column filtered)
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

resource forescouthostpropertiesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ForescoutHostProperties_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ForescoutHostProperties_CL'
      description: 'Custom table ForescoutHostProperties_CL - imported from JSON schema'
      displayName: 'ForescoutHostProperties_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'HostProperties_DnsniffEvent_s'
          type: 'string'
        }
        {
          name: 'HostProperties_Ipv4Addr_s'
          type: 'string'
        }
        {
          name: 'HostProperties_Ipv6Addr_s'
          type: 'string'
        }
        {
          name: 'HostProperties_IpAddr_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'HostProperties_EmIpAddr_s'
          type: 'string'
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = forescouthostpropertiesclTable.name
output tableId string = forescouthostpropertiesclTable.id
output provisioningState string = forescouthostpropertiesclTable.properties.provisioningState
