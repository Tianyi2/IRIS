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
// Data Collection Rule for TaniumDefenderHealth_CL
// ============================================================================
// Generated: 2025-09-19 14:20:33
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 19, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-TaniumDefenderHealth_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TaniumDefenderHealth_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TaniumDefenderHealth_CL': {
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
            name: 'Signature_Update_Age_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'QuickScan_Age_s'
            type: 'string'
          }
          {
            name: 'Health_s'
            type: 'string'
          }
          {
            name: 'Defender_Process_StartType_s'
            type: 'string'
          }
          {
            name: 'Defender_Process_s'
            type: 'string'
          }
          {
            name: 'Windows_Defender_Client_Version_s'
            type: 'string'
          }
          {
            name: 'Count_s'
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
            name: 'Asset_OS_Platform_s'
            type: 'string'
          }
          {
            name: 'Asset_IP_Address_s'
            type: 'string'
          }
          {
            name: 'Antivirus_State_s'
            type: 'string'
          }
          {
            name: 'AntiSpyware_State_s'
            type: 'string'
          }
          {
            name: 'Computer_Name_s'
            type: 'string'
          }
          {
            name: 'Windows_Defender_Installed_s'
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
          name: 'Sentinel-TaniumDefenderHealth_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TaniumDefenderHealth_CL']
        destinations: ['Sentinel-TaniumDefenderHealth_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Age_s = tostring(Age_s), Signature_Update_Age_s = tostring(Signature_Update_Age_s), RawData = tostring(RawData), QuickScan_Age_s = tostring(QuickScan_Age_s), Health_s = tostring(Health_s), Defender_Process_StartType_s = tostring(Defender_Process_StartType_s), Defender_Process_s = tostring(Defender_Process_s), Windows_Defender_Client_Version_s = tostring(Windows_Defender_Client_Version_s), Count_s = tostring(Count_s), Computer_ID_s = tostring(Computer_ID_s), Computer = tostring(Computer), Asset_OS_Platform_s = tostring(Asset_OS_Platform_s), Asset_IP_Address_s = tostring(Asset_IP_Address_s), Antivirus_State_s = tostring(Antivirus_State_s), AntiSpyware_State_s = tostring(AntiSpyware_State_s), Computer_Name_s = tostring(Computer_Name_s), Windows_Defender_Installed_s = tostring(Windows_Defender_Installed_s)'
        outputStream: 'Custom-TaniumDefenderHealth_CL'
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
