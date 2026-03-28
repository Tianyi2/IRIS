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
// Data Collection Rule for OneLogin_CL
// ============================================================================
// Generated: 2025-09-19 14:20:28
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 30 (Type column always filtered)
// Output stream: Custom-OneLogin_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-OneLogin_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-OneLogin_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'app_name_s'
            type: 'string'
          }
          {
            name: 'event_type_id_d'
            type: 'string'
          }
          {
            name: 'actor_user_name_s'
            type: 'string'
          }
          {
            name: 'ipaddr_s'
            type: 'string'
          }
          {
            name: 'event_timestamp_s'
            type: 'string'
          }
          {
            name: 'account_id_d'
            type: 'string'
          }
          {
            name: 'custom_message_s'
            type: 'string'
          }
          {
            name: 'actor_system_s'
            type: 'string'
          }
          {
            name: 'uuid_g'
            type: 'string'
          }
          {
            name: 'create__id_g'
            type: 'string'
          }
          {
            name: 'user_name_s'
            type: 'string'
          }
          {
            name: 'user_attributes_lastname_s'
            type: 'string'
          }
          {
            name: 'user_attributes_title_s'
            type: 'string'
          }
          {
            name: 'actor_user_id_d'
            type: 'string'
          }
          {
            name: 'user_attributes_openid_name_s'
            type: 'string'
          }
          {
            name: 'user_attributes_email_s'
            type: 'string'
          }
          {
            name: 'user_attributes_firstname_s'
            type: 'string'
          }
          {
            name: 'user_attributes_department_s'
            type: 'string'
          }
          {
            name: 'user_attributes_account_id_d'
            type: 'string'
          }
          {
            name: 'user_id_d'
            type: 'string'
          }
          {
            name: 'user_agent_s'
            type: 'string'
          }
          {
            name: 'policy_id_d'
            type: 'string'
          }
          {
            name: 'policy_type_s'
            type: 'string'
          }
          {
            name: 'policy_name_s'
            type: 'string'
          }
          {
            name: 'role_id_d'
            type: 'string'
          }
          {
            name: 'role_name_s'
            type: 'string'
          }
          {
            name: 'app_id_d'
            type: 'string'
          }
          {
            name: 'user_attributes_username_s'
            type: 'string'
          }
          {
            name: 'notes_s'
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
          name: 'Sentinel-OneLogin_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-OneLogin_CL']
        destinations: ['Sentinel-OneLogin_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), app_name_s = tostring(app_name_s), event_type_id_d = toreal(event_type_id_d), actor_user_name_s = tostring(actor_user_name_s), ipaddr_s = tostring(ipaddr_s), event_timestamp_s = tostring(event_timestamp_s), account_id_d = toreal(account_id_d), custom_message_s = tostring(custom_message_s), actor_system_s = tostring(actor_system_s), uuid_g = tostring(uuid_g), create__id_g = tostring(create__id_g), user_name_s = tostring(user_name_s), user_attributes_lastname_s = tostring(user_attributes_lastname_s), user_attributes_title_s = tostring(user_attributes_title_s), actor_user_id_d = toreal(actor_user_id_d), user_attributes_openid_name_s = tostring(user_attributes_openid_name_s), user_attributes_email_s = tostring(user_attributes_email_s), user_attributes_firstname_s = tostring(user_attributes_firstname_s), user_attributes_department_s = tostring(user_attributes_department_s), user_attributes_account_id_d = toreal(user_attributes_account_id_d), user_id_d = toreal(user_id_d), user_agent_s = tostring(user_agent_s), policy_id_d = toreal(policy_id_d), policy_type_s = tostring(policy_type_s), policy_name_s = tostring(policy_name_s), role_id_d = toreal(role_id_d), role_name_s = tostring(role_name_s), app_id_d = toreal(app_id_d), user_attributes_username_s = tostring(user_attributes_username_s), notes_s = tostring(notes_s)'
        outputStream: 'Custom-OneLogin_CL'
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
