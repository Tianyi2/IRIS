// Bicep template for Log Analytics custom table: Corelight_v2_known_services_CL
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

resource corelightv2knownservicesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_known_services_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_known_services_CL'
      description: 'Custom table Corelight_v2_known_services_CL - imported from JSON schema'
      displayName: 'Corelight_v2_known_services_CL'
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
          name: 'duration_d'
          type: 'real'
        }
        {
          name: 'kuid_s'
          type: 'string'
        }
        {
          name: 'host_ip_s'
          type: 'string'
        }
        {
          name: 'port_num_d'
          type: 'real'
        }
        {
          name: 'protocol_s'
          type: 'string'
        }
        {
          name: 'service_s'
          type: 'string'
        }
        {
          name: 'software_s'
          type: 'string'
        }
        {
          name: 'app_s'
          type: 'string'
        }
        {
          name: 'num_conns_d'
          type: 'real'
        }
        {
          name: 'annotations_s'
          type: 'string'
        }
        {
          name: 'last_active_session_s'
          type: 'string'
        }
        {
          name: 'last_active_interval_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2knownservicesclTable.name
output tableId string = corelightv2knownservicesclTable.id
output provisioningState string = corelightv2knownservicesclTable.properties.provisioningState
