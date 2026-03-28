// Bicep template for Log Analytics custom table: ESIExchangeConfig_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 21, Deployed columns: 19 (Type column filtered)
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

resource esiexchangeconfigclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ESIExchangeConfig_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ESIExchangeConfig_CL'
      description: 'Custom table ESIExchangeConfig_CL - imported from JSON schema'
      displayName: 'ESIExchangeConfig_CL'
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
          name: 'ExecutionResult_s'
          type: 'string'
        }
        {
          name: 'WhenChanged_s'
          type: 'string'
        }
        {
          name: 'WhenCreated_s'
          type: 'string'
        }
        {
          name: 'Identity_s'
          type: 'string'
        }
        {
          name: 'Name_s'
          type: 'string'
        }
        {
          name: 'PSCmdL_s'
          type: 'string'
        }
        {
          name: 'Section_s'
          type: 'string'
        }
        {
          name: 'EntryDate_s'
          type: 'string'
        }
        {
          name: 'ESIEnvironment_s'
          type: 'string'
        }
        {
          name: 'GenerationInstanceID_g'
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
          name: 'rawData_s'
          type: 'string'
        }
        {
          name: 'IdentityString_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = esiexchangeconfigclTable.name
output tableId string = esiexchangeconfigclTable.id
output provisioningState string = esiexchangeconfigclTable.properties.provisioningState
