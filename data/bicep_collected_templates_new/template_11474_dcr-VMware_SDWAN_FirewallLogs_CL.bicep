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
// Data Collection Rule for VMware_SDWAN_FirewallLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:37
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 36, DCR columns: 36 (Type column always filtered)
// Output stream: Custom-VMware_SDWAN_FirewallLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-VMware_SDWAN_FirewallLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-VMware_SDWAN_FirewallLogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'actionTaken'
            type: 'string'
          }
          {
            name: 'ipsAlert'
            type: 'string'
          }
          {
            name: 'logType'
            type: 'string'
          }
          {
            name: 'protocol'
            type: 'string'
          }
          {
            name: 'ruleId'
            type: 'string'
          }
          {
            name: 'ruleVersion'
            type: 'string'
          }
          {
            name: 'segmentLogicalId'
            type: 'string'
          }
          {
            name: 'inputInterface'
            type: 'string'
          }
          {
            name: 'segmentName'
            type: 'string'
          }
          {
            name: 'sessionId'
            type: 'string'
          }
          {
            name: 'severity'
            type: 'string'
          }
          {
            name: 'signature'
            type: 'string'
          }
          {
            name: 'signatureId'
            type: 'string'
          }
          {
            name: 'sourceIp'
            type: 'string'
          }
          {
            name: 'sourcePort'
            type: 'string'
          }
          {
            name: 'sessionDurationSecs'
            type: 'string'
          }
          {
            name: 'timestamp'
            type: 'string'
          }
          {
            name: 'idsAlert'
            type: 'string'
          }
          {
            name: 'extensionHeader'
            type: 'string'
          }
          {
            name: 'application'
            type: 'string'
          }
          {
            name: 'attackSource'
            type: 'string'
          }
          {
            name: 'attackTarget'
            type: 'string'
          }
          {
            name: 'bytesReceived'
            type: 'string'
          }
          {
            name: 'bytesSent'
            type: 'string'
          }
          {
            name: 'category'
            type: 'string'
          }
          {
            name: 'firewallPolicyName'
            type: 'string'
          }
          {
            name: 'closeReason'
            type: 'string'
          }
          {
            name: 'destinationIp'
            type: 'string'
          }
          {
            name: 'destinationPort'
            type: 'string'
          }
          {
            name: 'domainName'
            type: 'string'
          }
          {
            name: 'edgeLogicalId'
            type: 'string'
          }
          {
            name: 'edgeName'
            type: 'string'
          }
          {
            name: 'enterpriseLogicalId'
            type: 'string'
          }
          {
            name: 'destination'
            type: 'string'
          }
          {
            name: 'verdict'
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
          name: 'Sentinel-VMware_SDWAN_FirewallLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-VMware_SDWAN_FirewallLogs_CL']
        destinations: ['Sentinel-VMware_SDWAN_FirewallLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), actionTaken = tostring(actionTaken), ipsAlert = toint(ipsAlert), logType = tostring(logType), protocol = toint(protocol), ruleId = tostring(ruleId), ruleVersion = toint(ruleVersion), segmentLogicalId = tostring(segmentLogicalId), inputInterface = todatetime(inputInterface), segmentName = tostring(segmentName), sessionId = toint(sessionId), severity = toint(severity), signature = tostring(signature), signatureId = toint(signatureId), sourceIp = tostring(sourceIp), sourcePort = toint(sourcePort), sessionDurationSecs = toint(sessionDurationSecs), timestamp = todatetime(timestamp), idsAlert = toint(idsAlert), extensionHeader = tostring(extensionHeader), application = tostring(application), attackSource = tostring(attackSource), attackTarget = tostring(attackTarget), bytesReceived = toint(bytesReceived), bytesSent = toint(bytesSent), category = tostring(category), firewallPolicyName = tostring(firewallPolicyName), closeReason = tostring(closeReason), destinationIp = tostring(destinationIp), destinationPort = toint(destinationPort), domainName = tostring(domainName), edgeLogicalId = tostring(edgeLogicalId), edgeName = todatetime(edgeName), enterpriseLogicalId = tostring(enterpriseLogicalId), destination = tostring(destination), verdict = tostring(verdict)'
        outputStream: 'Custom-VMware_SDWAN_FirewallLogs_CL'
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
