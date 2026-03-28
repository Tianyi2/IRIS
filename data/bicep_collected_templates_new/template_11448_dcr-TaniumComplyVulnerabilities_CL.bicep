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
// Data Collection Rule for TaniumComplyVulnerabilities_CL
// ============================================================================
// Generated: 2025-09-19 14:20:33
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 12, DCR columns: 11 (Type column always filtered)
// Output stream: Custom-TaniumComplyVulnerabilities_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TaniumComplyVulnerabilities_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TaniumComplyVulnerabilities_CL': {
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
            name: 'CVE_s'
            type: 'string'
          }
          {
            name: 'CVE_Year_s'
            type: 'string'
          }
          {
            name: 'CVSS_Score_s'
            type: 'string'
          }
          {
            name: 'IP_Address_s'
            type: 'string'
          }
          {
            name: 'Operating_System_Generation_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Severity_s'
            type: 'string'
          }
          {
            name: 'Title_s'
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
          name: 'Sentinel-TaniumComplyVulnerabilities_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TaniumComplyVulnerabilities_CL']
        destinations: ['Sentinel-TaniumComplyVulnerabilities_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Computer = tostring(Computer), Computer_Name_s = tostring(Computer_Name_s), CVE_s = tostring(CVE_s), CVE_Year_s = tostring(CVE_Year_s), CVSS_Score_s = tostring(CVSS_Score_s), IP_Address_s = tostring(IP_Address_s), Operating_System_Generation_s = tostring(Operating_System_Generation_s), RawData = tostring(RawData), Severity_s = tostring(Severity_s), Title_s = tostring(Title_s)'
        outputStream: 'Custom-TaniumComplyVulnerabilities_CL'
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
