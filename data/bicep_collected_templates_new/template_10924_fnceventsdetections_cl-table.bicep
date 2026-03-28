// Bicep template for Log Analytics custom table: FncEventsDetections_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 29 (Type column filtered)
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

resource fnceventsdetectionsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'FncEventsDetections_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'FncEventsDetections_CL'
      description: 'Custom table FncEventsDetections_CL - imported from JSON schema'
      displayName: 'FncEventsDetections_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'vendor_s'
          type: 'string'
        }
        {
          name: 'primary_dhcp_machost_pairs_s'
          type: 'string'
        }
        {
          name: 'other_pdns_hostnames_s'
          type: 'string'
        }
        {
          name: 'primary_pdns_hostnames_s'
          type: 'string'
        }
        {
          name: 'customer_id_s'
          type: 'string'
        }
        {
          name: 'indicators_s'
          type: 'string'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'uuid_g'
          type: 'string'
        }
        {
          name: 'updated_t'
          type: 'dateTime'
        }
        {
          name: 'created_t'
          type: 'dateTime'
        }
        {
          name: 'last_seen_t'
          type: 'dateTime'
        }
        {
          name: 'first_seen_t'
          type: 'dateTime'
        }
        {
          name: 'muted_comment_s'
          type: 'string'
        }
        {
          name: 'rule_uuid_g'
          type: 'string'
        }
        {
          name: 'muted_rule_b'
          type: 'boolean'
        }
        {
          name: 'muted_b'
          type: 'boolean'
        }
        {
          name: 'sensor_id_s'
          type: 'string'
        }
        {
          name: 'confidence_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'device_ip_s'
          type: 'string'
        }
        {
          name: 'timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'signal_version_s'
          type: 'string'
        }
        {
          name: 'product_s'
          type: 'string'
        }
        {
          name: 'other_dhcp_machost_pairs_s'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = fnceventsdetectionsclTable.name
output tableId string = fnceventsdetectionsclTable.id
output provisioningState string = fnceventsdetectionsclTable.properties.provisioningState
