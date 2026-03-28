// Bicep template for Log Analytics custom table: TrendMicroCAS_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 30 (Type column filtered)
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

resource trendmicrocasclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TrendMicroCAS_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TrendMicroCAS_CL'
      description: 'Custom table TrendMicroCAS_CL - imported from JSON schema'
      displayName: 'TrendMicroCAS_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'log_item_id_g'
          type: 'string'
        }
        {
          name: 'message_detection_type_s'
          type: 'string'
        }
        {
          name: 'message_virus_name_s'
          type: 'string'
        }
        {
          name: 'message_file_sha256_s'
          type: 'string'
        }
        {
          name: 'message_file_sha1_s'
          type: 'string'
        }
        {
          name: 'message_risk_level_s'
          type: 'string'
        }
        {
          name: 'message_detected_by_s'
          type: 'string'
        }
        {
          name: 'message_security_risk_name_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'message_file_upload_time_t'
          type: 'dateTime'
        }
        {
          name: 'message_file_name_s'
          type: 'string'
        }
        {
          name: 'message_mail_message_file_name_s'
          type: 'string'
        }
        {
          name: 'message_mail_message_subject_s'
          type: 'string'
        }
        {
          name: 'message_mail_message_delivery_time_t'
          type: 'dateTime'
        }
        {
          name: 'message_ransomware_name_s'
          type: 'string'
        }
        {
          name: 'message_mail_message_submit_time_t'
          type: 'dateTime'
        }
        {
          name: 'message_mail_message_sender_s'
          type: 'string'
        }
        {
          name: 'message_mail_message_id_g'
          type: 'string'
        }
        {
          name: 'message_action_result_s'
          type: 'string'
        }
        {
          name: 'message_action_s'
          type: 'string'
        }
        {
          name: 'message_triggered_security_filter_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'message_triggered_policy_name_s'
          type: 'string'
        }
        {
          name: 'message_detection_time_t'
          type: 'dateTime'
        }
        {
          name: 'message_location_s'
          type: 'string'
        }
        {
          name: 'message_affected_user_s'
          type: 'string'
        }
        {
          name: 'message_scan_type_s'
          type: 'string'
        }
        {
          name: 'event_s'
          type: 'string'
        }
        {
          name: 'service_s'
          type: 'string'
        }
        {
          name: 'message_mail_message_recipient_d'
          type: 'real'
        }
        {
          name: 'message_triggered_dlp_template_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = trendmicrocasclTable.name
output tableId string = trendmicrocasclTable.id
output provisioningState string = trendmicrocasclTable.properties.provisioningState
