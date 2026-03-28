// Bicep template for Log Analytics custom table: NCProtectUAL_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 22, Deployed columns: 19 (Type column filtered)
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

resource ncprotectualclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'NCProtectUAL_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'NCProtectUAL_CL'
      description: 'Custom table NCProtectUAL_CL - imported from JSON schema'
      displayName: 'NCProtectUAL_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Application_s'
          type: 'string'
        }
        {
          name: 'UserDisplayName_s'
          type: 'string'
        }
        {
          name: 'Type_s'
          type: 'string'
        }
        {
          name: 'Status_s'
          type: 'string'
        }
        {
          name: 'SHA512Hash_s'
          type: 'string'
        }
        {
          name: 'Sender_s'
          type: 'string'
        }
        {
          name: 'RuleUrl_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'RuleName_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'OS_s'
          type: 'string'
        }
        {
          name: 'JSONExtra_s'
          type: 'string'
        }
        {
          name: 'Id_s'
          type: 'string'
        }
        {
          name: 'DocumentUrl_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'DocumentProtectionId_g'
          type: 'string'
        }
        {
          name: 'Computer_s'
          type: 'string'
        }
        {
          name: 'Browser_s'
          type: 'string'
        }
        {
          name: 'UserLoginName_s'
          type: 'string'
        }
        {
          name: 'UserEmail_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ncprotectualclTable.name
output tableId string = ncprotectualclTable.id
output provisioningState string = ncprotectualclTable.properties.provisioningState
