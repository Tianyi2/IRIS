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
// Data Collection Rule for MailRiskEmails_CL
// ============================================================================
// Generated: 2025-09-19 14:20:24
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 39, DCR columns: 35 (Type column always filtered)
// Output stream: Custom-MailRiskEmails_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MailRiskEmails_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MailRiskEmails_CL': {
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
            name: 'assessments_s'
            type: 'string'
          }
          {
            name: 'headers_s'
            type: 'string'
          }
          {
            name: 'content_status_s'
            type: 'string'
          }
          {
            name: 'assessed_at_s'
            type: 'string'
          }
          {
            name: 'sent_at_s'
            type: 'string'
          }
          {
            name: 'risk_source_s'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'feedback_provided_b'
            type: 'string'
          }
          {
            name: 'feedback_requested_b'
            type: 'string'
          }
          {
            name: 'company_id_d'
            type: 'string'
          }
          {
            name: 'reporter_domain_s'
            type: 'string'
          }
          {
            name: 'attachments_s'
            type: 'string'
          }
          {
            name: 'links_s'
            type: 'string'
          }
          {
            name: 'originating_ip_s'
            type: 'string'
          }
          {
            name: 'spf_s'
            type: 'string'
          }
          {
            name: 'spam_score_d'
            type: 'string'
          }
          {
            name: 'reply_to_s'
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
            name: 'MG_s'
            type: 'string'
          }
          {
            name: 'reported_risk_d'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'message_id_s'
            type: 'string'
          }
          {
            name: 'size_bytes_d'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'from_email_s'
            type: 'string'
          }
          {
            name: 'from_name_s'
            type: 'string'
          }
          {
            name: 'reported_at_s'
            type: 'string'
          }
          {
            name: 'risk_s'
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
          name: 'Sentinel-MailRiskEmails_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MailRiskEmails_CL']
        destinations: ['Sentinel-MailRiskEmails_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), assessments_s = tostring(assessments_s), headers_s = tostring(headers_s), content_status_s = tostring(content_status_s), assessed_at_s = tostring(assessed_at_s), sent_at_s = tostring(sent_at_s), risk_source_s = tostring(risk_source_s), Category = tostring(Category), feedback_provided_b = tobool(feedback_provided_b), feedback_requested_b = tobool(feedback_requested_b), company_id_d = toreal(company_id_d), reporter_domain_s = tostring(reporter_domain_s), attachments_s = tostring(attachments_s), links_s = tostring(links_s), originating_ip_s = tostring(originating_ip_s), spf_s = tostring(spf_s), spam_score_d = toreal(spam_score_d), reply_to_s = tostring(reply_to_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), MG_s = tostring(MG_s), reported_risk_d = toreal(reported_risk_d), event_type_s = tostring(event_type_s), id_d = toreal(id_d), message_id_s = tostring(message_id_s), size_bytes_d = toreal(size_bytes_d), subject_s = tostring(subject_s), from_email_s = tostring(from_email_s), from_name_s = tostring(from_name_s), reported_at_s = tostring(reported_at_s), risk_s = tostring(risk_s)'
        outputStream: 'Custom-MailRiskEmails_CL'
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
