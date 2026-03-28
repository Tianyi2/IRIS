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
// Data Collection Rule for NCProtectUAL_CL
// ============================================================================
// Generated: 2025-09-19 14:20:25
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 22, DCR columns: 19 (Type column always filtered)
// Output stream: Custom-NCProtectUAL_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-NCProtectUAL_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-NCProtectUAL_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'Application_s'
            type: 'string'
          }
          {
            name: 'UserDisplayName_s'
            type: 'string'
          }
          {
            name: 'Type_s'
            type: 'string'
          }
          {
            name: 'Status_s'
            type: 'string'
          }
          {
            name: 'SHA512Hash_s'
            type: 'string'
          }
          {
            name: 'Sender_s'
            type: 'string'
          }
          {
            name: 'RuleUrl_s'
            type: 'string'
          }
          {
            name: 'RuleName_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'OS_s'
            type: 'string'
          }
          {
            name: 'JSONExtra_s'
            type: 'string'
          }
          {
            name: 'Id_s'
            type: 'string'
          }
          {
            name: 'DocumentUrl_s'
            type: 'string'
          }
          {
            name: 'DocumentProtectionId_g'
            type: 'string'
          }
          {
            name: 'Computer_s'
            type: 'string'
          }
          {
            name: 'Browser_s'
            type: 'string'
          }
          {
            name: 'UserLoginName_s'
            type: 'string'
          }
          {
            name: 'UserEmail_s'
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
          name: 'Sentinel-NCProtectUAL_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-NCProtectUAL_CL']
        destinations: ['Sentinel-NCProtectUAL_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Application_s = tostring(Application_s), UserDisplayName_s = tostring(UserDisplayName_s), Type_s = tostring(Type_s), Status_s = tostring(Status_s), SHA512Hash_s = tostring(SHA512Hash_s), Sender_s = tostring(Sender_s), RuleUrl_s = tostring(RuleUrl_s), RuleName_s = tostring(RuleName_s), RawData = tostring(RawData), OS_s = tostring(OS_s), JSONExtra_s = tostring(JSONExtra_s), Id_s = tostring(Id_s), DocumentUrl_s = tostring(DocumentUrl_s), DocumentProtectionId_g = tostring(DocumentProtectionId_g), Computer_s = tostring(Computer_s), Browser_s = tostring(Browser_s), UserLoginName_s = tostring(UserLoginName_s), UserEmail_s = tostring(UserEmail_s)'
        outputStream: 'Custom-NCProtectUAL_CL'
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
