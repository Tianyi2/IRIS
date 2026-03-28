// Bicep template for Log Analytics custom table: Corelight_v2_suricata_zeek_stats_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 12, Deployed columns: 9 (Type column filtered)
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

resource corelightv2suricatazeekstatsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_suricata_zeek_stats_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_suricata_zeek_stats_CL'
      description: 'Custom table Corelight_v2_suricata_zeek_stats_CL - imported from JSON schema'
      displayName: 'Corelight_v2_suricata_zeek_stats_CL'
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
          name: 'raised_alerts_d'
          type: 'real'
        }
        {
          name: 'matched_conn_alerts_d'
          type: 'real'
        }
        {
          name: 'unparsed_alerts_d'
          type: 'real'
        }
        {
          name: 'closed_conn_alerts_d'
          type: 'real'
        }
        {
          name: 'unmatched_conn_alerts_d'
          type: 'real'
        }
        {
          name: 'uniq_matched_conns_d'
          type: 'real'
        }
        {
          name: 'uniq_closed_conns_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2suricatazeekstatsclTable.name
output tableId string = corelightv2suricatazeekstatsclTable.id
output provisioningState string = corelightv2suricatazeekstatsclTable.properties.provisioningState
