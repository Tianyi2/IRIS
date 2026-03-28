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
// Data Collection Rule for TrendMicro_XDR_RCA_Result_CL
// ============================================================================
// Generated: 2025-09-19 14:20:35
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 24, DCR columns: 22 (Type column always filtered)
// Output stream: Custom-TrendMicro_XDR_RCA_Result_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TrendMicro_XDR_RCA_Result_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TrendMicro_XDR_RCA_Result_CL': {
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
            name: 'parentObjectId_s'
            type: 'string'
          }
          {
            name: 'isMatched_b'
            type: 'string'
          }
          {
            name: 'objectName_s'
            type: 'string'
          }
          {
            name: 'eventId_d'
            type: 'string'
          }
          {
            name: 'objectHashId_s'
            type: 'string'
          }
          {
            name: 'workbenchId_s'
            type: 'string'
          }
          {
            name: 'agentEntity_ip_s'
            type: 'string'
          }
          {
            name: 'agentEntity_guid_g'
            type: 'string'
          }
          {
            name: 'objectMeta_s'
            type: 'string'
          }
          {
            name: 'agentEntity_hostname_s'
            type: 'string'
          }
          {
            name: 'taskId_g'
            type: 'string'
          }
          {
            name: 'xdrCustomerID_g'
            type: 'string'
          }
          {
            name: 'agentEntity_host_s'
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
            name: 'taskName_s'
            type: 'string'
          }
          {
            name: 'objectEvent_s'
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
          name: 'Sentinel-TrendMicro_XDR_RCA_Result_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TrendMicro_XDR_RCA_Result_CL']
        destinations: ['Sentinel-TrendMicro_XDR_RCA_Result_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), parentObjectId_s = tostring(parentObjectId_s), isMatched_b = tobool(isMatched_b), objectName_s = tostring(objectName_s), eventId_d = toreal(eventId_d), objectHashId_s = tostring(objectHashId_s), workbenchId_s = tostring(workbenchId_s), agentEntity_ip_s = tostring(agentEntity_ip_s), agentEntity_guid_g = tostring(agentEntity_guid_g), objectMeta_s = tostring(objectMeta_s), agentEntity_hostname_s = tostring(agentEntity_hostname_s), taskId_g = tostring(taskId_g), xdrCustomerID_g = tostring(xdrCustomerID_g), agentEntity_host_s = tostring(agentEntity_host_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), taskName_s = tostring(taskName_s), objectEvent_s = tostring(objectEvent_s)'
        outputStream: 'Custom-TrendMicro_XDR_RCA_Result_CL'
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
