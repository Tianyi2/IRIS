// Bicep template for Log Analytics custom table: Cisco_Umbrella_cloudfirewall_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 16, Deployed columns: 16 (Type column filtered)
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

resource ciscoumbrellacloudfirewallclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Cisco_Umbrella_cloudfirewall_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Cisco_Umbrella_cloudfirewall_CL'
      description: 'Custom table Cisco_Umbrella_cloudfirewall_CL - imported from JSON schema'
      displayName: 'Cisco_Umbrella_cloudfirewall_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventType_s'
          type: 'string'
        }
        {
          name: 'Timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'originId_s'
          type: 'string'
        }
        {
          name: 'Identity_s'
          type: 'string'
        }
        {
          name: 'Identity_Type_s'
          type: 'string'
        }
        {
          name: 'Direction_s'
          type: 'string'
        }
        {
          name: 'ipProtocol_s'
          type: 'string'
        }
        {
          name: 'packetSize_s'
          type: 'string'
        }
        {
          name: 'SourceIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'sourcePort_s'
          type: 'string'
        }
        {
          name: 'destinationIp_s'
          type: 'string'
        }
        {
          name: 'destinationPort_s'
          type: 'string'
        }
        {
          name: 'dataCenter_s'
          type: 'string'
        }
        {
          name: 'ruleId_s'
          type: 'string'
        }
        {
          name: 'verdict_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ciscoumbrellacloudfirewallclTable.name
output tableId string = ciscoumbrellacloudfirewallclTable.id
output provisioningState string = ciscoumbrellacloudfirewallclTable.properties.provisioningState
