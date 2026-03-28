// Bicep template for Log Analytics custom table: RedCanaryDetections_CL
// Generated on 2025-09-19 14:13:57 UTC
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

resource redcanarydetectionsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'RedCanaryDetections_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'RedCanaryDetections_CL'
      description: 'Custom table RedCanaryDetections_CL - imported from JSON schema'
      displayName: 'RedCanaryDetections_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'child_process_iocs_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'process_iocs_s'
          type: 'string'
        }
        {
          name: 'network_connection_iocs_s'
          type: 'string'
        }
        {
          name: 'identities_s'
          type: 'string'
        }
        {
          name: 'host_os_version_s'
          type: 'string'
        }
        {
          name: 'host_os_family_s'
          type: 'string'
        }
        {
          name: 'host_name_s'
          type: 'string'
        }
        {
          name: 'registry_modification_iocs_s'
          type: 'string'
        }
        {
          name: 'host_full_name_s'
          type: 'string'
        }
        {
          name: 'detection_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'detection_severity_s'
          type: 'string'
        }
        {
          name: 'detection_id_s'
          type: 'string'
        }
        {
          name: 'detection_headline_s'
          type: 'string'
        }
        {
          name: 'detection_details_s'
          type: 'string'
        }
        {
          name: 'cross_process_iocs_s'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'file_modification_iocs_s'
          type: 'string'
        }
        {
          name: 'tactics_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = redcanarydetectionsclTable.name
output tableId string = redcanarydetectionsclTable.id
output provisioningState string = redcanarydetectionsclTable.properties.provisioningState
