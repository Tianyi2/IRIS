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
// Data Collection Rule for Sonrai_Tickets_CL
// ============================================================================
// Generated: 2025-09-19 14:20:32
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 36, DCR columns: 36 (Type column always filtered)
// Output stream: Custom-Sonrai_Tickets_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Sonrai_Tickets_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Sonrai_Tickets_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'digest_ticketSignature_s'
            type: 'string'
          }
          {
            name: 'digest_ticketKeyDescription_s'
            type: 'string'
          }
          {
            name: 'digest_ticketSrn_s'
            type: 'string'
          }
          {
            name: 'digest_createdDate_d'
            type: 'string'
          }
          {
            name: 'digest_createdBy_s'
            type: 'string'
          }
          {
            name: 'digest_assignedTo_s'
            type: 'string'
          }
          {
            name: 'digest_transitionedBy_s'
            type: 'string'
          }
          {
            name: 'digest_criticalResourceName_s'
            type: 'string'
          }
          {
            name: 'digest_transitionDate_d'
            type: 'string'
          }
          {
            name: 'digest_title_s'
            type: 'string'
          }
          {
            name: 'digest_severityNumeric_d'
            type: 'string'
          }
          {
            name: 'digest_severityCategory_s'
            type: 'string'
          }
          {
            name: 'digest_status_s'
            type: 'string'
          }
          {
            name: 'digest_lastReopenDate_d'
            type: 'string'
          }
          {
            name: 'digest_lastSeenDate_d'
            type: 'string'
          }
          {
            name: 'digest_description_s'
            type: 'string'
          }
          {
            name: 'action_d'
            type: 'string'
          }
          {
            name: 'digest_ticketKeyName_s'
            type: 'string'
          }
          {
            name: 'digest_account_s'
            type: 'string'
          }
          {
            name: 'digest_timestamp_s'
            type: 'string'
          }
          {
            name: 'digest_org_s'
            type: 'string'
          }
          {
            name: 'digest_ticketType_s'
            type: 'string'
          }
          {
            name: 'digest_ticketKey_s'
            type: 'string'
          }
          {
            name: 'digest_swimlanes_s'
            type: 'string'
          }
          {
            name: 'digest_severity_d'
            type: 'string'
          }
          {
            name: 'digest_actionClassification_s'
            type: 'string'
          }
          {
            name: 'digest_evidence_resourceSet_s'
            type: 'string'
          }
          {
            name: 'digest_envidence_path_s'
            type: 'string'
          }
          {
            name: 'digest_evidence_count_d'
            type: 'string'
          }
          {
            name: 'digest_evidence_userAgentSet_s'
            type: 'string'
          }
          {
            name: 'digest_criticalResourceSRN_s'
            type: 'string'
          }
          {
            name: 'digest_resourceType_s'
            type: 'string'
          }
          {
            name: 'digest_resourceLabel_s'
            type: 'string'
          }
          {
            name: 'digest_evidence_conditions_s'
            type: 'string'
          }
          {
            name: 'actor_s'
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
          name: 'Sentinel-Sonrai_Tickets_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Sonrai_Tickets_CL']
        destinations: ['Sentinel-Sonrai_Tickets_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), digest_ticketSignature_s = tostring(digest_ticketSignature_s), digest_ticketKeyDescription_s = tostring(digest_ticketKeyDescription_s), digest_ticketSrn_s = tostring(digest_ticketSrn_s), digest_createdDate_d = toreal(digest_createdDate_d), digest_createdBy_s = tostring(digest_createdBy_s), digest_assignedTo_s = tostring(digest_assignedTo_s), digest_transitionedBy_s = tostring(digest_transitionedBy_s), digest_criticalResourceName_s = tostring(digest_criticalResourceName_s), digest_transitionDate_d = toreal(digest_transitionDate_d), digest_title_s = tostring(digest_title_s), digest_severityNumeric_d = toreal(digest_severityNumeric_d), digest_severityCategory_s = tostring(digest_severityCategory_s), digest_status_s = tostring(digest_status_s), digest_lastReopenDate_d = toreal(digest_lastReopenDate_d), digest_lastSeenDate_d = toreal(digest_lastSeenDate_d), digest_description_s = tostring(digest_description_s), action_d = toreal(action_d), digest_ticketKeyName_s = tostring(digest_ticketKeyName_s), digest_account_s = tostring(digest_account_s), digest_timestamp_s = tostring(digest_timestamp_s), digest_org_s = tostring(digest_org_s), digest_ticketType_s = tostring(digest_ticketType_s), digest_ticketKey_s = tostring(digest_ticketKey_s), digest_swimlanes_s = tostring(digest_swimlanes_s), digest_severity_d = toreal(digest_severity_d), digest_actionClassification_s = tostring(digest_actionClassification_s), digest_evidence_resourceSet_s = tostring(digest_evidence_resourceSet_s), digest_envidence_path_s = tostring(digest_envidence_path_s), digest_evidence_count_d = toreal(digest_evidence_count_d), digest_evidence_userAgentSet_s = tostring(digest_evidence_userAgentSet_s), digest_criticalResourceSRN_s = tostring(digest_criticalResourceSRN_s), digest_resourceType_s = tostring(digest_resourceType_s), digest_resourceLabel_s = tostring(digest_resourceLabel_s), digest_evidence_conditions_s = tostring(digest_evidence_conditions_s), actor_s = tostring(actor_s)'
        outputStream: 'Custom-Sonrai_Tickets_CL'
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
