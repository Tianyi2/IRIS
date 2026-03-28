// Bicep template for Log Analytics custom table: F5Telemetry_system_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 14, Deployed columns: 12 (Type column filtered)
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

resource f5telemetrysystemclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'F5Telemetry_system_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'F5Telemetry_system_CL'
      description: 'Custom table F5Telemetry_system_CL - imported from JSON schema'
      displayName: 'F5Telemetry_system_CL'
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
          name: 'probability'
          type: 'real'
        }
        {
          name: 'RawMessage'
          type: 'string'
        }
        {
          name: 'client_ip_s'
          type: 'string'
        }
        {
          name: 'hostname_s'
          type: 'string'
        }
        {
          name: 'geo_location_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = f5telemetrysystemclTable.name
output tableId string = f5telemetrysystemclTable.id
output provisioningState string = f5telemetrysystemclTable.properties.provisioningState
