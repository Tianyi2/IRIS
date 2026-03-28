// Bicep template for Log Analytics custom table: Corelight_v2_files_red_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 29, Deployed columns: 26 (Type column filtered)
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

resource corelightv2filesredclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_files_red_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_files_red_CL'
      description: 'Custom table Corelight_v2_files_red_CL - imported from JSON schema'
      displayName: 'Corelight_v2_files_red_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_s'
          type: 'string'
        }
        {
          name: 'sha1_s'
          type: 'string'
        }
        {
          name: 'md5_s'
          type: 'string'
        }
        {
          name: 'extracted_size_d'
          type: 'real'
        }
        {
          name: 'extracted_cutoff_b'
          type: 'boolean'
        }
        {
          name: 'extracted_s'
          type: 'string'
        }
        {
          name: 'parent_fuid_s'
          type: 'string'
        }
        {
          name: 'timedout_b'
          type: 'boolean'
        }
        {
          name: 'overflow_bytes_d'
          type: 'real'
        }
        {
          name: 'missing_bytes_d'
          type: 'real'
        }
        {
          name: 'total_bytes_d'
          type: 'real'
        }
        {
          name: 'sha256_s'
          type: 'string'
        }
        {
          name: 'seen_bytes_d'
          type: 'real'
        }
        {
          name: 'local_orig_b'
          type: 'boolean'
        }
        {
          name: 'filename_s'
          type: 'string'
        }
        {
          name: 'mime_type_s'
          type: 'string'
        }
        {
          name: 'analyzers_s'
          type: 'string'
        }
        {
          name: 'depth_d'
          type: 'real'
        }
        {
          name: 'source_s'
          type: 'string'
        }
        {
          name: 'conn_uids_s'
          type: 'string'
        }
        {
          name: 'rx_hosts_s'
          type: 'string'
        }
        {
          name: 'tx_hosts_s'
          type: 'string'
        }
        {
          name: 'fuid_s'
          type: 'string'
        }
        {
          name: 'is_orig_b'
          type: 'boolean'
        }
        {
          name: 'num_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2filesredclTable.name
output tableId string = corelightv2filesredclTable.id
output provisioningState string = corelightv2filesredclTable.properties.provisioningState
