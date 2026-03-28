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
// Data Collection Rule for Cisco_Umbrella_proxy_CL
// ============================================================================
// Generated: 2025-09-19 14:19:59
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 31, DCR columns: 31 (Type column always filtered)
// Output stream: Custom-Cisco_Umbrella_proxy_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Cisco_Umbrella_proxy_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Cisco_Umbrella_proxy_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'Rule_ID_s'
            type: 'string'
          }
          {
            name: 'File_Name_s'
            type: 'string'
          }
          {
            name: 'Certificate_Errors_s'
            type: 'string'
          }
          {
            name: 'DLP_Status_S'
            type: 'string'
          }
          {
            name: 'Request_Method_s'
            type: 'string'
          }
          {
            name: 'Identity_Type_s'
            type: 'string'
          }
          {
            name: 'Identities_s'
            type: 'string'
          }
          {
            name: 'Blocked_Categories_s'
            type: 'string'
          }
          {
            name: 'Policy_Identity_Type_s'
            type: 'string'
          }
          {
            name: 'AMP_Score_s'
            type: 'string'
          }
          {
            name: 'AMP_Malware_Name_s'
            type: 'string'
          }
          {
            name: 'AMP_Disposition_s'
            type: 'string'
          }
          {
            name: 'AVDetections_s'
            type: 'string'
          }
          {
            name: 'Categories_s'
            type: 'string'
          }
          {
            name: 'SHA—SHA256_s'
            type: 'string'
          }
          {
            name: 'responseBodySize_d'
            type: 'string'
          }
          {
            name: 'responseSize_d'
            type: 'string'
          }
          {
            name: 'requestSize_d'
            type: 'string'
          }
          {
            name: 'statusCode_s'
            type: 'string'
          }
          {
            name: 'userAgent_s'
            type: 'string'
          }
          {
            name: 'Referer_s'
            type: 'string'
          }
          {
            name: 'Content_Type_s'
            type: 'string'
          }
          {
            name: 'Destination_IP_s'
            type: 'string'
          }
          {
            name: 'External_IP_s'
            type: 'string'
          }
          {
            name: 'Internal_IP_s'
            type: 'string'
          }
          {
            name: 'PolicyIdentity_s'
            type: 'string'
          }
          {
            name: 'Timestamp_t'
            type: 'string'
          }
          {
            name: 'Ruleset_ID_s'
            type: 'string'
          }
          {
            name: 'Destination_List_IDs_s'
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
          name: 'Sentinel-Cisco_Umbrella_proxy_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Cisco_Umbrella_proxy_CL']
        destinations: ['Sentinel-Cisco_Umbrella_proxy_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventType_s = tostring(EventType_s), Rule_ID_s = tostring(Rule_ID_s), File_Name_s = tostring(File_Name_s), Certificate_Errors_s = tostring(Certificate_Errors_s), DLP_Status_S = tostring(DLP_Status_S), Request_Method_s = tostring(Request_Method_s), Identity_Type_s = tostring(Identity_Type_s), Identities_s = tostring(Identities_s), Blocked_Categories_s = tostring(Blocked_Categories_s), Policy_Identity_Type_s = tostring(Policy_Identity_Type_s), AMP_Score_s = tostring(AMP_Score_s), AMP_Malware_Name_s = tostring(AMP_Malware_Name_s), AMP_Disposition_s = tostring(AMP_Disposition_s), AVDetections_s = tostring(AVDetections_s), Categories_s = tostring(Categories_s), SHA—SHA256_s = tostring(SHA—SHA256_s), responseBodySize_d = toreal(responseBodySize_d), responseSize_d = toreal(responseSize_d), requestSize_d = toreal(requestSize_d), statusCode_s = tostring(statusCode_s), userAgent_s = tostring(userAgent_s), Referer_s = tostring(Referer_s), Content_Type_s = tostring(Content_Type_s), Destination_IP_s = tostring(Destination_IP_s), External_IP_s = tostring(External_IP_s), Internal_IP_s = tostring(Internal_IP_s), PolicyIdentity_s = tostring(PolicyIdentity_s), Timestamp_t = todatetime(Timestamp_t), Ruleset_ID_s = tostring(Ruleset_ID_s), Destination_List_IDs_s = tostring(Destination_List_IDs_s)'
        outputStream: 'Custom-Cisco_Umbrella_proxy_CL'
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
