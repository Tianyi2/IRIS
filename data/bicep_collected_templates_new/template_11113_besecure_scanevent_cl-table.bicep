// Bicep template for Log Analytics custom table: beSECURE_ScanEvent_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 18, Deployed columns: 16 (Type column filtered)
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

resource besecurescaneventclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'beSECURE_ScanEvent_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'beSECURE_ScanEvent_CL'
      description: 'Custom table beSECURE_ScanEvent_CL - imported from JSON schema'
      displayName: 'beSECURE_ScanEvent_CL'
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
          name: 'additional_information'
          type: 'string'
        }
        {
          name: 'event_code'
          type: 'string'
        }
        {
          name: 'event_id'
          type: 'string'
        }
        {
          name: 'event_name'
          type: 'string'
        }
        {
          name: 'event_time'
          type: 'string'
        }
        {
          name: 'scan_id'
          type: 'string'
        }
        {
          name: 'scan_name'
          type: 'string'
        }
        {
          name: 'scan_type'
          type: 'string'
        }
        {
          name: 'scan_event_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = besecurescaneventclTable.name
output tableId string = besecurescaneventclTable.id
output provisioningState string = besecurescaneventclTable.properties.provisioningState
