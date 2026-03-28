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
// Data Collection Rule for SenservaPro_CL
// ============================================================================
// Generated: 2025-09-19 14:20:31
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 17, DCR columns: 17 (Type column always filtered)
// Output stream: Custom-SenservaPro_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SenservaPro_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SenservaPro_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'ControlName_s'
            type: 'string'
          }
          {
            name: 'TenantDisplayName_s'
            type: 'string'
          }
          {
            name: 'LogAnalyticsWorkspaceDisplayName_s'
            type: 'string'
          }
          {
            name: 'ObjectId_g'
            type: 'string'
          }
          {
            name: 'TenantId_s'
            type: 'string'
          }
          {
            name: 'ScanId_s'
            type: 'string'
          }
          {
            name: 'ScanTime_t'
            type: 'string'
          }
          {
            name: 'CEFLoggingLevel_d'
            type: 'string'
          }
          {
            name: 'ControlId_d'
            type: 'string'
          }
          {
            name: 'MitreControls_s'
            type: 'string'
          }
          {
            name: 'NistControls_s'
            type: 'string'
          }
          {
            name: 'Description_s'
            type: 'string'
          }
          {
            name: 'Value_s'
            type: 'string'
          }
          {
            name: 'Reference_s'
            type: 'string'
          }
          {
            name: 'Group_s'
            type: 'string'
          }
          {
            name: 'Severity'
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
          name: 'Sentinel-SenservaPro_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SenservaPro_CL']
        destinations: ['Sentinel-SenservaPro_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ControlName_s = tostring(ControlName_s), TenantDisplayName_s = tostring(TenantDisplayName_s), LogAnalyticsWorkspaceDisplayName_s = tostring(LogAnalyticsWorkspaceDisplayName_s), ObjectId_g = tostring(ObjectId_g), TenantId_s = tostring(TenantId_s), ScanId_s = tostring(ScanId_s), ScanTime_t = todatetime(ScanTime_t), CEFLoggingLevel_d = toreal(CEFLoggingLevel_d), ControlId_d = toreal(ControlId_d), MitreControls_s = tostring(MitreControls_s), NistControls_s = tostring(NistControls_s), Description_s = tostring(Description_s), Value_s = tostring(Value_s), Reference_s = tostring(Reference_s), Group_s = tostring(Group_s), Severity = tostring(Severity)'
        outputStream: 'Custom-SenservaPro_CL'
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
