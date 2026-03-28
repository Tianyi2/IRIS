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
// Data Collection Rule for BSMmacOS_CL
// ============================================================================
// Generated: 2025-09-19 14:19:58
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 38, DCR columns: 36 (Type column always filtered)
// Output stream: Custom-BSMmacOS_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BSMmacOS_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BSMmacOS_CL': {
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
            name: 'SubjectTerminal_Port_s'
            type: 'string'
          }
          {
            name: 'SubjectTerminal_Host_s'
            type: 'string'
          }
          {
            name: 'Text_s'
            type: 'string'
          }
          {
            name: 'ReturnErrno_s'
            type: 'string'
          }
          {
            name: 'ReturnRetval_s'
            type: 'string'
          }
          {
            name: 'Identity_s'
            type: 'string'
          }
          {
            name: 'SubjectTerminal_s'
            type: 'string'
          }
          {
            name: 'Identity_SignerType_s'
            type: 'string'
          }
          {
            name: 'Identity_SignerIdTruncated_s'
            type: 'string'
          }
          {
            name: 'Identity_TeamId_s'
            type: 'string'
          }
          {
            name: 'Identity_TeamIdTruncated_s'
            type: 'string'
          }
          {
            name: 'Identity_CDHash_s'
            type: 'string'
          }
          {
            name: 'TrailerCount_s'
            type: 'string'
          }
          {
            name: 'EventReceivedTime_t'
            type: 'string'
          }
          {
            name: 'Identity_SignerId_s'
            type: 'string'
          }
          {
            name: 'SourceModuleName_s'
            type: 'string'
          }
          {
            name: 'SubjectSID_s'
            type: 'string'
          }
          {
            name: 'SubjectRealGID_s'
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
            name: 'ManagementGroupName'
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
            name: 'TokenVersion_s'
            type: 'string'
          }
          {
            name: 'SubjectPID_s'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'EventModifier_s'
            type: 'string'
          }
          {
            name: 'EventTime_s'
            type: 'string'
          }
          {
            name: 'SubjectAuditID_s'
            type: 'string'
          }
          {
            name: 'SubjectUID_s'
            type: 'string'
          }
          {
            name: 'SubjectGID_s'
            type: 'string'
          }
          {
            name: 'SubjectRealUID_s'
            type: 'string'
          }
          {
            name: 'EventName_s'
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
          name: 'Sentinel-BSMmacOS_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BSMmacOS_CL']
        destinations: ['Sentinel-BSMmacOS_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), SubjectTerminal_Port_s = tostring(SubjectTerminal_Port_s), SubjectTerminal_Host_s = tostring(SubjectTerminal_Host_s), Text_s = tostring(Text_s), ReturnErrno_s = tostring(ReturnErrno_s), ReturnRetval_s = tostring(ReturnRetval_s), Identity_s = tostring(Identity_s), SubjectTerminal_s = tostring(SubjectTerminal_s), Identity_SignerType_s = tostring(Identity_SignerType_s), Identity_SignerIdTruncated_s = tostring(Identity_SignerIdTruncated_s), Identity_TeamId_s = tostring(Identity_TeamId_s), Identity_TeamIdTruncated_s = tostring(Identity_TeamIdTruncated_s), Identity_CDHash_s = tostring(Identity_CDHash_s), TrailerCount_s = tostring(TrailerCount_s), EventReceivedTime_t = todatetime(EventReceivedTime_t), Identity_SignerId_s = tostring(Identity_SignerId_s), SourceModuleName_s = tostring(SourceModuleName_s), SubjectSID_s = tostring(SubjectSID_s), SubjectRealGID_s = tostring(SubjectRealGID_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), TokenVersion_s = tostring(TokenVersion_s), SubjectPID_s = tostring(SubjectPID_s), EventType_s = tostring(EventType_s), EventModifier_s = tostring(EventModifier_s), EventTime_s = tostring(EventTime_s), SubjectAuditID_s = tostring(SubjectAuditID_s), SubjectUID_s = tostring(SubjectUID_s), SubjectGID_s = tostring(SubjectGID_s), SubjectRealUID_s = tostring(SubjectRealUID_s), EventName_s = tostring(EventName_s), SourceModuleType_s = tostring(SourceModuleType_s)'
        outputStream: 'Custom-BSMmacOS_CL'
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
