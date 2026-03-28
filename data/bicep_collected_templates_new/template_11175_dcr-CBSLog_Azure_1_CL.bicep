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
// Data Collection Rule for CBSLog_Azure_1_CL
// ============================================================================
// Generated: 2025-09-19 14:19:58
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 13, DCR columns: 13 (Type column always filtered)
// Output stream: Custom-CBSLog_Azure_1_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CBSLog_Azure_1_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CBSLog_Azure_1_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'brand_s'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'class_s'
            type: 'string'
          }
          {
            name: 'coa_s'
            type: 'string'
          }
          {
            name: 'created_date_s'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'remarks_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'updated_date_s'
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
          name: 'Sentinel-CBSLog_Azure_1_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CBSLog_Azure_1_CL']
        destinations: ['Sentinel-CBSLog_Azure_1_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), brand_s = tostring(brand_s), TenantId = toguid(TenantId), class_s = tostring(class_s), coa_s = tostring(coa_s), created_date_s = tostring(created_date_s), id_s = tostring(id_s), remarks_s = tostring(remarks_s), severity_s = tostring(severity_s), status_s = tostring(status_s), subject_s = tostring(subject_s), type_s = tostring(type_s), updated_date_s = tostring(updated_date_s)'
        outputStream: 'Custom-CBSLog_Azure_1_CL'
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
