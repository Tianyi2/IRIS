// Bicep template for Log Analytics custom table: Detections_Data_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 33, Deployed columns: 31 (Type column filtered)
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

resource detectionsdataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Detections_Data_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Detections_Data_CL'
      description: 'Custom table Detections_Data_CL - imported from JSON schema'
      displayName: 'Detections_Data_CL'
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
          name: 'src_ip_s'
          type: 'string'
        }
        {
          name: 'normal_domains_s'
          type: 'string'
        }
        {
          name: 'src_host_s'
          type: 'string'
        }
        {
          name: 'is_targeting_key_asset_s'
          type: 'string'
        }
        {
          name: 'd_detection_details_s'
          type: 'string'
        }
        {
          name: 'detail_s'
          type: 'string'
        }
        {
          name: 'entity_uid_s'
          type: 'string'
        }
        {
          name: 'detection_id_d'
          type: 'real'
        }
        {
          name: 'event_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'Severity'
          type: 'int'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'entity_type_s'
          type: 'string'
        }
        {
          name: 'entity_id_d'
          type: 'real'
        }
        {
          name: 'detection_href_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'd_type_vname_s'
          type: 'string'
        }
        {
          name: 'detection_type_s'
          type: 'string'
        }
        {
          name: 'triaged_b'
          type: 'boolean'
        }
        {
          name: 'certainty_d'
          type: 'real'
        }
        {
          name: 'threat_d'
          type: 'real'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'id_d'
          type: 'real'
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
          name: 'summary_s'
          type: 'string'
        }
        {
          name: 'grouped_details_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = detectionsdataclTable.name
output tableId string = detectionsdataclTable.id
output provisioningState string = detectionsdataclTable.properties.provisioningState
