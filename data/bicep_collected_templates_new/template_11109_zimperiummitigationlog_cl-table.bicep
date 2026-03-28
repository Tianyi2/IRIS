// Bicep template for Log Analytics custom table: ZimperiumMitigationLog_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 17, Deployed columns: 15 (Type column filtered)
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

resource zimperiummitigationlogclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZimperiumMitigationLog_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZimperiumMitigationLog_CL'
      description: 'Custom table ZimperiumMitigationLog_CL - imported from JSON schema'
      displayName: 'ZimperiumMitigationLog_CL'
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
          name: 'threat_uuid'
          type: 'string'
        }
        {
          name: 'event_id_s'
          type: 'string'
        }
        {
          name: 'zdevice_id'
          type: 'string'
        }
        {
          name: 'device_os_s'
          type: 'string'
        }
        {
          name: 'event_timestamp_s'
          type: 'string'
        }
        {
          name: 'account_id'
          type: 'string'
        }
        {
          name: 'detection_app_instance_id'
          type: 'string'
        }
        {
          name: 'mitigated'
          type: 'boolean'
        }
      ]
    }
  }
}

output tableName string = zimperiummitigationlogclTable.name
output tableId string = zimperiummitigationlogclTable.id
output provisioningState string = zimperiummitigationlogclTable.properties.provisioningState
