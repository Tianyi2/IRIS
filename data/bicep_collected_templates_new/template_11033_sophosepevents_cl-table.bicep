// Bicep template for Log Analytics custom table: SophosEPEvents_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 29, Deployed columns: 29 (Type column filtered)
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

resource sophosepeventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SophosEPEvents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SophosEPEvents_CL'
      description: 'Custom table SophosEPEvents_CL - imported from JSON schema'
      displayName: 'SophosEPEvents_CL'
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
          name: 'DstUserSid'
          type: 'string'
        }
        {
          name: 'DvcAction'
          type: 'string'
        }
        {
          name: 'ThreatName'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'source_info'
          type: 'dynamic'
        }
        {
          name: 'Source'
          type: 'string'
        }
        {
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'EventSubType'
          type: 'string'
        }
        {
          name: 'EventMessage'
          type: 'string'
        }
        {
          name: 'DvcHostname'
          type: 'string'
        }
        {
          name: 'ips_threat_data'
          type: 'dynamic'
        }
        {
          name: 'EventOriginalUid'
          type: 'string'
        }
        {
          name: 'ThreatCategory'
          type: 'string'
        }
        {
          name: 'SrcDvcType'
          type: 'string'
        }
        {
          name: 'EndpointId'
          type: 'string'
        }
        {
          name: 'details'
          type: 'dynamic'
        }
        {
          name: 'CustomerId'
          type: 'string'
        }
        {
          name: 'Created'
          type: 'dateTime'
        }
        {
          name: 'CoreRemedyTotalItems'
          type: 'int'
        }
        {
          name: 'CoreRemedyItems'
          type: 'string'
        }
        {
          name: 'AppSha256'
          type: 'string'
        }
        {
          name: 'appCerts'
          type: 'dynamic'
        }
        {
          name: 'amsi_threat_data'
          type: 'dynamic'
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
        }
        {
          name: 'whitelist_properties'
          type: 'dynamic'
        }
      ]
    }
  }
}

output tableName string = sophosepeventsclTable.name
output tableId string = sophosepeventsclTable.id
output provisioningState string = sophosepeventsclTable.properties.provisioningState
