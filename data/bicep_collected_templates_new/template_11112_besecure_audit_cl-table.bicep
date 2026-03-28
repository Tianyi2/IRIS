// Bicep template for Log Analytics custom table: beSECURE_Audit_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 16, Deployed columns: 14 (Type column filtered)
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

resource besecureauditclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'beSECURE_Audit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'beSECURE_Audit_CL'
      description: 'Custom table beSECURE_Audit_CL - imported from JSON schema'
      displayName: 'beSECURE_Audit_CL'
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
          name: 'audit_code'
          type: 'string'
        }
        {
          name: 'audit_id'
          type: 'string'
        }
        {
          name: 'audit_name'
          type: 'string'
        }
        {
          name: 'audit_event_s'
          type: 'string'
        }
        {
          name: 'originator_ip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'triggered_by'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = besecureauditclTable.name
output tableId string = besecureauditclTable.id
output provisioningState string = besecureauditclTable.properties.provisioningState
