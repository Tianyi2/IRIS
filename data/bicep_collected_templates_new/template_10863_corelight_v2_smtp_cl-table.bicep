// Bicep template for Log Analytics custom table: Corelight_v2_smtp_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 33, Deployed columns: 30 (Type column filtered)
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

resource corelightv2smtpclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_smtp_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_smtp_CL'
      description: 'Custom table Corelight_v2_smtp_CL - imported from JSON schema'
      displayName: 'Corelight_v2_smtp_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'is_webmail_b'
          type: 'boolean'
        }
        {
          name: 'fuids_s'
          type: 'string'
        }
        {
          name: 'tls_b'
          type: 'boolean'
        }
        {
          name: 'user_agent_s'
          type: 'string'
        }
        {
          name: 'path_s'
          type: 'string'
        }
        {
          name: 'last_reply_s'
          type: 'string'
        }
        {
          name: 'second_received_s'
          type: 'string'
        }
        {
          name: 'first_received_s'
          type: 'string'
        }
        {
          name: 'x_originating_ip_s'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'in_reply_to_s'
          type: 'string'
        }
        {
          name: 'msg_id_s'
          type: 'string'
        }
        {
          name: 'urls_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'reply_to_s'
          type: 'string'
        }
        {
          name: 'to_s'
          type: 'string'
        }
        {
          name: 'from_s'
          type: 'string'
        }
        {
          name: 'date_s'
          type: 'string'
        }
        {
          name: 'rcptto_s'
          type: 'string'
        }
        {
          name: 'mailfrom_s'
          type: 'string'
        }
        {
          name: 'helo_s'
          type: 'string'
        }
        {
          name: 'trans_depth_d'
          type: 'real'
        }
        {
          name: 'id_resp_p_d'
          type: 'real'
        }
        {
          name: 'id_resp_h_s'
          type: 'string'
        }
        {
          name: 'id_orig_p_d'
          type: 'real'
        }
        {
          name: 'id_orig_h_s'
          type: 'string'
        }
        {
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 'cc_s'
          type: 'string'
        }
        {
          name: 'domains_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2smtpclTable.name
output tableId string = corelightv2smtpclTable.id
output provisioningState string = corelightv2smtpclTable.properties.provisioningState
