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
// Data Collection Rule for SlackAudit_CL
// ============================================================================
// Generated: 2025-09-19 14:20:32
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 28 (Type column always filtered)
// Output stream: Custom-SlackAudit_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SlackAudit_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SlackAudit_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'context_ip_address_s'
            type: 'string'
          }
          {
            name: 'context_ua_s'
            type: 'string'
          }
          {
            name: 'context_location_domain_s'
            type: 'string'
          }
          {
            name: 'context_location_name_s'
            type: 'string'
          }
          {
            name: 'context_location_id_s'
            type: 'string'
          }
          {
            name: 'context_location_type_s'
            type: 'string'
          }
          {
            name: 'entity_file_title_s'
            type: 'string'
          }
          {
            name: 'entity_file_filetype_s'
            type: 'string'
          }
          {
            name: 'entity_file_name_s'
            type: 'string'
          }
          {
            name: 'entity_file_id_s'
            type: 'string'
          }
          {
            name: 'entity_type_s'
            type: 'string'
          }
          {
            name: 'context_session_id_d'
            type: 'string'
          }
          {
            name: 'actor_user_team_s'
            type: 'string'
          }
          {
            name: 'actor_user_name_s'
            type: 'string'
          }
          {
            name: 'actor_user_id_s'
            type: 'string'
          }
          {
            name: 'actor_type_s'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'date_create_d'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'actor_user_email_s'
            type: 'string'
          }
          {
            name: 'action_description_s'
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
          name: 'Sentinel-SlackAudit_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SlackAudit_CL']
        destinations: ['Sentinel-SlackAudit_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), context_ip_address_s = tostring(context_ip_address_s), context_ua_s = tostring(context_ua_s), context_location_domain_s = tostring(context_location_domain_s), context_location_name_s = tostring(context_location_name_s), context_location_id_s = tostring(context_location_id_s), context_location_type_s = tostring(context_location_type_s), entity_file_title_s = tostring(entity_file_title_s), entity_file_filetype_s = tostring(entity_file_filetype_s), entity_file_name_s = tostring(entity_file_name_s), entity_file_id_s = tostring(entity_file_id_s), entity_type_s = tostring(entity_type_s), context_session_id_d = toreal(context_session_id_d), actor_user_team_s = tostring(actor_user_team_s), actor_user_name_s = tostring(actor_user_name_s), actor_user_id_s = tostring(actor_user_id_s), actor_type_s = tostring(actor_type_s), action_s = tostring(action_s), date_create_d = toreal(date_create_d), id_g = tostring(id_g), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), actor_user_email_s = tostring(actor_user_email_s), action_description_s = tostring(action_description_s)'
        outputStream: 'Custom-SlackAudit_CL'
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
