// Bicep template for Log Analytics custom table: HackerViewLog_Azure_1_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 34, Deployed columns: 33 (Type column filtered)
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

resource hackerviewlogazure1clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'HackerViewLog_Azure_1_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'HackerViewLog_Azure_1_CL'
      description: 'Custom table HackerViewLog_Azure_1_CL - imported from JSON schema'
      displayName: 'HackerViewLog_Azure_1_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'progress_status_s'
          type: 'string'
        }
        {
          name: 'potential_impact_s'
          type: 'string'
        }
        {
          name: 'potential_attack_type_s'
          type: 'string'
        }
        {
          name: 'meta_ticket_id_s'
          type: 'string'
        }
        {
          name: 'meta_technologies_s'
          type: 'string'
        }
        {
          name: 'meta_resolved_ip_s'
          type: 'string'
        }
        {
          name: 'meta_last_seen_s'
          type: 'string'
        }
        {
          name: 'meta_ip_type_s'
          type: 'string'
        }
        {
          name: 'meta_ip_s'
          type: 'string'
        }
        {
          name: 'meta_hosts_s'
          type: 'string'
        }
        {
          name: 'meta_host_type_s'
          type: 'string'
        }
        {
          name: 'meta_host_s'
          type: 'string'
        }
        {
          name: 'meta_first_seen_s'
          type: 'string'
        }
        {
          name: 'meta_environments_s'
          type: 'string'
        }
        {
          name: 'meta_domain_s'
          type: 'string'
        }
        {
          name: 'meta_discovery_source_s'
          type: 'string'
        }
        {
          name: 'meta_business_unit_s'
          type: 'string'
        }
        {
          name: 'meta_brand_s'
          type: 'string'
        }
        {
          name: 'meta_asset_type_s'
          type: 'string'
        }
        {
          name: 'meta_asset_s'
          type: 'string'
        }
        {
          name: 'issue_type_s'
          type: 'string'
        }
        {
          name: 'issue_name_s'
          type: 'string'
        }
        {
          name: 'issue_category_s'
          type: 'string'
        }
        {
          name: 'hackerview_link_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'fixing_effort_s'
          type: 'string'
        }
        {
          name: 'detail_s'
          type: 'string'
        }
        {
          name: 'cwe_s'
          type: 'string'
        }
        {
          name: 'assigned_to_s'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'status_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = hackerviewlogazure1clTable.name
output tableId string = hackerviewlogazure1clTable.id
output provisioningState string = hackerviewlogazure1clTable.properties.provisioningState
