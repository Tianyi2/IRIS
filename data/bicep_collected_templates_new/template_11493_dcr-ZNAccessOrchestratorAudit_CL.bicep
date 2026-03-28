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
// Data Collection Rule for ZNAccessOrchestratorAudit_CL
// ============================================================================
// Generated: 2025-09-19 14:20:41
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 12, DCR columns: 12 (Type column always filtered)
// Output stream: Custom-ZNAccessOrchestratorAudit_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZNAccessOrchestratorAudit_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZNAccessOrchestratorAudit_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'timestamp_d'
            type: 'string'
          }
          {
            name: 'auditType_d'
            type: 'string'
          }
          {
            name: 'enforcementSource_d'
            type: 'string'
          }
          {
            name: 'userRole_d'
            type: 'string'
          }
          {
            name: 'destinationEntitiesList_s'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'reportedObjectId_g'
            type: 'string'
          }
          {
            name: 'performedBy_id_s'
            type: 'string'
          }
          {
            name: 'performedBy_name_s'
            type: 'string'
          }
          {
            name: 'performedBy_id_g'
            type: 'string'
          }
          {
            name: 'reportedObjectId_s'
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
          name: 'Sentinel-ZNAccessOrchestratorAudit_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZNAccessOrchestratorAudit_CL']
        destinations: ['Sentinel-ZNAccessOrchestratorAudit_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), timestamp_d = toreal(timestamp_d), auditType_d = toreal(auditType_d), enforcementSource_d = toreal(enforcementSource_d), userRole_d = toreal(userRole_d), destinationEntitiesList_s = tostring(destinationEntitiesList_s), details_s = tostring(details_s), reportedObjectId_g = tostring(reportedObjectId_g), performedBy_id_s = tostring(performedBy_id_s), performedBy_name_s = tostring(performedBy_name_s), performedBy_id_g = tostring(performedBy_id_g), reportedObjectId_s = tostring(reportedObjectId_s)'
        outputStream: 'Custom-ZNAccessOrchestratorAudit_CL'
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
