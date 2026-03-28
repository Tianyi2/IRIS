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
// Data Collection Rule for ZeroFoxAlertPoller_CL
// ============================================================================
// Generated: 2025-09-19 14:20:41
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 50, DCR columns: 50 (Type column always filtered)
// Output stream: Custom-ZeroFoxAlertPoller_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFoxAlertPoller_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFoxAlertPoller_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'rule_name_s'
            type: 'string'
          }
          {
            name: 'last_modified_t'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'escalated_b'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'perpetrator_url_s'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'rule_group_id_d'
            type: 'string'
          }
          {
            name: 'tags_s'
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
          name: 'Sentinel-ZeroFoxAlertPoller_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFoxAlertPoller_CL']
        destinations: ['Sentinel-ZeroFoxAlertPoller_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), alert_type_s = tostring(alert_type_s), asset_image_s = tostring(asset_image_s), asset_labels_s = tostring(asset_labels_s), asset_entity_group_id_d = toreal(asset_entity_group_id_d), asset_entity_group_name_s = tostring(asset_entity_group_name_s), entered_by_s = tostring(entered_by_s), metadata_s = tostring(metadata_s), status_s = tostring(status_s), timestamp_t = todatetime(timestamp_t), rule_name_s = tostring(rule_name_s), last_modified_t = todatetime(last_modified_t), protected_locations_s = tostring(protected_locations_s), darkweb_term_s = tostring(darkweb_term_s), business_network_s = tostring(business_network_s), reviewed_b = tobool(reviewed_b), escalated_b = tobool(escalated_b), network_s = tostring(network_s), protected_social_object_s = tostring(protected_social_object_s), notes_s = tostring(notes_s), reviews_s = tostring(reviews_s), rule_id_d = toreal(rule_id_d), entity_account_s = tostring(entity_account_s), asset_name_s = tostring(asset_name_s), entity_email_receiver_id_s = tostring(entity_email_receiver_id_s), asset_id_d = toreal(asset_id_d), perpetrator_network_s = tostring(perpetrator_network_s), logs_s = tostring(logs_s), offending_content_url_s = tostring(offending_content_url_s), asset_term_s = tostring(asset_term_s), assignee_s = tostring(assignee_s), entity_id_d = toreal(entity_id_d), entity_name_s = tostring(entity_name_s), entity_image_s = tostring(entity_image_s), entity_labels_s = tostring(entity_labels_s), entity_entity_group_id_d = toreal(entity_entity_group_id_d), entity_entity_group_name_s = tostring(entity_entity_group_name_s), entity_term_s = tostring(entity_term_s), content_created_at_t = todatetime(content_created_at_t), id_d = toreal(id_d), Severity = toreal(Severity), perpetrator_name_s = tostring(perpetrator_name_s), perpetrator_display_name_s = tostring(perpetrator_display_name_s), perpetrator_id_d = toreal(perpetrator_id_d), perpetrator_url_s = tostring(perpetrator_url_s), perpetrator_content_s = tostring(perpetrator_content_s), perpetrator_type_s = tostring(perpetrator_type_s), perpetrator_timestamp_t = todatetime(perpetrator_timestamp_t), rule_group_id_d = toreal(rule_group_id_d), tags_s = tostring(tags_s)'
        outputStream: 'Custom-ZeroFoxAlertPoller_CL'
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
