// Bicep template for Log Analytics custom table: Corelight_v2_smb_mapping_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 14, Deployed columns: 11 (Type column filtered)
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

resource corelightv2smbmappingclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_smb_mapping_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_smb_mapping_CL'
      description: 'Custom table Corelight_v2_smb_mapping_CL - imported from JSON schema'
      displayName: 'Corelight_v2_smb_mapping_CL'
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
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 'id_orig_h_s'
          type: 'string'
        }
        {
          name: 'id_orig_p_d'
          type: 'real'
        }
        {
          name: 'id_resp_h_s'
          type: 'string'
        }
        {
          name: 'id_resp_p_d'
          type: 'real'
        }
        {
          name: 'path_s'
          type: 'string'
        }
        {
          name: 'service_s'
          type: 'string'
        }
        {
          name: 'native_file_system_s'
          type: 'string'
        }
        {
          name: 'share_type_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2smbmappingclTable.name
output tableId string = corelightv2smbmappingclTable.id
output provisioningState string = corelightv2smbmappingclTable.properties.provisioningState
