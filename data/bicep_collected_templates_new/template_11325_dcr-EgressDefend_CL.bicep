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
// Data Collection Rule for EgressDefend_CL
// ============================================================================
// Generated: 2025-09-19 14:20:17
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 15, DCR columns: 15 (Type column always filtered)
// Output stream: Custom-EgressDefend_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-EgressDefend_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-EgressDefend_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'event_s'
            type: 'string'
          }
          {
            name: 'email_rcptTo_s'
            type: 'string'
          }
          {
            name: 'email_mailFrom_s'
            type: 'string'
          }
          {
            name: 'email_subject_s'
            type: 'string'
          }
          {
            name: 'email_attachments_s'
            type: 'string'
          }
          {
            name: 'email_messageId_s'
            type: 'string'
          }
          {
            name: 'email_threat_s'
            type: 'string'
          }
          {
            name: 'email_trust_s'
            type: 'string'
          }
          {
            name: 'email_firstTimeSender_b'
            type: 'string'
          }
          {
            name: 'email_payload_Type_s'
            type: 'string'
          }
          {
            name: 'email_linksClicked_d'
            type: 'string'
          }
          {
            name: 'email_senderIp_s'
            type: 'string'
          }
          {
            name: 'linkClicked_s'
            type: 'string'
          }
          {
            name: 'email_phishType_s'
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
          name: 'Sentinel-EgressDefend_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-EgressDefend_CL']
        destinations: ['Sentinel-EgressDefend_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), event_s = tostring(event_s), email_rcptTo_s = tostring(email_rcptTo_s), email_mailFrom_s = tostring(email_mailFrom_s), email_subject_s = tostring(email_subject_s), email_attachments_s = tostring(email_attachments_s), email_messageId_s = tostring(email_messageId_s), email_threat_s = tostring(email_threat_s), email_trust_s = tostring(email_trust_s), email_firstTimeSender_b = tobool(email_firstTimeSender_b), email_payload_Type_s = tostring(email_payload_Type_s), email_linksClicked_d = toreal(email_linksClicked_d), email_senderIp_s = tostring(email_senderIp_s), linkClicked_s = tostring(linkClicked_s), email_phishType_s = tostring(email_phishType_s)'
        outputStream: 'Custom-EgressDefend_CL'
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
