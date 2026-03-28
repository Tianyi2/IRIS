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
// Data Collection Rule for Armis_Devices_CL
// ============================================================================
// Generated: 2025-09-19 14:19:52
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 33, DCR columns: 30 (Type column always filtered)
// Output stream: Custom-Armis_Devices_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Armis_Devices_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Armis_Devices_CL': {
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
            name: 'Tags'
            type: 'string'
          }
          {
            name: 'SiteName'
            type: 'string'
          }
          {
            name: 'SiteLocation'
            type: 'string'
          }
          {
            name: 'SensorType'
            type: 'string'
          }
          {
            name: 'SensorName'
            type: 'string'
          }
          {
            name: 'RiskLevel'
            type: 'string'
          }
          {
            name: 'PurdueLevel'
            type: 'string'
          }
          {
            name: 'PlcModule'
            type: 'string'
          }
          {
            name: 'OperatingSystem'
            type: 'string'
          }
          {
            name: 'OperatingSystemVersion'
            type: 'string'
          }
          {
            name: 'Manufacturer'
            type: 'string'
          }
          {
            name: 'Model'
            type: 'string'
          }
          {
            name: 'Visibility'
            type: 'string'
          }
          {
            name: 'MacAddress'
            type: 'string'
          }
          {
            name: 'IPAddress'
            type: 'string'
          }
          {
            name: 'Id'
            type: 'string'
          }
          {
            name: 'FirstSeen'
            type: 'string'
          }
          {
            name: 'FirmwareVersion'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'EventVendor'
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
            name: 'LastSeen'
            type: 'string'
          }
          {
            name: 'Name'
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
          name: 'Sentinel-Armis_Devices_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Armis_Devices_CL']
        destinations: ['Sentinel-Armis_Devices_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), Tags = tostring(Tags), SiteName = tostring(SiteName), SiteLocation = tostring(SiteLocation), SensorType = tostring(SensorType), SensorName = tostring(SensorName), RiskLevel = tostring(RiskLevel), PurdueLevel = tostring(PurdueLevel), PlcModule = tostring(PlcModule), OperatingSystem = tostring(OperatingSystem), OperatingSystemVersion = tostring(OperatingSystemVersion), Manufacturer = tostring(Manufacturer), Model = tostring(Model), Visibility = tostring(Visibility), MacAddress = tostring(MacAddress), IPAddress = tostring(IPAddress), Id = tostring(Id), FirstSeen = tostring(FirstSeen), FirmwareVersion = tostring(FirmwareVersion), Category = tostring(Category), EventProduct = tostring(EventProduct), EventVendor = tostring(EventVendor), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), LastSeen = tostring(LastSeen), Name = tostring(Name)'
        outputStream: 'Custom-Armis_Devices_CL'
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
