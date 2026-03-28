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
// Data Collection Rule for ESIExchangeOnlineConfig_CL
// ============================================================================
// Generated: 2025-09-19 14:20:17
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-ESIExchangeOnlineConfig_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ESIExchangeOnlineConfig_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ESIExchangeOnlineConfig_CL': {
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
            name: 'ExecutionResult_s'
            type: 'string'
          }
          {
            name: 'WhenChanged_t'
            type: 'string'
          }
          {
            name: 'WhenCreated_t'
            type: 'string'
          }
          {
            name: 'WhenChanged_s'
            type: 'string'
          }
          {
            name: 'WhenCreated_s'
            type: 'string'
          }
          {
            name: 'Identity_s'
            type: 'string'
          }
          {
            name: 'Name_s'
            type: 'string'
          }
          {
            name: 'PSCmdL_s'
            type: 'string'
          }
          {
            name: 'Section_s'
            type: 'string'
          }
          {
            name: 'EntryDate_s'
            type: 'string'
          }
          {
            name: 'ESIEnvironment_s'
            type: 'string'
          }
          {
            name: 'GenerationInstanceID_g'
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
            name: 'rawData_s'
            type: 'string'
          }
          {
            name: 'IdentityString_s'
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
          name: 'Sentinel-ESIExchangeOnlineConfig_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ESIExchangeOnlineConfig_CL']
        destinations: ['Sentinel-ESIExchangeOnlineConfig_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), ExecutionResult_s = tostring(ExecutionResult_s), WhenChanged_t = todatetime(WhenChanged_t), WhenCreated_t = todatetime(WhenCreated_t), WhenChanged_s = tostring(WhenChanged_s), WhenCreated_s = tostring(WhenCreated_s), Identity_s = tostring(Identity_s), Name_s = tostring(Name_s), PSCmdL_s = tostring(PSCmdL_s), Section_s = tostring(Section_s), EntryDate_s = tostring(EntryDate_s), ESIEnvironment_s = tostring(ESIEnvironment_s), GenerationInstanceID_g = tostring(GenerationInstanceID_g), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), rawData_s = tostring(rawData_s), IdentityString_s = tostring(IdentityString_s)'
        outputStream: 'Custom-ESIExchangeOnlineConfig_CL'
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
