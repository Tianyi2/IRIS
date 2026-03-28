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
// Data Collection Rule for BetterMTDAppLog_CL
// ============================================================================
// Generated: 2025-09-19 14:19:56
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 16 (Type column always filtered)
// Output stream: Custom-BetterMTDAppLog_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BetterMTDAppLog_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BetterMTDAppLog_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'AppName'
            type: 'string'
          }
          {
            name: 'AppStatus_s'
            type: 'string'
          }
          {
            name: 'BundleId'
            type: 'string'
          }
          {
            name: 'CompanyId'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'DateAdded'
            type: 'string'
          }
          {
            name: 'DeviceUDID'
            type: 'string'
          }
          {
            name: 'IsMdm'
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
            name: 'Platform'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'Version'
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
          name: 'Sentinel-BetterMTDAppLog_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BetterMTDAppLog_CL']
        destinations: ['Sentinel-BetterMTDAppLog_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), AppName = tostring(AppName), AppStatus_s = tostring(AppStatus_s), BundleId = tostring(BundleId), CompanyId = toreal(CompanyId), Computer = tostring(Computer), DateAdded = todatetime(DateAdded), DeviceUDID = tostring(DeviceUDID), IsMdm = toreal(IsMdm), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), Platform = tostring(Platform), RawData = tostring(RawData), SourceSystem = tostring(SourceSystem), TenantId = toguid(TenantId), Version = toreal(Version)'
        outputStream: 'Custom-BetterMTDAppLog_CL'
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
