// Bicep template for Log Analytics custom table: Corelight_v2_local_subnets_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 13, Deployed columns: 10 (Type column filtered)
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

resource corelightv2localsubnetsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_local_subnets_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_local_subnets_CL'
      description: 'Custom table Corelight_v2_local_subnets_CL - imported from JSON schema'
      displayName: 'Corelight_v2_local_subnets_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'round_d'
          type: 'real'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'ip_version_d'
          type: 'real'
        }
        {
          name: 'subnets_s'
          type: 'string'
        }
        {
          name: 'component_ids_s'
          type: 'string'
        }
        {
          name: 'size_of_component_d'
          type: 'real'
        }
        {
          name: 'bipartite_b'
          type: 'boolean'
        }
        {
          name: 'inferred_site_b'
          type: 'boolean'
        }
        {
          name: 'other_ips_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2localsubnetsclTable.name
output tableId string = corelightv2localsubnetsclTable.id
output provisioningState string = corelightv2localsubnetsclTable.properties.provisioningState
