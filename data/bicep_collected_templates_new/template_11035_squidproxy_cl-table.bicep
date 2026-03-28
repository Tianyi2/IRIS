// Bicep template for Log Analytics custom table: SquidProxy_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 26, Deployed columns: 23 (Type column filtered)
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

resource squidproxyclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SquidProxy_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SquidProxy_CL'
      description: 'Custom table SquidProxy_CL - imported from JSON schema'
      displayName: 'SquidProxy_CL'
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
          name: 'ContentType_s'
          type: 'string'
        }
        {
          name: 'PeerHost'
          type: 'string'
        }
        {
          name: 'PeerStatus_s'
          type: 'string'
        }
        {
          name: 'Username_s'
          type: 'string'
        }
        {
          name: 'Url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'RequstMethod_s'
          type: 'string'
        }
        {
          name: 'Bytes_s'
          type: 'string'
        }
        {
          name: 'StatusCode_s'
          type: 'string'
        }
        {
          name: 'ResultCode'
          type: 'string'
        }
        {
          name: 'SrcIpAddr_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'Duration_s'
          type: 'string'
        }
        {
          name: 'Type_s'
          type: 'string'
        }
        {
          name: 'MG_s'
          type: 'string'
        }
        {
          name: 'TenantId_s'
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
          name: 'EventTime_UTC__s'
          type: 'string'
        }
        {
          name: 'Description_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = squidproxyclTable.name
output tableId string = squidproxyclTable.id
output provisioningState string = squidproxyclTable.properties.provisioningState
