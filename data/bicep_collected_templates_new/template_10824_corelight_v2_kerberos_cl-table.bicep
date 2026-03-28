// Bicep template for Log Analytics custom table: Corelight_v2_kerberos_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 24, Deployed columns: 21 (Type column filtered)
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

resource corelightv2kerberosclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_kerberos_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_kerberos_CL'
      description: 'Custom table Corelight_v2_kerberos_CL - imported from JSON schema'
      displayName: 'Corelight_v2_kerberos_CL'
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
          name: 'client_cert_fuid_s'
          type: 'string'
        }
        {
          name: 'client_cert_subject_s'
          type: 'string'
        }
        {
          name: 'renewable_b'
          type: 'boolean'
        }
        {
          name: 'forwardable_b'
          type: 'boolean'
        }
        {
          name: 'cipher_s'
          type: 'string'
        }
        {
          name: 'till_t'
          type: 'dateTime'
        }
        {
          name: 'from_t'
          type: 'dateTime'
        }
        {
          name: 'error_msg_s'
          type: 'string'
        }
        {
          name: 'success_b'
          type: 'boolean'
        }
        {
          name: 'service_s'
          type: 'string'
        }
        {
          name: 'client_s'
          type: 'string'
        }
        {
          name: 'request_type_s'
          type: 'string'
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
          name: 'server_cert_subject_s'
          type: 'string'
        }
        {
          name: 'server_cert_fuid_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2kerberosclTable.name
output tableId string = corelightv2kerberosclTable.id
output provisioningState string = corelightv2kerberosclTable.properties.provisioningState
