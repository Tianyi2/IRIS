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
// Data Collection Rule for VaronisAlerts_CL
// ============================================================================
// Generated: 2025-09-19 14:20:36
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 21, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-VaronisAlerts_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-VaronisAlerts_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-VaronisAlerts_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'DeviceName_s'
            type: 'string'
          }
          {
            name: 'IngestTime_t'
            type: 'string'
          }
          {
            name: 'EventUTC_t'
            type: 'string'
          }
          {
            name: 'FileServerOrDomain_s'
            type: 'string'
          }
          {
            name: 'Platform_s'
            type: 'string'
          }
          {
            name: 'AssetContainsSensitiveData_s'
            type: 'string'
          }
          {
            name: 'AssetContainsFlaggedData_s'
            type: 'string'
          }
          {
            name: 'Asset_s'
            type: 'string'
          }
          {
            name: 'SamAccountName_s'
            type: 'string'
          }
          {
            name: 'UserName_s'
            type: 'string'
          }
          {
            name: 'NumOfAlertedEvents_d'
            type: 'string'
          }
          {
            name: 'StatusId_d'
            type: 'string'
          }
          {
            name: 'Status_s'
            type: 'string'
          }
          {
            name: 'SeverityId_d'
            type: 'string'
          }
          {
            name: 'Severity_s'
            type: 'string'
          }
          {
            name: 'Time_t'
            type: 'string'
          }
          {
            name: 'Name_s'
            type: 'string'
          }
          {
            name: 'ID_g'
            type: 'string'
          }
          {
            name: 'Query_s'
            type: 'string'
          }
          {
            name: 'Category'
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
          name: 'Sentinel-VaronisAlerts_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-VaronisAlerts_CL']
        destinations: ['Sentinel-VaronisAlerts_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), DeviceName_s = tostring(DeviceName_s), IngestTime_t = todatetime(IngestTime_t), EventUTC_t = todatetime(EventUTC_t), FileServerOrDomain_s = tostring(FileServerOrDomain_s), Platform_s = tostring(Platform_s), AssetContainsSensitiveData_s = tostring(AssetContainsSensitiveData_s), AssetContainsFlaggedData_s = tostring(AssetContainsFlaggedData_s), Asset_s = tostring(Asset_s), SamAccountName_s = tostring(SamAccountName_s), UserName_s = tostring(UserName_s), NumOfAlertedEvents_d = toreal(NumOfAlertedEvents_d), StatusId_d = toreal(StatusId_d), Status_s = tostring(Status_s), SeverityId_d = toreal(SeverityId_d), Severity_s = tostring(Severity_s), Time_t = todatetime(Time_t), Name_s = tostring(Name_s), ID_g = tostring(ID_g), Query_s = tostring(Query_s), Category = tostring(Category)'
        outputStream: 'Custom-VaronisAlerts_CL'
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
