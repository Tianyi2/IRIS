// Bicep template for Log Analytics custom table: QualysKB_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 21, Deployed columns: 21 (Type column filtered)
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

resource qualyskbclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'QualysKB_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'QualysKB_CL'
      description: 'Custom table QualysKB_CL - imported from JSON schema'
      displayName: 'QualysKB_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'QID_s'
          type: 'string'
        }
        {
          name: 'Discovery_Additional_Info_s'
          type: 'string'
        }
        {
          name: 'Vuln_Type_s'
          type: 'string'
        }
        {
          name: 'Solution_s'
          type: 'string'
        }
        {
          name: 'Software_Vendor_s'
          type: 'string'
        }
        {
          name: 'Software_Product_s'
          type: 'string'
        }
        {
          name: 'Severity_Level_s'
          type: 'string'
        }
        {
          name: 'Published_DateTime_s'
          type: 'string'
        }
        {
          name: 'PCI_Flag_s'
          type: 'string'
        }
        {
          name: 'Vendor_Reference_URL_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'Vendor_Reference_ID_s'
          type: 'string'
        }
        {
          name: 'CVE_URL_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'CVE_ID_s'
          type: 'string'
        }
        {
          name: 'Last_Service_Modification_DateTime_s'
          type: 'string'
        }
        {
          name: 'Diagnosis_s'
          type: 'string'
        }
        {
          name: 'Consequence_s'
          type: 'string'
        }
        {
          name: 'Category_s'
          type: 'string'
        }
        {
          name: 'Title_s'
          type: 'string'
        }
        {
          name: 'Discovery_Auth_Type_s'
          type: 'string'
        }
        {
          name: 'Discovery_Remote_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = qualyskbclTable.name
output tableId string = qualyskbclTable.id
output provisioningState string = qualyskbclTable.properties.provisioningState
