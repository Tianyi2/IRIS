// Bicep template for Log Analytics custom table: TaniumSCCMClientHealth_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 11, Deployed columns: 10 (Type column filtered)
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

resource taniumsccmclienthealthclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TaniumSCCMClientHealth_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TaniumSCCMClientHealth_CL'
      description: 'Custom table TaniumSCCMClientHealth_CL - imported from JSON schema'
      displayName: 'TaniumSCCMClientHealth_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Age_s'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'Computer_Name_s'
          type: 'string'
        }
        {
          name: 'Count_s'
          type: 'string'
        }
        {
          name: 'Health_Status_s'
          type: 'string'
        }
        {
          name: 'IP_Address_s'
          type: 'string'
        }
        {
          name: 'OS_Platform_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Reason_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = taniumsccmclienthealthclTable.name
output tableId string = taniumsccmclienthealthclTable.id
output provisioningState string = taniumsccmclienthealthclTable.properties.provisioningState
