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
// Data Collection Rule for TaniumMainAsset_CL
// ============================================================================
// Generated: 2025-09-19 14:20:33
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 22 (Type column always filtered)
// Output stream: Custom-TaniumMainAsset_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TaniumMainAsset_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TaniumMainAsset_CL': {
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
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'OS_Platform_s'
            type: 'string'
          }
          {
            name: 'IP_Address_s'
            type: 'string'
          }
          {
            name: 'Health_Status_s'
            type: 'string'
          }
          {
            name: 'Count_s'
            type: 'string'
          }
          {
            name: 'Computer_Name_s'
            type: 'string'
          }
          {
            name: 'Computer_ID_s'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'Reason_s'
            type: 'string'
          }
          {
            name: 'Asset_System_UUID_g'
            type: 'string'
          }
          {
            name: 'Asset_OS_Platform_s'
            type: 'string'
          }
          {
            name: 'Asset_Operating_System_s'
            type: 'string'
          }
          {
            name: 'Asset_Model_s'
            type: 'string'
          }
          {
            name: 'Asset_Manufacturer_s'
            type: 'string'
          }
          {
            name: 'Asset_IP_Address_s'
            type: 'string'
          }
          {
            name: 'Asset_Domain_Name_s'
            type: 'string'
          }
          {
            name: 'Asset_Computer_Serial_Number_s'
            type: 'string'
          }
          {
            name: 'Asset_Chassis_Type_s'
            type: 'string'
          }
          {
            name: 'Asset_Service_Pack_s'
            type: 'string'
          }
          {
            name: 'Username_s'
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
          name: 'Sentinel-TaniumMainAsset_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TaniumMainAsset_CL']
        destinations: ['Sentinel-TaniumMainAsset_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Age_s = tostring(Age_s), RawData = tostring(RawData), OS_Platform_s = tostring(OS_Platform_s), IP_Address_s = tostring(IP_Address_s), Health_Status_s = tostring(Health_Status_s), Count_s = tostring(Count_s), Computer_Name_s = tostring(Computer_Name_s), Computer_ID_s = tostring(Computer_ID_s), Computer = tostring(Computer), Reason_s = tostring(Reason_s), Asset_System_UUID_g = tostring(Asset_System_UUID_g), Asset_OS_Platform_s = tostring(Asset_OS_Platform_s), Asset_Operating_System_s = tostring(Asset_Operating_System_s), Asset_Model_s = tostring(Asset_Model_s), Asset_Manufacturer_s = tostring(Asset_Manufacturer_s), Asset_IP_Address_s = tostring(Asset_IP_Address_s), Asset_Domain_Name_s = tostring(Asset_Domain_Name_s), Asset_Computer_Serial_Number_s = tostring(Asset_Computer_Serial_Number_s), Asset_Chassis_Type_s = tostring(Asset_Chassis_Type_s), Asset_Service_Pack_s = tostring(Asset_Service_Pack_s), Username_s = tostring(Username_s)'
        outputStream: 'Custom-TaniumMainAsset_CL'
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
