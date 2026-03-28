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
// Data Collection Rule for QualysKB_CL
// ============================================================================
// Generated: 2025-09-19 14:20:29
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 21, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-QualysKB_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-QualysKB_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-QualysKB_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'QID_s'
            type: 'string'
          }
          {
            name: 'Discovery_Additional_Info_s'
            type: 'string'
          }
          {
            name: 'Vuln_Type_s'
            type: 'string'
          }
          {
            name: 'Solution_s'
            type: 'string'
          }
          {
            name: 'Software_Vendor_s'
            type: 'string'
          }
          {
            name: 'Software_Product_s'
            type: 'string'
          }
          {
            name: 'Severity_Level_s'
            type: 'string'
          }
          {
            name: 'Published_DateTime_s'
            type: 'string'
          }
          {
            name: 'PCI_Flag_s'
            type: 'string'
          }
          {
            name: 'Vendor_Reference_URL_s'
            type: 'string'
          }
          {
            name: 'Vendor_Reference_ID_s'
            type: 'string'
          }
          {
            name: 'CVE_URL_s'
            type: 'string'
          }
          {
            name: 'CVE_ID_s'
            type: 'string'
          }
          {
            name: 'Last_Service_Modification_DateTime_s'
            type: 'string'
          }
          {
            name: 'Diagnosis_s'
            type: 'string'
          }
          {
            name: 'Consequence_s'
            type: 'string'
          }
          {
            name: 'Category_s'
            type: 'string'
          }
          {
            name: 'Title_s'
            type: 'string'
          }
          {
            name: 'Discovery_Auth_Type_s'
            type: 'string'
          }
          {
            name: 'Discovery_Remote_s'
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
          name: 'Sentinel-QualysKB_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-QualysKB_CL']
        destinations: ['Sentinel-QualysKB_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), QID_s = tostring(QID_s), Discovery_Additional_Info_s = tostring(Discovery_Additional_Info_s), Vuln_Type_s = tostring(Vuln_Type_s), Solution_s = tostring(Solution_s), Software_Vendor_s = tostring(Software_Vendor_s), Software_Product_s = tostring(Software_Product_s), Severity_Level_s = tostring(Severity_Level_s), Published_DateTime_s = tostring(Published_DateTime_s), PCI_Flag_s = tostring(PCI_Flag_s), Vendor_Reference_URL_s = tostring(Vendor_Reference_URL_s), Vendor_Reference_ID_s = tostring(Vendor_Reference_ID_s), CVE_URL_s = tostring(CVE_URL_s), CVE_ID_s = tostring(CVE_ID_s), Last_Service_Modification_DateTime_s = tostring(Last_Service_Modification_DateTime_s), Diagnosis_s = tostring(Diagnosis_s), Consequence_s = tostring(Consequence_s), Category_s = tostring(Category_s), Title_s = tostring(Title_s), Discovery_Auth_Type_s = tostring(Discovery_Auth_Type_s), Discovery_Remote_s = tostring(Discovery_Remote_s)'
        outputStream: 'Custom-QualysKB_CL'
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
