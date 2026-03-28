// Bicep template for Log Analytics custom table: Corelight_v2_signatures_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 16, Deployed columns: 13 (Type column filtered)
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

resource corelightv2signaturesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_signatures_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_signatures_CL'
      description: 'Custom table Corelight_v2_signatures_CL - imported from JSON schema'
      displayName: 'Corelight_v2_signatures_CL'
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
          name: 'src_addr_s'
          type: 'string'
        }
        {
          name: 'src_port_d'
          type: 'real'
        }
        {
          name: 'dst_addr_s'
          type: 'string'
        }
        {
          name: 'dst_port_d'
          type: 'real'
        }
        {
          name: 'note_s'
          type: 'string'
        }
        {
          name: 'sig_id_s'
          type: 'string'
        }
        {
          name: 'event_msg_s'
          type: 'string'
        }
        {
          name: 'sub_msg_s'
          type: 'string'
        }
        {
          name: 'sig_count_d'
          type: 'real'
        }
        {
          name: 'host_count_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2signaturesclTable.name
output tableId string = corelightv2signaturesclTable.id
output provisioningState string = corelightv2signaturesclTable.properties.provisioningState
