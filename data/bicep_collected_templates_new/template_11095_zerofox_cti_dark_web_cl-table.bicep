// Bicep template for Log Analytics custom table: ZeroFox_CTI_dark_web_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 19, Deployed columns: 19 (Type column filtered)
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

resource zerofoxctidarkwebclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_dark_web_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_dark_web_CL'
      description: 'Custom table ZeroFox_CTI_dark_web_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_dark_web_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'content_audience_s'
          type: 'string'
        }
        {
          name: 'thread_uuid_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'thread_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'thread_name_s'
          type: 'string'
        }
        {
          name: 'sequence_number_d'
          type: 'real'
        }
        {
          name: 'post_uuid_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'post_type_s'
          type: 'string'
        }
        {
          name: 'post_member_name_s'
          type: 'string'
        }
        {
          name: 'timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'post_body_s'
          type: 'string'
        }
        {
          name: 'parent_uuid_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'network_type_s'
          type: 'string'
        }
        {
          name: 'language_code_s'
          type: 'string'
        }
        {
          name: 'general_topic_s'
          type: 'string'
        }
        {
          name: 'forum_uuid_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'forum_name_s'
          type: 'string'
        }
        {
          name: 'domain_s'
          type: 'string'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = zerofoxctidarkwebclTable.name
output tableId string = zerofoxctidarkwebclTable.id
output provisioningState string = zerofoxctidarkwebclTable.properties.provisioningState
