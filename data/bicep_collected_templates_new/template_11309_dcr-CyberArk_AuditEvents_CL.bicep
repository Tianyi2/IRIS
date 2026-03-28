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
// Data Collection Rule for CyberArk_AuditEvents_CL
// ============================================================================
// Generated: 2025-09-19 14:20:15
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 17, DCR columns: 17 (Type column always filtered)
// Output stream: Custom-CyberArk_AuditEvents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CyberArk_AuditEvents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CyberArk_AuditEvents_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'CyberArkTenantId'
            type: 'string'
          }
          {
            name: 'timestamp'
            type: 'string'
          }
          {
            name: 'username'
            type: 'string'
          }
          {
            name: 'applicationCode'
            type: 'string'
          }
          {
            name: 'auditCode'
            type: 'string'
          }
          {
            name: 'action'
            type: 'string'
          }
          {
            name: 'auditType'
            type: 'string'
          }
          {
            name: 'userId'
            type: 'string'
          }
          {
            name: 'source'
            type: 'string'
          }
          {
            name: 'actionType'
            type: 'string'
          }
          {
            name: 'component'
            type: 'string'
          }
          {
            name: 'serviceName'
            type: 'string'
          }
          {
            name: 'target'
            type: 'string'
          }
          {
            name: 'command'
            type: 'string'
          }
          {
            name: 'sessionId'
            type: 'string'
          }
          {
            name: 'message'
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
          name: 'Sentinel-CyberArk_AuditEvents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CyberArk_AuditEvents_CL']
        destinations: ['Sentinel-CyberArk_AuditEvents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), CyberArkTenantId = tostring(CyberArkTenantId), timestamp = toint(timestamp), username = tostring(username), applicationCode = tostring(applicationCode), auditCode = tostring(auditCode), action = tostring(action), auditType = tostring(auditType), userId = tostring(userId), source = tostring(source), actionType = tostring(actionType), component = tostring(component), serviceName = tostring(serviceName), target = tostring(target), command = tostring(command), sessionId = tostring(sessionId), message = tostring(message)'
        outputStream: 'Custom-CyberArk_AuditEvents_CL'
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
