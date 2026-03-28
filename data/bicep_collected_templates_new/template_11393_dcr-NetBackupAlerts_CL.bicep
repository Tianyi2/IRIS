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
// Data Collection Rule for NetBackupAlerts_CL
// ============================================================================
// Generated: 2025-09-19 14:20:25
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 18, DCR columns: 16 (Type column always filtered)
// Output stream: Custom-NetBackupAlerts_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-NetBackupAlerts_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-NetBackupAlerts_CL': {
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
            name: 'tenantId_g'
            type: 'string'
          }
          {
            name: 'auditDateTime_d'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'operation_s'
            type: 'string'
          }
          {
            name: 'Message'
            type: 'string'
          }
          {
            name: 'userName_s'
            type: 'string'
          }
          {
            name: 'auditDateTime_t'
            type: 'string'
          }
          {
            name: 'reason_s'
            type: 'string'
          }
          {
            name: 'auditAttributes_s'
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
          name: 'Sentinel-NetBackupAlerts_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-NetBackupAlerts_CL']
        destinations: ['Sentinel-NetBackupAlerts_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), tenantId_g = tostring(tenantId_g), auditDateTime_d = tostring(auditDateTime_d), Category = tostring(Category), operation_s = tostring(operation_s), Message = tostring(Message), userName_s = tostring(userName_s), auditDateTime_t = todatetime(auditDateTime_t), reason_s = tostring(reason_s), auditAttributes_s = tostring(auditAttributes_s)'
        outputStream: 'Custom-NetBackupAlerts_CL'
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
