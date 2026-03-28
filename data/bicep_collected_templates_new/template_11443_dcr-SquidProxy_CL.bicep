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
// Data Collection Rule for SquidProxy_CL
// ============================================================================
// Generated: 2025-09-19 14:20:33
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 26, DCR columns: 23 (Type column always filtered)
// Output stream: Custom-SquidProxy_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SquidProxy_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SquidProxy_CL': {
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
            name: 'ContentType_s'
            type: 'string'
          }
          {
            name: 'PeerHost'
            type: 'string'
          }
          {
            name: 'PeerStatus_s'
            type: 'string'
          }
          {
            name: 'Username_s'
            type: 'string'
          }
          {
            name: 'Url_s'
            type: 'string'
          }
          {
            name: 'RequstMethod_s'
            type: 'string'
          }
          {
            name: 'Bytes_s'
            type: 'string'
          }
          {
            name: 'StatusCode_s'
            type: 'string'
          }
          {
            name: 'ResultCode'
            type: 'string'
          }
          {
            name: 'SrcIpAddr_s'
            type: 'string'
          }
          {
            name: 'Duration_s'
            type: 'string'
          }
          {
            name: 'Type_s'
            type: 'string'
          }
          {
            name: 'MG_s'
            type: 'string'
          }
          {
            name: 'TenantId_s'
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
            name: 'EventTime_UTC__s'
            type: 'string'
          }
          {
            name: 'Description_s'
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
          name: 'Sentinel-SquidProxy_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SquidProxy_CL']
        destinations: ['Sentinel-SquidProxy_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), ContentType_s = tostring(ContentType_s), PeerHost = tostring(PeerHost), PeerStatus_s = tostring(PeerStatus_s), Username_s = tostring(Username_s), Url_s = tostring(Url_s), RequstMethod_s = tostring(RequstMethod_s), Bytes_s = tostring(Bytes_s), StatusCode_s = tostring(StatusCode_s), ResultCode = tostring(ResultCode), SrcIpAddr_s = tostring(SrcIpAddr_s), Duration_s = tostring(Duration_s), Type_s = tostring(Type_s), MG_s = tostring(MG_s), TenantId_s = tostring(TenantId_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), EventTime_UTC__s = tostring(EventTime_UTC__s), Description_s = tostring(Description_s)'
        outputStream: 'Custom-SquidProxy_CL'
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
