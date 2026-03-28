// Bicep template for Log Analytics custom table: Corelight_v2_stepping_CL
// Generated on 2025-09-19 14:13:53 UTC
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

resource corelightv2steppingclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_stepping_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_stepping_CL'
      description: 'Custom table Corelight_v2_stepping_CL - imported from JSON schema'
      displayName: 'Corelight_v2_stepping_CL'
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
          name: 'dt_d'
          type: 'real'
        }
        {
          name: 'uid1_s'
          type: 'string'
        }
        {
          name: 'uid2_s'
          type: 'string'
        }
        {
          name: 'direct_b'
          type: 'boolean'
        }
        {
          name: 'client1_h_s'
          type: 'string'
        }
        {
          name: 'client1_p_d'
          type: 'real'
        }
        {
          name: 'server1_h_s'
          type: 'string'
        }
        {
          name: 'server1_p_d'
          type: 'real'
        }
        {
          name: 'client2_h_s'
          type: 'string'
        }
        {
          name: 'client2_p_d'
          type: 'real'
        }
        {
          name: 'server2_h_s'
          type: 'string'
        }
        {
          name: 'server2_p_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2steppingclTable.name
output tableId string = corelightv2steppingclTable.id
output provisioningState string = corelightv2steppingclTable.properties.provisioningState
