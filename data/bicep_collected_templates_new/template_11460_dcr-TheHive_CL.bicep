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
// Data Collection Rule for TheHive_CL
// ============================================================================
// Generated: 2025-09-19 14:20:35
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 34, DCR columns: 34 (Type column always filtered)
// Output stream: Custom-TheHive_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TheHive_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TheHive_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'iobject_updatedBy_s'
            type: 'string'
          }
          {
            name: 'object_startDate_d'
            type: 'string'
          }
          {
            name: 'object_tlp_d'
            type: 'string'
          }
          {
            name: 'object_severity_d'
            type: 'string'
          }
          {
            name: 'object_caseId_d'
            type: 'string'
          }
          {
            name: 'object_createdAt_d'
            type: 'string'
          }
          {
            name: 'object_owner_s'
            type: 'string'
          }
          {
            name: 'object_status_s'
            type: 'string'
          }
          {
            name: 'object_title_s'
            type: 'string'
          }
          {
            name: 'object_user_s'
            type: 'string'
          }
          {
            name: 'object_flag_b'
            type: 'string'
          }
          {
            name: 'object_description_s'
            type: 'string'
          }
          {
            name: 'object_createdBy_s'
            type: 'string'
          }
          {
            name: 'rootId_s'
            type: 'string'
          }
          {
            name: 'base_b'
            type: 'string'
          }
          {
            name: 'object_tags_s'
            type: 'string'
          }
          {
            name: 'details_tags_s'
            type: 'string'
          }
          {
            name: 'details_tlp_d'
            type: 'string'
          }
          {
            name: 'details_severity_d'
            type: 'string'
          }
          {
            name: 'details_caseId_d'
            type: 'string'
          }
          {
            name: 'details_owner_s'
            type: 'string'
          }
          {
            name: 'details_status_s'
            type: 'string'
          }
          {
            name: 'details_title_s'
            type: 'string'
          }
          {
            name: 'details_flag_b'
            type: 'string'
          }
          {
            name: 'details_description_s'
            type: 'string'
          }
          {
            name: 'requestId_s'
            type: 'string'
          }
          {
            name: 'startDate_d'
            type: 'string'
          }
          {
            name: 'object_id_s'
            type: 'string'
          }
          {
            name: 'object__type_s'
            type: 'string'
          }
          {
            name: 'operation_s'
            type: 'string'
          }
          {
            name: 'object_updatedAt_d'
            type: 'string'
          }
          {
            name: 'details_startDate_d'
            type: 'string'
          }
          {
            name: 'objectType_s'
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
          name: 'Sentinel-TheHive_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TheHive_CL']
        destinations: ['Sentinel-TheHive_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), iobject_updatedBy_s = tostring(iobject_updatedBy_s), object_startDate_d = toreal(object_startDate_d), object_tlp_d = toreal(object_tlp_d), object_severity_d = toreal(object_severity_d), object_caseId_d = toreal(object_caseId_d), object_createdAt_d = toreal(object_createdAt_d), object_owner_s = tostring(object_owner_s), object_status_s = tostring(object_status_s), object_title_s = tostring(object_title_s), object_user_s = tostring(object_user_s), object_flag_b = tobool(object_flag_b), object_description_s = tostring(object_description_s), object_createdBy_s = tostring(object_createdBy_s), rootId_s = tostring(rootId_s), base_b = tobool(base_b), object_tags_s = tostring(object_tags_s), details_tags_s = tostring(details_tags_s), details_tlp_d = toreal(details_tlp_d), details_severity_d = toreal(details_severity_d), details_caseId_d = toreal(details_caseId_d), details_owner_s = tostring(details_owner_s), details_status_s = tostring(details_status_s), details_title_s = tostring(details_title_s), details_flag_b = tobool(details_flag_b), details_description_s = tostring(details_description_s), requestId_s = tostring(requestId_s), startDate_d = toreal(startDate_d), object_id_s = tostring(object_id_s), object__type_s = tostring(object__type_s), operation_s = tostring(operation_s), object_updatedAt_d = toreal(object_updatedAt_d), details_startDate_d = toreal(details_startDate_d), objectType_s = tostring(objectType_s)'
        outputStream: 'Custom-TheHive_CL'
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
