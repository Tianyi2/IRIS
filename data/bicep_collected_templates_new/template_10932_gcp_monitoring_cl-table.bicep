// Bicep template for Log Analytics custom table: GCP_MONITORING_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 25, Deployed columns: 23 (Type column filtered)
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

resource gcpmonitoringclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GCP_MONITORING_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GCP_MONITORING_CL'
      description: 'Custom table GCP_MONITORING_CL - imported from JSON schema'
      displayName: 'GCP_MONITORING_CL'
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
          name: 'interval_startTime_t'
          type: 'dateTime'
        }
        {
          name: 'valueType_s'
          type: 'string'
        }
        {
          name: 'metricKind_s'
          type: 'string'
        }
        {
          name: 'resource_labels_zone_s'
          type: 'string'
        }
        {
          name: 'resource_labels_instance_id_s'
          type: 'string'
        }
        {
          name: 'resource_labels_project_id_s'
          type: 'string'
        }
        {
          name: 'resource_type_s'
          type: 'string'
        }
        {
          name: 'metric_type_s'
          type: 'string'
        }
        {
          name: 'metric_labels_storage_type_s'
          type: 'string'
        }
        {
          name: 'metric_labels_device_name_s'
          type: 'string'
        }
        {
          name: 'metric_labels_instance_name_s'
          type: 'string'
        }
        {
          name: 'metric_labels_device_type_s'
          type: 'string'
        }
        {
          name: 'value_doubleValue_d'
          type: 'real'
        }
        {
          name: 'metric_labels_loadbalanced_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'interval_endTime_t'
          type: 'dateTime'
        }
        {
          name: 'value_int64Value_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = gcpmonitoringclTable.name
output tableId string = gcpmonitoringclTable.id
output provisioningState string = gcpmonitoringclTable.properties.provisioningState
