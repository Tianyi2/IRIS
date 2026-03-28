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
// Data Collection Rule for TrendMicro_XDR_WORKBENCH_CL
// ============================================================================
// Generated: 2025-09-19 14:20:36
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 20, DCR columns: 20 (Type column always filtered)
// Output stream: Custom-TrendMicro_XDR_WORKBENCH_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TrendMicro_XDR_WORKBENCH_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TrendMicro_XDR_WORKBENCH_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'workbenchName_s'
            type: 'string'
          }
          {
            name: 'RegistryValueName_s'
            type: 'string'
          }
          {
            name: 'RegistryValue_s'
            type: 'string'
          }
          {
            name: 'RegistryKey_s'
            type: 'string'
          }
          {
            name: 'ProcessCommandLine_s'
            type: 'string'
          }
          {
            name: 'FileDirectory_s'
            type: 'string'
          }
          {
            name: 'FileName_s'
            type: 'string'
          }
          {
            name: 'UserAccountNTDomain_s'
            type: 'string'
          }
          {
            name: 'alertTriggerTimestamp_t'
            type: 'string'
          }
          {
            name: 'UserAccountName_s'
            type: 'string'
          }
          {
            name: 'impactScope_Summary_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'createdTime_t'
            type: 'string'
          }
          {
            name: 'priorityScore_d'
            type: 'string'
          }
          {
            name: 'workbenchLink_s'
            type: 'string'
          }
          {
            name: 'workbenchId_s'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'alertProvider_s'
            type: 'string'
          }
          {
            name: 'model_s'
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
          name: 'Sentinel-TrendMicro_XDR_WORKBENCH_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TrendMicro_XDR_WORKBENCH_CL']
        destinations: ['Sentinel-TrendMicro_XDR_WORKBENCH_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), workbenchName_s = tostring(workbenchName_s), RegistryValueName_s = tostring(RegistryValueName_s), RegistryValue_s = tostring(RegistryValue_s), RegistryKey_s = tostring(RegistryKey_s), ProcessCommandLine_s = tostring(ProcessCommandLine_s), FileDirectory_s = tostring(FileDirectory_s), FileName_s = tostring(FileName_s), UserAccountNTDomain_s = tostring(UserAccountNTDomain_s), alertTriggerTimestamp_t = todatetime(alertTriggerTimestamp_t), UserAccountName_s = tostring(UserAccountName_s), impactScope_Summary_s = tostring(impactScope_Summary_s), severity_s = tostring(severity_s), createdTime_t = todatetime(createdTime_t), priorityScore_d = toint(priorityScore_d), workbenchLink_s = tostring(workbenchLink_s), workbenchId_s = tostring(workbenchId_s), description_s = tostring(description_s), alertProvider_s = tostring(alertProvider_s), model_s = tostring(model_s)'
        outputStream: 'Custom-TrendMicro_XDR_WORKBENCH_CL'
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
