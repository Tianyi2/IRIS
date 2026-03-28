// Bicep template for Log Analytics custom table: Corelight_v2_snmp_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 19, Deployed columns: 16 (Type column filtered)
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

resource corelightv2snmpclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_snmp_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_snmp_CL'
      description: 'Custom table Corelight_v2_snmp_CL - imported from JSON schema'
      displayName: 'Corelight_v2_snmp_CL'
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
          name: 'id_orig_h_s'
          type: 'string'
        }
        {
          name: 'id_orig_p_d'
          type: 'real'
        }
        {
          name: 'id_resp_h_s'
          type: 'string'
        }
        {
          name: 'id_resp_p_d'
          type: 'real'
        }
        {
          name: 'duration_d'
          type: 'real'
        }
        {
          name: 'version_s'
          type: 'string'
        }
        {
          name: 'community_s'
          type: 'string'
        }
        {
          name: 'get_requests_d'
          type: 'real'
        }
        {
          name: 'get_bulk_requests_d'
          type: 'real'
        }
        {
          name: 'get_responses_d'
          type: 'real'
        }
        {
          name: 'set_requests_d'
          type: 'real'
        }
        {
          name: 'display_string_s'
          type: 'string'
        }
        {
          name: 'up_since_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = corelightv2snmpclTable.name
output tableId string = corelightv2snmpclTable.id
output provisioningState string = corelightv2snmpclTable.properties.provisioningState
