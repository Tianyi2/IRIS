// Bicep template for Log Analytics custom table: Corelight_v2_smb_files_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 20 (Type column filtered)
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

resource corelightv2smbfilesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_smb_files_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_smb_files_CL'
      description: 'Custom table Corelight_v2_smb_files_CL - imported from JSON schema'
      displayName: 'Corelight_v2_smb_files_CL'
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
          name: 'data_offset_req_d'
          type: 'real'
        }
        {
          name: 'times_changed_t'
          type: 'dateTime'
        }
        {
          name: 'times_created_t'
          type: 'dateTime'
        }
        {
          name: 'times_accessed_t'
          type: 'dateTime'
        }
        {
          name: 'times_modified_t'
          type: 'dateTime'
        }
        {
          name: 'prev_name_s'
          type: 'string'
        }
        {
          name: 'size_d'
          type: 'real'
        }
        {
          name: 'data_len_req_d'
          type: 'real'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'fuid_s'
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
          name: 'path_s'
          type: 'string'
        }
        {
          name: 'data_len_rsp_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = corelightv2smbfilesclTable.name
output tableId string = corelightv2smbfilesclTable.id
output provisioningState string = corelightv2smbfilesclTable.properties.provisioningState
