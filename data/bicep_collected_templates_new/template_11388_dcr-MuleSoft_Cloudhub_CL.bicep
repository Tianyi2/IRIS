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
// Data Collection Rule for MuleSoft_Cloudhub_CL
// ============================================================================
// Generated: 2025-09-19 14:20:25
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 33, DCR columns: 31 (Type column always filtered)
// Output stream: Custom-MuleSoft_Cloudhub_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MuleSoft_Cloudhub_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MuleSoft_Cloudhub_CL': {
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
            name: 'event_timestamp_d'
            type: 'string'
          }
          {
            name: 'event_threadName_s'
            type: 'string'
          }
          {
            name: 'event_loggerName_s'
            type: 'string'
          }
          {
            name: 'line_d'
            type: 'string'
          }
          {
            name: 'instanceId_s'
            type: 'string'
          }
          {
            name: 'deploymentId_s'
            type: 'string'
          }
          {
            name: 'recordId_s'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'createdAt_d'
            type: 'string'
          }
          {
            name: 'isSystem_b'
            type: 'string'
          }
          {
            name: 'lastModified_d'
            type: 'string'
          }
          {
            name: 'enabled_b'
            type: 'string'
          }
          {
            name: 'actions_s'
            type: 'string'
          }
          {
            name: 'productName_s'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'environmentId_g'
            type: 'string'
          }
          {
            name: 'organizationId_g'
            type: 'string'
          }
          {
            name: 'condition_resourceType_s'
            type: 'string'
          }
          {
            name: 'condition_resources_s'
            type: 'string'
          }
          {
            name: 'condition_type_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'name_s'
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
            name: 'event_message_s'
            type: 'string'
          }
          {
            name: 'event_priority_s'
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
          name: 'Sentinel-MuleSoft_Cloudhub_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MuleSoft_Cloudhub_CL']
        destinations: ['Sentinel-MuleSoft_Cloudhub_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), event_timestamp_d = toreal(event_timestamp_d), event_threadName_s = tostring(event_threadName_s), event_loggerName_s = tostring(event_loggerName_s), line_d = toreal(line_d), instanceId_s = tostring(instanceId_s), deploymentId_s = tostring(deploymentId_s), recordId_s = tostring(recordId_s), event_type_s = tostring(event_type_s), createdAt_d = toreal(createdAt_d), isSystem_b = tobool(isSystem_b), lastModified_d = toreal(lastModified_d), enabled_b = tobool(enabled_b), actions_s = tostring(actions_s), productName_s = tostring(productName_s), id_g = tostring(id_g), environmentId_g = tostring(environmentId_g), organizationId_g = tostring(organizationId_g), condition_resourceType_s = tostring(condition_resourceType_s), condition_resources_s = tostring(condition_resources_s), condition_type_s = tostring(condition_type_s), severity_s = tostring(severity_s), name_s = tostring(name_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), event_message_s = tostring(event_message_s), event_priority_s = tostring(event_priority_s)'
        outputStream: 'Custom-MuleSoft_Cloudhub_CL'
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
