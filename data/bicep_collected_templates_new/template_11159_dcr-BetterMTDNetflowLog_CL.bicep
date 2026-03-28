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
// Data Collection Rule for BetterMTDNetflowLog_CL
// ============================================================================
// Generated: 2025-09-19 14:19:56
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 36, DCR columns: 34 (Type column always filtered)
// Output stream: Custom-BetterMTDNetflowLog_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BetterMTDNetflowLog_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BetterMTDNetflowLog_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'Account'
            type: 'string'
          }
          {
            name: 'UrlStatus'
            type: 'string'
          }
          {
            name: 'Url'
            type: 'string'
          }
          {
            name: 'UDID'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'Status_s'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'SourceLon'
            type: 'string'
          }
          {
            name: 'SourceLat'
            type: 'string'
          }
          {
            name: 'SourceCountryCode'
            type: 'string'
          }
          {
            name: 'SourceCountry'
            type: 'string'
          }
          {
            name: 'SourceClient'
            type: 'string'
          }
          {
            name: 'Scheme'
            type: 'string'
          }
          {
            name: 'Reason'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'Username'
            type: 'string'
          }
          {
            name: 'Port'
            type: 'string'
          }
          {
            name: 'NetworkType'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'Host'
            type: 'string'
          }
          {
            name: 'DeviceName'
            type: 'string'
          }
          {
            name: 'DestinationLon'
            type: 'string'
          }
          {
            name: 'DestinationLat'
            type: 'string'
          }
          {
            name: 'DestinationCountryCode'
            type: 'string'
          }
          {
            name: 'DestinationCountry'
            type: 'string'
          }
          {
            name: 'Destination'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'Cid'
            type: 'string'
          }
          {
            name: 'AppName'
            type: 'string'
          }
          {
            name: 'AppIdentifier'
            type: 'string'
          }
          {
            name: 'Path'
            type: 'string'
          }
          {
            name: 'UUId'
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
          name: 'Sentinel-BetterMTDNetflowLog_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BetterMTDNetflowLog_CL']
        destinations: ['Sentinel-BetterMTDNetflowLog_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Account = tostring(Account), UrlStatus = tostring(UrlStatus), Url = tostring(Url), UDID = tostring(UDID), TenantId = toguid(TenantId), Status_s = tostring(Status_s), SourceSystem = tostring(SourceSystem), SourceLon = toreal(SourceLon), SourceLat = toreal(SourceLat), SourceCountryCode = tostring(SourceCountryCode), SourceCountry = tostring(SourceCountry), SourceClient = tostring(SourceClient), Scheme = tostring(Scheme), Reason = tostring(Reason), RawData = tostring(RawData), Username = tostring(Username), Port = toreal(Port), NetworkType = tostring(NetworkType), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Host = tostring(Host), DeviceName = tostring(DeviceName), DestinationLon = toreal(DestinationLon), DestinationLat = toreal(DestinationLat), DestinationCountryCode = tostring(DestinationCountryCode), DestinationCountry = tostring(DestinationCountry), Destination = tostring(Destination), Computer = tostring(Computer), Cid = toreal(Cid), AppName = tostring(AppName), AppIdentifier = tostring(AppIdentifier), Path = tostring(Path), UUId = tostring(UUId)'
        outputStream: 'Custom-BetterMTDNetflowLog_CL'
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
