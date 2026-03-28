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
// Data Collection Rule for ZNSegmentAudit_CL
// ============================================================================
// Generated: 2025-09-19 14:20:41
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 22, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-ZNSegmentAudit_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZNSegmentAudit_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZNSegmentAudit_CL': {
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
            name: 'reportedObjectGeneration_d'
            type: 'string'
          }
          {
            name: 'reportedObjectId_g'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'destinationEntitiesList_s'
            type: 'string'
          }
          {
            name: 'userRole_d'
            type: 'string'
          }
          {
            name: 'enforcementSource_d'
            type: 'string'
          }
          {
            name: 'auditType_d'
            type: 'string'
          }
          {
            name: 'performedBy_id_g'
            type: 'string'
          }
          {
            name: 'timestamp_d'
            type: 'string'
          }
          {
            name: 'reportedObjectId_s'
            type: 'string'
          }
          {
            name: 'parentObjectId_g'
            type: 'string'
          }
          {
            name: 'RawData'
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
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'SourceSystem'
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
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-ZNSegmentAudit_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZNSegmentAudit_CL']
        destinations: ['Sentinel-ZNSegmentAudit_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), reportedObjectGeneration_d = toreal(reportedObjectGeneration_d), reportedObjectId_g = tostring(reportedObjectId_g), details_s = tostring(details_s), destinationEntitiesList_s = tostring(destinationEntitiesList_s), userRole_d = toreal(userRole_d), enforcementSource_d = toreal(enforcementSource_d), auditType_d = toreal(auditType_d), performedBy_id_g = tostring(performedBy_id_g), timestamp_d = tostring(timestamp_d), reportedObjectId_s = tostring(reportedObjectId_s), parentObjectId_g = tostring(parentObjectId_g), RawData = tostring(RawData), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), Computer = tostring(Computer), SourceSystem = tostring(SourceSystem), performedBy_id_s = tostring(performedBy_id_s), performedBy_name_s = tostring(performedBy_name_s)'
        outputStream: 'Custom-ZNSegmentAudit_CL'
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
