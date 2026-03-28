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
// Data Collection Rule for TaniumSCCMClientHealth_CL
// ============================================================================
// Generated: 2025-09-19 14:20:34
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 11, DCR columns: 10 (Type column always filtered)
// Output stream: Custom-TaniumSCCMClientHealth_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TaniumSCCMClientHealth_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TaniumSCCMClientHealth_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'Age_s'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'Computer_Name_s'
            type: 'string'
          }
          {
            name: 'Count_s'
            type: 'string'
          }
          {
            name: 'Health_Status_s'
            type: 'string'
          }
          {
            name: 'IP_Address_s'
            type: 'string'
          }
          {
            name: 'OS_Platform_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Reason_s'
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
          name: 'Sentinel-TaniumSCCMClientHealth_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TaniumSCCMClientHealth_CL']
        destinations: ['Sentinel-TaniumSCCMClientHealth_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Age_s = tostring(Age_s), Computer = tostring(Computer), Computer_Name_s = tostring(Computer_Name_s), Count_s = tostring(Count_s), Health_Status_s = tostring(Health_Status_s), IP_Address_s = tostring(IP_Address_s), OS_Platform_s = tostring(OS_Platform_s), RawData = tostring(RawData), Reason_s = tostring(Reason_s)'
        outputStream: 'Custom-TaniumSCCMClientHealth_CL'
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
