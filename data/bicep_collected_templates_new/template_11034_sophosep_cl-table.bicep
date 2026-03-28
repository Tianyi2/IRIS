// Bicep template for Log Analytics custom table: SophosEP_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 43, Deployed columns: 40 (Type column filtered)
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

resource sophosepclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SophosEP_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SophosEP_CL'
      description: 'Custom table SophosEP_CL - imported from JSON schema'
      displayName: 'SophosEP_CL'
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
          name: 'amsi_threat_data_processPath_s'
          type: 'string'
        }
        {
          name: 'amsi_threat_data_processId_s'
          type: 'string'
        }
        {
          name: 'amsi_threat_data_processName_s'
          type: 'string'
        }
        {
          name: 'amsi_threat_data_parentProcessId_s'
          type: 'string'
        }
        {
          name: 'amsi_threat_data_parentProcessPath_s'
          type: 'string'
        }
        {
          name: 'source_s'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'when_t'
          type: 'dateTime'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'id_g'
          type: 'string'
        }
        {
          name: 'group_s'
          type: 'string'
        }
        {
          name: 'datastream_s'
          type: 'string'
        }
        {
          name: 'Type_s'
          type: 'string'
        }
        {
          name: 'EventVendor_s'
          type: 'string'
        }
        {
          name: 'EventProduct_s'
          type: 'string'
        }
        {
          name: 'TimeGenerated_s'
          type: 'string'
        }
        {
          name: 'location_s'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
        }
        {
          name: 'origin_s'
          type: 'string'
        }
        {
          name: 'endpoint_id_g'
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
          name: 'amsi_threat_data_processPath_s_s'
          type: 'string'
        }
        {
          name: 'amsi_threat_data_processId_s_s'
          type: 'string'
        }
        {
          name: 'endpoint_type_s'
          type: 'string'
        }
        {
          name: 'amsi_threat_data_processName_s_s'
          type: 'string'
        }
        {
          name: 'amsi_threat_data_parentProcessPath_s_s'
          type: 'string'
        }
        {
          name: 'user_id_s'
          type: 'string'
        }
        {
          name: 'customer_id_g'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
        {
          name: 'source_info_ip_s'
          type: 'string'
        }
        {
          name: 'threat_s'
          type: 'string'
        }
        {
          name: 'amsi_threat_data_parentProcessId_s_s'
          type: 'string'
        }
        {
          name: 'Created'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = sophosepclTable.name
output tableId string = sophosepclTable.id
output provisioningState string = sophosepclTable.properties.provisioningState
