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
// Data Collection Rule for NXLogFIM_CL
// ============================================================================
// Generated: 2025-09-19 14:20:27
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 27, DCR columns: 22 (Type column always filtered)
// Output stream: Custom-NXLogFIM_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-NXLogFIM_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-NXLogFIM_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'Severity_s'
            type: 'string'
          }
          {
            name: 'SeverityValue_d'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'PrevModificationTime_t'
            type: 'string'
          }
          {
            name: 'PrevFileSize_d'
            type: 'string'
          }
          {
            name: 'PrevFileName_s'
            type: 'string'
          }
          {
            name: 'PrevDigest_s'
            type: 'string'
          }
          {
            name: 'Object_s'
            type: 'string'
          }
          {
            name: 'SourceModuleName_s'
            type: 'string'
          }
          {
            name: 'ModificationTime_t'
            type: 'string'
          }
          {
            name: 'HostIP_s'
            type: 'string'
          }
          {
            name: 'FileSize_d'
            type: 'string'
          }
          {
            name: 'FileName_s'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'EventTime_t'
            type: 'string'
          }
          {
            name: 'EventReceivedTime_t'
            type: 'string'
          }
          {
            name: 'Digest_s'
            type: 'string'
          }
          {
            name: 'DigestName_s'
            type: 'string'
          }
          {
            name: 'Hostname_s'
            type: 'string'
          }
          {
            name: 'SourceModuleType_s'
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
          name: 'Sentinel-NXLogFIM_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-NXLogFIM_CL']
        destinations: ['Sentinel-NXLogFIM_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Computer = tostring(Computer), Severity_s = tostring(Severity_s), SeverityValue_d = toreal(SeverityValue_d), RawData = tostring(RawData), PrevModificationTime_t = todatetime(PrevModificationTime_t), PrevFileSize_d = toreal(PrevFileSize_d), PrevFileName_s = tostring(PrevFileName_s), PrevDigest_s = tostring(PrevDigest_s), Object_s = tostring(Object_s), SourceModuleName_s = tostring(SourceModuleName_s), ModificationTime_t = todatetime(ModificationTime_t), HostIP_s = tostring(HostIP_s), FileSize_d = toreal(FileSize_d), FileName_s = tostring(FileName_s), EventType_s = tostring(EventType_s), EventTime_t = todatetime(EventTime_t), EventReceivedTime_t = todatetime(EventReceivedTime_t), Digest_s = tostring(Digest_s), DigestName_s = tostring(DigestName_s), Hostname_s = tostring(Hostname_s), SourceModuleType_s = tostring(SourceModuleType_s)'
        outputStream: 'Custom-NXLogFIM_CL'
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
