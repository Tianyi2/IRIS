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
// Data Collection Rule for BetterMTDDeviceLog_CL
// ============================================================================
// Generated: 2025-09-19 14:19:56
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 25, DCR columns: 23 (Type column always filtered)
// Output stream: Custom-BetterMTDDeviceLog_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BetterMTDDeviceLog_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BetterMTDDeviceLog_CL': {
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
            name: 'AddedDate'
            type: 'string'
          }
          {
            name: 'ThreatScore'
            type: 'string'
          }
          {
            name: 'ThreatLevel'
            type: 'string'
          }
          {
            name: 'IsDeleted'
            type: 'string'
          }
          {
            name: 'UserEmail'
            type: 'string'
          }
          {
            name: 'CompanyName'
            type: 'string'
          }
          {
            name: 'LocationID'
            type: 'string'
          }
          {
            name: 'LastReported'
            type: 'string'
          }
          {
            name: 'DevicePlatform'
            type: 'string'
          }
          {
            name: 'CompanyId'
            type: 'string'
          }
          {
            name: 'DeviceOS'
            type: 'string'
          }
          {
            name: 'DeviceId'
            type: 'string'
          }
          {
            name: 'Manufacturer'
            type: 'string'
          }
          {
            name: 'BuildNumber'
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
            name: 'AgentVersion'
            type: 'string'
          }
          {
            name: 'DeviceUDID'
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
          name: 'Sentinel-BetterMTDDeviceLog_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BetterMTDDeviceLog_CL']
        destinations: ['Sentinel-BetterMTDDeviceLog_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), AddedDate = todatetime(AddedDate), ThreatScore = toreal(ThreatScore), ThreatLevel = tostring(ThreatLevel), IsDeleted = tobool(IsDeleted), UserEmail = tostring(UserEmail), CompanyName = tostring(CompanyName), LocationID = toreal(LocationID), LastReported = todatetime(LastReported), DevicePlatform = tostring(DevicePlatform), CompanyId = toreal(CompanyId), DeviceOS = tostring(DeviceOS), DeviceId = toreal(DeviceId), Manufacturer = tostring(Manufacturer), BuildNumber = tostring(BuildNumber), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), AgentVersion = tostring(AgentVersion), DeviceUDID = tostring(DeviceUDID)'
        outputStream: 'Custom-BetterMTDDeviceLog_CL'
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
