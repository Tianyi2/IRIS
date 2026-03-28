@description('The location of the resources')
param location string = 'Australia East'
@description('The name of the Data Collection Endpoint Id')
param dataCollectionEndpointId string
@description('The Log Analytics Workspace Id used for Sentinel')
param workspaceResourceId string
@description('The Target Sentinel workspace name')
param workspaceName string = 'sentinel-workspace'
@description('The Service Principal Object ID of the Entra App')
param servicePrincipalObjectId string

// ============================================================================
// Data Collection Rule for TrendMicroCAS_CL
// ============================================================================
// Generated: 2025-09-19 14:20:36
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 30 (Type column always filtered)
// Output stream: Custom-TrendMicroCAS_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TrendMicroCAS_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TrendMicroCAS_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
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
          }
          {
            name: 'message_file_upload_time_t'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'message_ransomware_name_s'
            type: 'string'
          }
          {
            name: 'message_mail_message_submit_time_t'
            type: 'string'
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
          }
          {
            name: 'message_triggered_policy_name_s'
            type: 'string'
          }
          {
            name: 'message_detection_time_t'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'message_triggered_dlp_template_d'
            type: 'string'
          }
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-TrendMicroCAS_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TrendMicroCAS_CL']
        destinations: ['Sentinel-TrendMicroCAS_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), log_item_id_g = tostring(log_item_id_g), message_detection_type_s = tostring(message_detection_type_s), message_virus_name_s = tostring(message_virus_name_s), message_file_sha256_s = tostring(message_file_sha256_s), message_file_sha1_s = tostring(message_file_sha1_s), message_risk_level_s = tostring(message_risk_level_s), message_detected_by_s = tostring(message_detected_by_s), message_security_risk_name_s = tostring(message_security_risk_name_s), message_file_upload_time_t = todatetime(message_file_upload_time_t), message_file_name_s = tostring(message_file_name_s), message_mail_message_file_name_s = tostring(message_mail_message_file_name_s), message_mail_message_subject_s = tostring(message_mail_message_subject_s), message_mail_message_delivery_time_t = todatetime(message_mail_message_delivery_time_t), message_ransomware_name_s = tostring(message_ransomware_name_s), message_mail_message_submit_time_t = todatetime(message_mail_message_submit_time_t), message_mail_message_sender_s = tostring(message_mail_message_sender_s), message_mail_message_id_g = tostring(message_mail_message_id_g), message_action_result_s = tostring(message_action_result_s), message_action_s = tostring(message_action_s), message_triggered_security_filter_s = tostring(message_triggered_security_filter_s), message_triggered_policy_name_s = tostring(message_triggered_policy_name_s), message_detection_time_t = todatetime(message_detection_time_t), message_location_s = tostring(message_location_s), message_affected_user_s = tostring(message_affected_user_s), message_scan_type_s = tostring(message_scan_type_s), event_s = tostring(event_s), service_s = tostring(service_s), message_mail_message_recipient_d = toreal(message_mail_message_recipient_d), message_triggered_dlp_template_d = toreal(message_triggered_dlp_template_d)'
        outputStream: 'Custom-TrendMicroCAS_CL'
      }
    ]
  }
}

// Role Assignment to the DCR
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: dataCollectionRule
  name: guid(resourceGroup().id, roleDefinitionResourceId, dataCollectionRule.name)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

output immutableId string = dataCollectionRule.properties.immutableId
output dataCollectionRuleId string = dataCollectionRule.id
output dataCollectionRuleName string = dataCollectionRule.name
