// Bicep template for Log Analytics custom table: CommvaultSecurityIQ_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 22 (Type column filtered)
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

resource commvaultsecurityiqclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CommvaultSecurityIQ_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CommvaultSecurityIQ_CL'
      description: 'Custom table CommvaultSecurityIQ_CL - imported from JSON schema'
      displayName: 'CommvaultSecurityIQ_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'anomaly_sub_type_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'guid'
          dataTypeHint: 1
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
          name: 'username_s'
          type: 'string'
        }
        {
          name: 'user_id_d'
          type: 'real'
        }
        {
          name: 'subclient_id_d'
          type: 'real'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'scanned_folder_list_s'
          type: 'string'
        }
        {
          name: 'job_start_time_s'
          type: 'string'
        }
        {
          name: 'job_id_s'
          type: 'string'
        }
        {
          name: 'job_end_time_s'
          type: 'string'
        }
        {
          name: 'files_list_s'
          type: 'string'
        }
        {
          name: 'external_link_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'deleted_files_count_s'
          type: 'string'
        }
        {
          name: 'created_files_count_s'
          type: 'string'
        }
        {
          name: 'originating_client_s'
          type: 'string'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
      ]
    }
  }
}

output tableName string = commvaultsecurityiqclTable.name
output tableId string = commvaultsecurityiqclTable.id
output provisioningState string = commvaultsecurityiqclTable.properties.provisioningState
