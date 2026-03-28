// Bicep template for Log Analytics custom table: Corelight_v2_x509_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 26, Deployed columns: 23 (Type column filtered)
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

resource corelightv2x509clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_x509_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_x509_CL'
      description: 'Custom table Corelight_v2_x509_CL - imported from JSON schema'
      displayName: 'Corelight_v2_x509_CL'
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
          name: 'basic_constraints_path_len_d'
          type: 'real'
        }
        {
          name: 'basic_constraints_ca_b'
          type: 'boolean'
        }
        {
          name: 'san_ip_s'
          type: 'string'
        }
        {
          name: 'san_email_s'
          type: 'string'
        }
        {
          name: 'san_uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'san_dns_s'
          type: 'string'
        }
        {
          name: 'certificate_curve_s'
          type: 'string'
        }
        {
          name: 'certificate_exponent_s'
          type: 'string'
        }
        {
          name: 'certificate_key_length_d'
          type: 'real'
        }
        {
          name: 'certificate_key_type_s'
          type: 'string'
        }
        {
          name: 'certificate_sig_alg_s'
          type: 'string'
        }
        {
          name: 'certificate_key_alg_s'
          type: 'string'
        }
        {
          name: 'certificate_not_valid_after_t'
          type: 'dateTime'
        }
        {
          name: 'certificate_not_valid_before_t'
          type: 'dateTime'
        }
        {
          name: 'certificate_issuer_s'
          type: 'string'
        }
        {
          name: 'certificate_subject_s'
          type: 'string'
        }
        {
          name: 'certificate_serial_s'
          type: 'string'
        }
        {
          name: 'certificate_version_d'
          type: 'real'
        }
        {
          name: 'fingerprint_s'
          type: 'string'
        }
        {
          name: 'host_cert_b'
          type: 'boolean'
        }
        {
          name: 'client_cert_b'
          type: 'boolean'
        }
      ]
    }
  }
}

output tableName string = corelightv2x509clTable.name
output tableId string = corelightv2x509clTable.id
output provisioningState string = corelightv2x509clTable.properties.provisioningState
