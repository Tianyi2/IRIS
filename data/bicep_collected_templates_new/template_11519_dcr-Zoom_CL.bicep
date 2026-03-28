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
// Data Collection Rule for Zoom_CL
// ============================================================================
// Generated: 2025-09-19 14:20:41
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 42, DCR columns: 42 (Type column always filtered)
// Output stream: Custom-Zoom_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Zoom_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Zoom_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'EventCategoryType'
            type: 'string'
          }
          {
            name: 'CreateTime'
            type: 'string'
          }
          {
            name: 'EventCreationTime'
            type: 'string'
          }
          {
            name: 'Usage'
            type: 'string'
          }
          {
            name: 'PlanUsage'
            type: 'string'
          }
          {
            name: 'FreeUsage'
            type: 'string'
          }
          {
            name: 'Time'
            type: 'string'
          }
          {
            name: 'Operator'
            type: 'string'
          }
          {
            name: 'CategoryType'
            type: 'string'
          }
          {
            name: 'Action'
            type: 'string'
          }
          {
            name: 'OperationDetail'
            type: 'string'
          }
          {
            name: 'EventOriginalMessage'
            type: 'string'
          }
          {
            name: 'EventResult'
            type: 'string'
          }
          {
            name: 'IpAddress'
            type: 'string'
          }
          {
            name: 'SrcIpAddr'
            type: 'string'
          }
          {
            name: 'ClientType'
            type: 'string'
          }
          {
            name: 'SrcDvcModelName'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'Version'
            type: 'string'
          }
          {
            name: 'LastLoginTime'
            type: 'string'
          }
          {
            name: 'Department'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'EventDay'
            type: 'string'
          }
          {
            name: 'Date'
            type: 'string'
          }
          {
            name: 'NewUsersCount'
            type: 'string'
          }
          {
            name: 'MeetingsCount'
            type: 'string'
          }
          {
            name: 'ParticipantsCount'
            type: 'string'
          }
          {
            name: 'MeetingMinutes'
            type: 'string'
          }
          {
            name: 'EventType'
            type: 'string'
          }
          {
            name: 'EventName'
            type: 'string'
          }
          {
            name: 'EventMessage'
            type: 'string'
          }
          {
            name: 'Id'
            type: 'string'
          }
          {
            name: 'UserIdentity'
            type: 'string'
          }
          {
            name: 'Email'
            type: 'string'
          }
          {
            name: 'UserEmail'
            type: 'string'
          }
          {
            name: 'UserName'
            type: 'string'
          }
          {
            name: 'UserType'
            type: 'string'
          }
          {
            name: 'Dept'
            type: 'string'
          }
          {
            name: 'LastClientVersion'
            type: 'string'
          }
          {
            name: 'SrcDvcModelNumber'
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
          name: 'Sentinel-Zoom_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Zoom_CL']
        destinations: ['Sentinel-Zoom_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), EventCategoryType = tostring(EventCategoryType), CreateTime = todatetime(CreateTime), EventCreationTime = todatetime(EventCreationTime), Usage = tostring(Usage), PlanUsage = tostring(PlanUsage), FreeUsage = tostring(FreeUsage), Time = todatetime(Time), Operator = tostring(Operator), CategoryType = tostring(CategoryType), Action = tostring(Action), OperationDetail = tostring(OperationDetail), EventOriginalMessage = tostring(EventOriginalMessage), EventResult = tostring(EventResult), IpAddress = tostring(IpAddress), SrcIpAddr = tostring(SrcIpAddr), ClientType = tostring(ClientType), SrcDvcModelName = tostring(SrcDvcModelName), EventEndTime = todatetime(EventEndTime), Version = tostring(Version), LastLoginTime = todatetime(LastLoginTime), Department = tostring(Department), EventProduct = tostring(EventProduct), EventDay = tostring(EventDay), Date = tostring(Date), NewUsersCount = toreal(NewUsersCount), MeetingsCount = toreal(MeetingsCount), ParticipantsCount = toreal(ParticipantsCount), MeetingMinutes = toreal(MeetingMinutes), EventType = tostring(EventType), EventName = tostring(EventName), EventMessage = tostring(EventMessage), Id = tostring(Id), UserIdentity = tostring(UserIdentity), Email = tostring(Email), UserEmail = tostring(UserEmail), UserName = tostring(UserName), UserType = toreal(UserType), Dept = tostring(Dept), LastClientVersion = tostring(LastClientVersion), SrcDvcModelNumber = tostring(SrcDvcModelNumber)'
        outputStream: 'Custom-Zoom_CL'
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
