// Bicep template for Log Analytics custom table: VMware_SDWAN_FirewallLogs_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 36, Deployed columns: 36 (Type column filtered)
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

resource vmwaresdwanfirewalllogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'VMware_SDWAN_FirewallLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'VMware_SDWAN_FirewallLogs_CL'
      description: 'Custom table VMware_SDWAN_FirewallLogs_CL - imported from JSON schema'
      displayName: 'VMware_SDWAN_FirewallLogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'actionTaken'
          type: 'string'
        }
        {
          name: 'ipsAlert'
          type: 'int'
        }
        {
          name: 'logType'
          type: 'string'
        }
        {
          name: 'protocol'
          type: 'int'
        }
        {
          name: 'ruleId'
          type: 'string'
        }
        {
          name: 'ruleVersion'
          type: 'int'
        }
        {
          name: 'segmentLogicalId'
          type: 'string'
        }
        {
          name: 'inputInterface'
          type: 'dateTime'
        }
        {
          name: 'segmentName'
          type: 'string'
        }
        {
          name: 'sessionId'
          type: 'int'
        }
        {
          name: 'severity'
          type: 'int'
        }
        {
          name: 'signature'
          type: 'string'
        }
        {
          name: 'signatureId'
          type: 'int'
        }
        {
          name: 'sourceIp'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'sourcePort'
          type: 'int'
        }
        {
          name: 'sessionDurationSecs'
          type: 'int'
        }
        {
          name: 'timestamp'
          type: 'dateTime'
        }
        {
          name: 'idsAlert'
          type: 'int'
        }
        {
          name: 'extensionHeader'
          type: 'string'
        }
        {
          name: 'application'
          type: 'string'
        }
        {
          name: 'attackSource'
          type: 'string'
        }
        {
          name: 'attackTarget'
          type: 'string'
        }
        {
          name: 'bytesReceived'
          type: 'int'
        }
        {
          name: 'bytesSent'
          type: 'int'
        }
        {
          name: 'category'
          type: 'string'
        }
        {
          name: 'firewallPolicyName'
          type: 'string'
        }
        {
          name: 'closeReason'
          type: 'string'
        }
        {
          name: 'destinationIp'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'destinationPort'
          type: 'int'
        }
        {
          name: 'domainName'
          type: 'string'
        }
        {
          name: 'edgeLogicalId'
          type: 'string'
        }
        {
          name: 'edgeName'
          type: 'dateTime'
        }
        {
          name: 'enterpriseLogicalId'
          type: 'string'
        }
        {
          name: 'destination'
          type: 'string'
        }
        {
          name: 'verdict'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = vmwaresdwanfirewalllogsclTable.name
output tableId string = vmwaresdwanfirewalllogsclTable.id
output provisioningState string = vmwaresdwanfirewalllogsclTable.properties.provisioningState
