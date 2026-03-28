// Bicep template for Log Analytics custom table: Corelight_v2_dns_red_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 15, Deployed columns: 12 (Type column filtered)
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

resource corelightv2dnsredclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_dns_red_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_dns_red_CL'
      description: 'Custom table Corelight_v2_dns_red_CL - imported from JSON schema'
      displayName: 'Corelight_v2_dns_red_CL'
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
          name: 'query_s'
          type: 'string'
        }
        {
          name: 'qtype_name_s'
          type: 'string'
        }
        {
          name: 'rcode_d'
          type: 'real'
        }
        {
          name: 'answers_s'
          type: 'string'
        }
        {
          name: 'num_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2dnsredclTable.name
output tableId string = corelightv2dnsredclTable.id
output provisioningState string = corelightv2dnsredclTable.properties.provisioningState
