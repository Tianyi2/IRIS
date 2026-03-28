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
// Data Collection Rule for TaniumComplyCompliance_CL
// ============================================================================
// Generated: 2025-09-19 14:20:33
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 12, DCR columns: 11 (Type column always filtered)
// Output stream: Custom-TaniumComplyCompliance_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TaniumComplyCompliance_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TaniumComplyCompliance_CL': {
        columns: [
          {
            name: 'TimeGenerated'
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
            name: 'Operating_System_Generation_s'
            type: 'string'
          }
          {
            name: 'Profile_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Rule_ID_s'
            type: 'string'
          }
          {
            name: 'Rule_s'
            type: 'string'
          }
          {
            name: 'Standard_s'
            type: 'string'
          }
          {
            name: 'Status_Category_s'
            type: 'string'
          }
          {
            name: 'Version_s'
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
          name: 'Sentinel-TaniumComplyCompliance_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TaniumComplyCompliance_CL']
        destinations: ['Sentinel-TaniumComplyCompliance_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Computer = tostring(Computer), Computer_Name_s = tostring(Computer_Name_s), Operating_System_Generation_s = tostring(Operating_System_Generation_s), Profile_s = tostring(Profile_s), RawData = tostring(RawData), Rule_ID_s = tostring(Rule_ID_s), Rule_s = tostring(Rule_s), Standard_s = tostring(Standard_s), Status_Category_s = tostring(Status_Category_s), Version_s = tostring(Version_s)'
        outputStream: 'Custom-TaniumComplyCompliance_CL'
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
