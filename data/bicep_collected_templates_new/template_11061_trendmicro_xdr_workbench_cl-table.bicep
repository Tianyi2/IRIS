// Bicep template for Log Analytics custom table: TrendMicro_XDR_WORKBENCH_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 20, Deployed columns: 20 (Type column filtered)
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

resource trendmicroxdrworkbenchclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TrendMicro_XDR_WORKBENCH_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TrendMicro_XDR_WORKBENCH_CL'
      description: 'Custom table TrendMicro_XDR_WORKBENCH_CL - imported from JSON schema'
      displayName: 'TrendMicro_XDR_WORKBENCH_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'workbenchName_s'
          type: 'string'
        }
        {
          name: 'RegistryValueName_s'
          type: 'string'
        }
        {
          name: 'RegistryValue_s'
          type: 'string'
        }
        {
          name: 'RegistryKey_s'
          type: 'string'
        }
        {
          name: 'ProcessCommandLine_s'
          type: 'string'
        }
        {
          name: 'FileDirectory_s'
          type: 'string'
        }
        {
          name: 'FileName_s'
          type: 'string'
        }
        {
          name: 'UserAccountNTDomain_s'
          type: 'string'
        }
        {
          name: 'alertTriggerTimestamp_t'
          type: 'dateTime'
        }
        {
          name: 'UserAccountName_s'
          type: 'string'
        }
        {
          name: 'impactScope_Summary_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'createdTime_t'
          type: 'dateTime'
        }
        {
          name: 'priorityScore_d'
          type: 'int'
        }
        {
          name: 'workbenchLink_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'workbenchId_s'
          type: 'string'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'alertProvider_s'
          type: 'string'
        }
        {
          name: 'model_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = trendmicroxdrworkbenchclTable.name
output tableId string = trendmicroxdrworkbenchclTable.id
output provisioningState string = trendmicroxdrworkbenchclTable.properties.provisioningState
