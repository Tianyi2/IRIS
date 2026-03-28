// Bicep template for Log Analytics custom table: MailRiskEmails_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 39, Deployed columns: 35 (Type column filtered)
// Underscore columns filtered out
// dataTypeHint values: 0=Uri, 1=Guid, 2=ArmPath, 3=IP

@description('Log Analytics Workspace name')
param workspaceName string

@description('Table plan - Analytics or Basic')
@allowed(['Analytics', 'Basic'])
param tablePlan string = 'Analytics'

@description('Data retention period in days')
@minValue(4)
@maxValue(730)
param retentionInDays int = 30

@description('Total retention period in days')
@minValue(4)
@maxValue(4383)
param totalRetentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' existing = {
  name: workspaceName
}

resource mailriskemailsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MailRiskEmails_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MailRiskEmails_CL'
      description: 'Custom table MailRiskEmails_CL - imported from JSON schema'
      displayName: 'MailRiskEmails_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
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
          type: 'boolean'
        }
        {
          name: 'feedback_requested_b'
          type: 'boolean'
        }
        {
          name: 'company_id_d'
          type: 'real'
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
          dataTypeHint: 0
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'id_d'
          type: 'real'
        }
        {
          name: 'message_id_s'
          type: 'string'
        }
        {
          name: 'size_bytes_d'
          type: 'real'
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
}

output tableName string = mailriskemailsclTable.name
output tableId string = mailriskemailsclTable.id
output provisioningState string = mailriskemailsclTable.properties.provisioningState
