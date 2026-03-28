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
// Data Collection Rule for Cofense_Triage_failed_indicators_CL
// ============================================================================
// Generated: 2025-09-19 14:20:00
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 19, DCR columns: 17 (Type column always filtered)
// Output stream: Custom-Cofense_Triage_failed_indicators_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Cofense_Triage_failed_indicators_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Cofense_Triage_failed_indicators_CL': {
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
            name: 'SourceSystem'
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
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'kind_s'
            type: 'string'
          }
          {
            name: 'properties_source_s'
            type: 'string'
          }
          {
            name: 'properties_displayName_s'
            type: 'string'
          }
          {
            name: 'properties_confidence_d'
            type: 'string'
          }
          {
            name: 'properties_patternType_s'
            type: 'string'
          }
          {
            name: 'properties_threatTypes_s'
            type: 'string'
          }
          {
            name: 'properties_pattern_s'
            type: 'string'
          }
          {
            name: 'properties_created_t'
            type: 'string'
          }
          {
            name: 'properties_externalLastUpdatedTimeUtc_t'
            type: 'string'
          }
          {
            name: 'report_link_s'
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
          name: 'Sentinel-Cofense_Triage_failed_indicators_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Cofense_Triage_failed_indicators_CL']
        destinations: ['Sentinel-Cofense_Triage_failed_indicators_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), SourceSystem = tostring(SourceSystem), MG = tostring(MG), Computer = tostring(Computer), RawData = tostring(RawData), ManagementGroupName = tostring(ManagementGroupName), kind_s = tostring(kind_s), properties_source_s = tostring(properties_source_s), properties_displayName_s = tostring(properties_displayName_s), properties_confidence_d = toreal(properties_confidence_d), properties_patternType_s = tostring(properties_patternType_s), properties_threatTypes_s = tostring(properties_threatTypes_s), properties_pattern_s = tostring(properties_pattern_s), properties_created_t = todatetime(properties_created_t), properties_externalLastUpdatedTimeUtc_t = todatetime(properties_externalLastUpdatedTimeUtc_t), report_link_s = tostring(report_link_s)'
        outputStream: 'Custom-Cofense_Triage_failed_indicators_CL'
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
