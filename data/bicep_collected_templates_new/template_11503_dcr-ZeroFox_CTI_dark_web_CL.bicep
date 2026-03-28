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
// Data Collection Rule for ZeroFox_CTI_dark_web_CL
// ============================================================================
// Generated: 2025-09-19 14:20:39
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 19, DCR columns: 19 (Type column always filtered)
// Output stream: Custom-ZeroFox_CTI_dark_web_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZeroFox_CTI_dark_web_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZeroFox_CTI_dark_web_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'content_audience_s'
            type: 'string'
          }
          {
            name: 'thread_uuid_g'
            type: 'string'
          }
          {
            name: 'thread_url_s'
            type: 'string'
          }
          {
            name: 'thread_name_s'
            type: 'string'
          }
          {
            name: 'sequence_number_d'
            type: 'string'
          }
          {
            name: 'post_uuid_g'
            type: 'string'
          }
          {
            name: 'post_type_s'
            type: 'string'
          }
          {
            name: 'post_member_name_s'
            type: 'string'
          }
          {
            name: 'timestamp_t'
            type: 'string'
          }
          {
            name: 'post_body_s'
            type: 'string'
          }
          {
            name: 'parent_uuid_g'
            type: 'string'
          }
          {
            name: 'network_type_s'
            type: 'string'
          }
          {
            name: 'language_code_s'
            type: 'string'
          }
          {
            name: 'general_topic_s'
            type: 'string'
          }
          {
            name: 'forum_uuid_g'
            type: 'string'
          }
          {
            name: 'forum_name_s'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'created_at_t'
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
          name: 'Sentinel-ZeroFox_CTI_dark_web_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZeroFox_CTI_dark_web_CL']
        destinations: ['Sentinel-ZeroFox_CTI_dark_web_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), content_audience_s = tostring(content_audience_s), thread_uuid_g = toguid(thread_uuid_g), thread_url_s = tostring(thread_url_s), thread_name_s = tostring(thread_name_s), sequence_number_d = toreal(sequence_number_d), post_uuid_g = toguid(post_uuid_g), post_type_s = tostring(post_type_s), post_member_name_s = tostring(post_member_name_s), timestamp_t = todatetime(timestamp_t), post_body_s = tostring(post_body_s), parent_uuid_g = toguid(parent_uuid_g), network_type_s = tostring(network_type_s), language_code_s = tostring(language_code_s), general_topic_s = tostring(general_topic_s), forum_uuid_g = toguid(forum_uuid_g), forum_name_s = tostring(forum_name_s), domain_s = tostring(domain_s), created_at_t = todatetime(created_at_t)'
        outputStream: 'Custom-ZeroFox_CTI_dark_web_CL'
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
