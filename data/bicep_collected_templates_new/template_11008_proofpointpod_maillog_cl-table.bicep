// Bicep template for Log Analytics custom table: ProofpointPOD_maillog_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 31, Deployed columns: 31 (Type column filtered)
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

resource proofpointpodmaillogclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ProofpointPOD_maillog_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ProofpointPOD_maillog_CL'
      description: 'Custom table ProofpointPOD_maillog_CL - imported from JSON schema'
      displayName: 'ProofpointPOD_maillog_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'sm_pri_s'
          type: 'string'
        }
        {
          name: 'sm_delay_s'
          type: 'string'
        }
        {
          name: 'sm_to_s'
          type: 'string'
        }
        {
          name: 'sm_dsn_s'
          type: 'string'
        }
        {
          name: 'sm_stat_s'
          type: 'string'
        }
        {
          name: 'sm_mailer_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'metadata_origin_data_cid_s'
          type: 'string'
        }
        {
          name: 'metadata_origin_data_agent_s'
          type: 'string'
        }
        {
          name: 'data_s'
          type: 'string'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'sm_qid_s'
          type: 'string'
        }
        {
          name: 'sm_class_s'
          type: 'string'
        }
        {
          name: 'sm_from_s'
          type: 'string'
        }
        {
          name: 'sm_proto_s'
          type: 'string'
        }
        {
          name: 'sm_daemon_s'
          type: 'string'
        }
        {
          name: 'sm_relay_s'
          type: 'string'
        }
        {
          name: 'sm_tls_verify_s'
          type: 'string'
        }
        {
          name: 'sm_auth_s'
          type: 'string'
        }
        {
          name: 'sm_sizeBytes_s'
          type: 'string'
        }
        {
          name: 'sm_nrcpts_s'
          type: 'string'
        }
        {
          name: 'sm_msgid_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'pps_agent_s'
          type: 'string'
        }
        {
          name: 'pps_cid_s'
          type: 'string'
        }
        {
          name: 'sm_msgid_g'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'sm_xdelay_s'
          type: 'string'
        }
        {
          name: 'sm_ctladdr_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = proofpointpodmaillogclTable.name
output tableId string = proofpointpodmaillogclTable.id
output provisioningState string = proofpointpodmaillogclTable.properties.provisioningState
