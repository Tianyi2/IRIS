// Bicep template for Log Analytics custom table: Cisco_Umbrella_dns_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 15, Deployed columns: 15 (Type column filtered)
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

resource ciscoumbrelladnsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Cisco_Umbrella_dns_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Cisco_Umbrella_dns_CL'
      description: 'Custom table Cisco_Umbrella_dns_CL - imported from JSON schema'
      displayName: 'Cisco_Umbrella_dns_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'InternalIp_s'
          type: 'string'
        }
        {
          name: 'ExternalIp_s'
          type: 'string'
        }
        {
          name: 'Action_s'
          type: 'string'
        }
        {
          name: 'Domain_s'
          type: 'string'
        }
        {
          name: 'Categories_s'
          type: 'string'
        }
        {
          name: 'Blocked_Categories_s'
          type: 'string'
        }
        {
          name: 'Identities_s'
          type: 'string'
        }
        {
          name: 'QueryType_s'
          type: 'string'
        }
        {
          name: 'ResponseCode_s'
          type: 'string'
        }
        {
          name: 'Identity_Types_s'
          type: 'string'
        }
        {
          name: 'EventType_s'
          type: 'string'
        }
        {
          name: 'Policy_Identity_s'
          type: 'string'
        }
        {
          name: 'Policy_Identity_Type_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ciscoumbrelladnsclTable.name
output tableId string = ciscoumbrelladnsclTable.id
output provisioningState string = ciscoumbrelladnsclTable.properties.provisioningState
