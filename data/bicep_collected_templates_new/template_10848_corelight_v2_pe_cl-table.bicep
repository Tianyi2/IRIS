// Bicep template for Log Analytics custom table: Corelight_v2_pe_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 21, Deployed columns: 18 (Type column filtered)
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

resource corelightv2peclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_pe_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_pe_CL'
      description: 'Custom table Corelight_v2_pe_CL - imported from JSON schema'
      displayName: 'Corelight_v2_pe_CL'
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
          name: 'has_cert_table_b'
          type: 'boolean'
        }
        {
          name: 'has_export_table_b'
          type: 'boolean'
        }
        {
          name: 'has_import_table_b'
          type: 'boolean'
        }
        {
          name: 'uses_seh_b'
          type: 'boolean'
        }
        {
          name: 'uses_code_integrity_b'
          type: 'boolean'
        }
        {
          name: 'uses_dep_b'
          type: 'boolean'
        }
        {
          name: 'has_debug_data_b'
          type: 'boolean'
        }
        {
          name: 'uses_aslr_b'
          type: 'boolean'
        }
        {
          name: 'is_exe_b'
          type: 'boolean'
        }
        {
          name: 'subsystem_s'
          type: 'string'
        }
        {
          name: 'os_s'
          type: 'string'
        }
        {
          name: 'compile_ts_t'
          type: 'dateTime'
        }
        {
          name: 'machine_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'is_64bit_b'
          type: 'boolean'
        }
        {
          name: 'section_names_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2peclTable.name
output tableId string = corelightv2peclTable.id
output provisioningState string = corelightv2peclTable.properties.provisioningState
