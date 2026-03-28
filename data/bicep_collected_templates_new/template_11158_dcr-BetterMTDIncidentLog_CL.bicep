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
// Data Collection Rule for BetterMTDIncidentLog_CL
// ============================================================================
// Generated: 2025-09-19 14:19:56
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 25, DCR columns: 22 (Type column always filtered)
// Output stream: Custom-BetterMTDIncidentLog_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BetterMTDIncidentLog_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BetterMTDIncidentLog_CL': {
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
            name: 'Status'
            type: 'string'
          }
          {
            name: 'UserEmail'
            type: 'string'
          }
          {
            name: 'DevicePlatform'
            type: 'string'
          }
          {
            name: 'DeviceId'
            type: 'string'
          }
          {
            name: 'DeviceOS'
            type: 'string'
          }
          {
            name: 'CompanyName'
            type: 'string'
          }
          {
            name: 'CompanyId'
            type: 'string'
          }
          {
            name: 'ThreatDescription'
            type: 'string'
          }
          {
            name: 'EventTimeStamp'
            type: 'string'
          }
          {
            name: 'ThreatCategory'
            type: 'string'
          }
          {
            name: 'ThreatTitle'
            type: 'string'
          }
          {
            name: 'ThreatType'
            type: 'string'
          }
          {
            name: 'ThreatId'
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
            name: 'ThreatSeverity'
            type: 'string'
          }
          {
            name: 'LogTimeStamp'
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
          name: 'Sentinel-BetterMTDIncidentLog_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BetterMTDIncidentLog_CL']
        destinations: ['Sentinel-BetterMTDIncidentLog_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), Status = tostring(Status), UserEmail = tostring(UserEmail), DevicePlatform = tostring(DevicePlatform), DeviceId = tostring(DeviceId), DeviceOS = tostring(DeviceOS), CompanyName = tostring(CompanyName), CompanyId = toreal(CompanyId), ThreatDescription = tostring(ThreatDescription), EventTimeStamp = todatetime(EventTimeStamp), ThreatCategory = tostring(ThreatCategory), ThreatTitle = tostring(ThreatTitle), ThreatType = tostring(ThreatType), ThreatId = toreal(ThreatId), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), ThreatSeverity = tostring(ThreatSeverity), LogTimeStamp = todatetime(LogTimeStamp)'
        outputStream: 'Custom-BetterMTDIncidentLog_CL'
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
