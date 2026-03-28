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
// Data Collection Rule for Armorblox_CL
// ============================================================================
// Generated: 2025-09-19 14:19:52
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 28, DCR columns: 26 (Type column always filtered)
// Output stream: Custom-Armorblox_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Armorblox_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Armorblox_CL': {
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
            name: 'status_counts_process_count_s'
            type: 'string'
          }
          {
            name: 'status_counts_done_count_s'
            type: 'string'
          }
          {
            name: 'folder_categories_s'
            type: 'string'
          }
          {
            name: 'external_senders_s'
            type: 'string'
          }
          {
            name: 'external_users_s'
            type: 'string'
          }
          {
            name: 'app_name_s'
            type: 'string'
          }
          {
            name: 'research_status_s'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'object_type_s'
            type: 'string'
          }
          {
            name: 'resolution_state_s'
            type: 'string'
          }
          {
            name: 'status_counts_error_count_s'
            type: 'string'
          }
          {
            name: 'remediation_actions_s'
            type: 'string'
          }
          {
            name: 'policy_names_s'
            type: 'string'
          }
          {
            name: 'users_s'
            type: 'string'
          }
          {
            name: 'date_t'
            type: 'string'
          }
          {
            name: 'tagged_b'
            type: 'string'
          }
          {
            name: 'priority_s'
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
            name: 'title_s'
            type: 'string'
          }
          {
            name: 'attachment_list_s'
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
          name: 'Sentinel-Armorblox_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Armorblox_CL']
        destinations: ['Sentinel-Armorblox_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), status_counts_process_count_s = tostring(status_counts_process_count_s), status_counts_done_count_s = tostring(status_counts_done_count_s), folder_categories_s = tostring(folder_categories_s), external_senders_s = tostring(external_senders_s), external_users_s = tostring(external_users_s), app_name_s = tostring(app_name_s), research_status_s = tostring(research_status_s), id_s = tostring(id_s), object_type_s = tostring(object_type_s), resolution_state_s = tostring(resolution_state_s), status_counts_error_count_s = tostring(status_counts_error_count_s), remediation_actions_s = tostring(remediation_actions_s), policy_names_s = tostring(policy_names_s), users_s = tostring(users_s), date_t = todatetime(date_t), tagged_b = tobool(tagged_b), priority_s = tostring(priority_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), title_s = tostring(title_s), attachment_list_s = tostring(attachment_list_s)'
        outputStream: 'Custom-Armorblox_CL'
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
