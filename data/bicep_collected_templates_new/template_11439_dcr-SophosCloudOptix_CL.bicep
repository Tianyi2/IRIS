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
// Data Collection Rule for SophosCloudOptix_CL
// ============================================================================
// Generated: 2025-09-19 14:20:32
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-SophosCloudOptix_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SophosCloudOptix_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SophosCloudOptix_CL': {
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
            name: 'lastSeen_s'
            type: 'string'
          }
          {
            name: 'firstSeen_s'
            type: 'string'
          }
          {
            name: 'alertType_s'
            type: 'string'
          }
          {
            name: 'alertSummary_s'
            type: 'string'
          }
          {
            name: 'alertState_s'
            type: 'string'
          }
          {
            name: 'alertRemediation_s'
            type: 'string'
          }
          {
            name: 'alertLink_s'
            type: 'string'
          }
          {
            name: 'alertId_s'
            type: 'string'
          }
          {
            name: 'alertDescription_s'
            type: 'string'
          }
          {
            name: 'affectedResources_s'
            type: 'string'
          }
          {
            name: 'accountName_s'
            type: 'string'
          }
          {
            name: 'accountId_s'
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
            name: 'policyTagName_s'
            type: 'string'
          }
          {
            name: 'severity_s'
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
          name: 'Sentinel-SophosCloudOptix_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SophosCloudOptix_CL']
        destinations: ['Sentinel-SophosCloudOptix_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), lastSeen_s = tostring(lastSeen_s), firstSeen_s = tostring(firstSeen_s), alertType_s = tostring(alertType_s), alertSummary_s = tostring(alertSummary_s), alertState_s = tostring(alertState_s), alertRemediation_s = tostring(alertRemediation_s), alertLink_s = tostring(alertLink_s), alertId_s = tostring(alertId_s), alertDescription_s = tostring(alertDescription_s), affectedResources_s = tostring(affectedResources_s), accountName_s = tostring(accountName_s), accountId_s = tostring(accountId_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), policyTagName_s = tostring(policyTagName_s), severity_s = tostring(severity_s)'
        outputStream: 'Custom-SophosCloudOptix_CL'
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
