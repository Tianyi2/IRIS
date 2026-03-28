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
// Data Collection Rule for Audits_Data_CL
// ============================================================================
// Generated: 2025-09-19 14:19:54
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-Audits_Data_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Audits_Data_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Audits_Data_CL': {
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
            name: 'event_object_s'
            type: 'string'
          }
          {
            name: 'event_data_s'
            type: 'string'
          }
          {
            name: 'result_status_s'
            type: 'string'
          }
          {
            name: 'Message'
            type: 'string'
          }
          {
            name: 'event_timestamp_t'
            type: 'string'
          }
          {
            name: 'source_ip_s'
            type: 'string'
          }
          {
            name: 'version_s'
            type: 'string'
          }
          {
            name: 'user_role_s'
            type: 'string'
          }
          {
            name: 'user_type_s'
            type: 'string'
          }
          {
            name: 'username_s'
            type: 'string'
          }
          {
            name: 'user_id_d'
            type: 'string'
          }
          {
            name: 'id_d'
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
            name: 'event_action_s'
            type: 'string'
          }
          {
            name: 'api_client_id_g'
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
          name: 'Sentinel-Audits_Data_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Audits_Data_CL']
        destinations: ['Sentinel-Audits_Data_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), event_object_s = tostring(event_object_s), event_data_s = tostring(event_data_s), result_status_s = tostring(result_status_s), Message = tostring(Message), event_timestamp_t = todatetime(event_timestamp_t), source_ip_s = tostring(source_ip_s), version_s = tostring(version_s), user_role_s = tostring(user_role_s), user_type_s = tostring(user_type_s), username_s = tostring(username_s), user_id_d = toreal(user_id_d), id_d = toreal(id_d), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), event_action_s = tostring(event_action_s), api_client_id_g = tostring(api_client_id_g)'
        outputStream: 'Custom-Audits_Data_CL'
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
