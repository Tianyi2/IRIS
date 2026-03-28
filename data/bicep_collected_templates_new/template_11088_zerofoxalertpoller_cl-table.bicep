// Bicep template for Log Analytics custom table: ZeroFoxAlertPoller_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 50, Deployed columns: 50 (Type column filtered)
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

resource zerofoxalertpollerclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFoxAlertPoller_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFoxAlertPoller_CL'
      description: 'Custom table ZeroFoxAlertPoller_CL - imported from JSON schema'
      displayName: 'ZeroFoxAlertPoller_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'alert_type_s'
          type: 'string'
        }
        {
          name: 'asset_image_s'
          type: 'string'
        }
        {
          name: 'asset_labels_s'
          type: 'string'
        }
        {
          name: 'asset_entity_group_id_d'
          type: 'real'
        }
        {
          name: 'asset_entity_group_name_s'
          type: 'string'
        }
        {
          name: 'entered_by_s'
          type: 'string'
        }
        {
          name: 'metadata_s'
          type: 'string'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'rule_name_s'
          type: 'string'
        }
        {
          name: 'last_modified_t'
          type: 'dateTime'
        }
        {
          name: 'protected_locations_s'
          type: 'string'
        }
        {
          name: 'darkweb_term_s'
          type: 'string'
        }
        {
          name: 'business_network_s'
          type: 'string'
        }
        {
          name: 'reviewed_b'
          type: 'boolean'
        }
        {
          name: 'escalated_b'
          type: 'boolean'
        }
        {
          name: 'network_s'
          type: 'string'
        }
        {
          name: 'protected_social_object_s'
          type: 'string'
        }
        {
          name: 'notes_s'
          type: 'string'
        }
        {
          name: 'reviews_s'
          type: 'string'
        }
        {
          name: 'rule_id_d'
          type: 'real'
        }
        {
          name: 'entity_account_s'
          type: 'string'
        }
        {
          name: 'asset_name_s'
          type: 'string'
        }
        {
          name: 'entity_email_receiver_id_s'
          type: 'string'
        }
        {
          name: 'asset_id_d'
          type: 'real'
        }
        {
          name: 'perpetrator_network_s'
          type: 'string'
        }
        {
          name: 'logs_s'
          type: 'string'
        }
        {
          name: 'offending_content_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'asset_term_s'
          type: 'string'
        }
        {
          name: 'assignee_s'
          type: 'string'
        }
        {
          name: 'entity_id_d'
          type: 'real'
        }
        {
          name: 'entity_name_s'
          type: 'string'
        }
        {
          name: 'entity_image_s'
          type: 'string'
        }
        {
          name: 'entity_labels_s'
          type: 'string'
        }
        {
          name: 'entity_entity_group_id_d'
          type: 'real'
        }
        {
          name: 'entity_entity_group_name_s'
          type: 'string'
        }
        {
          name: 'entity_term_s'
          type: 'string'
        }
        {
          name: 'content_created_at_t'
          type: 'dateTime'
        }
        {
          name: 'id_d'
          type: 'real'
        }
        {
          name: 'Severity'
          type: 'real'
        }
        {
          name: 'perpetrator_name_s'
          type: 'string'
        }
        {
          name: 'perpetrator_display_name_s'
          type: 'string'
        }
        {
          name: 'perpetrator_id_d'
          type: 'real'
        }
        {
          name: 'perpetrator_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'perpetrator_content_s'
          type: 'string'
        }
        {
          name: 'perpetrator_type_s'
          type: 'string'
        }
        {
          name: 'perpetrator_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'rule_group_id_d'
          type: 'real'
        }
        {
          name: 'tags_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zerofoxalertpollerclTable.name
output tableId string = zerofoxalertpollerclTable.id
output provisioningState string = zerofoxalertpollerclTable.properties.provisioningState
