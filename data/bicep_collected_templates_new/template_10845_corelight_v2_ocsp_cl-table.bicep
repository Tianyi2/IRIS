// Bicep template for Log Analytics custom table: Corelight_v2_ocsp_CL
// Generated on 2025-09-19 14:13:52 UTC
// Source: JSON schema export
// Original columns: 15, Deployed columns: 12 (Type column filtered)
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

resource corelightv2ocspclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_ocsp_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_ocsp_CL'
      description: 'Custom table Corelight_v2_ocsp_CL - imported from JSON schema'
      displayName: 'Corelight_v2_ocsp_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'hashAlgorithm_s'
          type: 'string'
        }
        {
          name: 'issuerNameHash_s'
          type: 'string'
        }
        {
          name: 'issuerKeyHash_s'
          type: 'string'
        }
        {
          name: 'serialNumber_s'
          type: 'string'
        }
        {
          name: 'certStatus_s'
          type: 'string'
        }
        {
          name: 'revoketime_t'
          type: 'dateTime'
        }
        {
          name: 'revokereason_s'
          type: 'string'
        }
        {
          name: 'thisUpdate_t'
          type: 'dateTime'
        }
        {
          name: 'nextUpdate_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = corelightv2ocspclTable.name
output tableId string = corelightv2ocspclTable.id
output provisioningState string = corelightv2ocspclTable.properties.provisioningState
