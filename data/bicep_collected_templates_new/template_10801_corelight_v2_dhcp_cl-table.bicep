// Bicep template for Log Analytics custom table: Corelight_v2_dhcp_CL
// Generated on 2025-09-19 14:13:51 UTC
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

resource corelightv2dhcpclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_dhcp_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_dhcp_CL'
      description: 'Custom table Corelight_v2_dhcp_CL - imported from JSON schema'
      displayName: 'Corelight_v2_dhcp_CL'
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
          name: 'uids_s'
          type: 'string'
        }
        {
          name: 'client_addr_s'
          type: 'string'
        }
        {
          name: 'server_addr_s'
          type: 'string'
        }
        {
          name: 'mac_s'
          type: 'string'
        }
        {
          name: 'host_name_s'
          type: 'string'
        }
        {
          name: 'client_fqdn_s'
          type: 'string'
        }
        {
          name: 'domain_s'
          type: 'string'
        }
        {
          name: 'requested_addr_s'
          type: 'string'
        }
        {
          name: 'assigned_addr_s'
          type: 'string'
        }
        {
          name: 'lease_time_d'
          type: 'real'
        }
        {
          name: 'client_message_s'
          type: 'string'
        }
        {
          name: 'server_message_s'
          type: 'string'
        }
        {
          name: 'msg_types_s'
          type: 'string'
        }
        {
          name: 'duration_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2dhcpclTable.name
output tableId string = corelightv2dhcpclTable.id
output provisioningState string = corelightv2dhcpclTable.properties.provisioningState
