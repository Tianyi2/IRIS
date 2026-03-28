// Bicep template for Log Analytics custom table: Corelight_v2_log4shell_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 14 (Type column filtered)
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

resource corelightv2log4shellclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_log4shell_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_log4shell_CL'
      description: 'Custom table Corelight_v2_log4shell_CL - imported from JSON schema'
      displayName: 'Corelight_v2_log4shell_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 'http_uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'stem_s'
          type: 'string'
        }
        {
          name: 'target_host_s'
          type: 'string'
        }
        {
          name: 'target_port_s'
          type: 'string'
        }
        {
          name: 'method_s'
          type: 'string'
        }
        {
          name: 'is_orig_b'
          type: 'boolean'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'value_s'
          type: 'string'
        }
        {
          name: 'matched_name_b'
          type: 'boolean'
        }
        {
          name: 'matched_value_b'
          type: 'boolean'
        }
      ]
    }
  }
}

output tableName string = corelightv2log4shellclTable.name
output tableId string = corelightv2log4shellclTable.id
output provisioningState string = corelightv2log4shellclTable.properties.provisioningState
