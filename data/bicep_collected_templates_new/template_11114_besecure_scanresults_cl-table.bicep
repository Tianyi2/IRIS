// Bicep template for Log Analytics custom table: beSECURE_ScanResults_CL
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

resource besecurescanresultsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'beSECURE_ScanResults_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'beSECURE_ScanResults_CL'
      description: 'Custom table beSECURE_ScanResults_CL - imported from JSON schema'
      displayName: 'beSECURE_ScanResults_CL'
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
          name: 'cves'
          type: 'string'
        }
        {
          name: 'cvss_score_s'
          type: 'string'
        }
        {
          name: 'destination_host_s'
          type: 'string'
        }
        {
          name: 'destination_port'
          type: 'string'
        }
        {
          name: 'risk_name_s'
          type: 'string'
        }
        {
          name: 'risk_value_s'
          type: 'string'
        }
        {
          name: 'scan_name'
          type: 'string'
        }
        {
          name: 'test_id'
          type: 'string'
        }
        {
          name: 'vulnerability_name'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = besecurescanresultsclTable.name
output tableId string = besecurescanresultsclTable.id
output provisioningState string = besecurescanresultsclTable.properties.provisioningState
