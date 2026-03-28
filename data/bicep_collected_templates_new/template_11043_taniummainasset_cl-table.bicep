// Bicep template for Log Analytics custom table: TaniumMainAsset_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 23, Deployed columns: 22 (Type column filtered)
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

resource taniummainassetclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TaniumMainAsset_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TaniumMainAsset_CL'
      description: 'Custom table TaniumMainAsset_CL - imported from JSON schema'
      displayName: 'TaniumMainAsset_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Age_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'OS_Platform_s'
          type: 'string'
        }
        {
          name: 'IP_Address_s'
          type: 'string'
        }
        {
          name: 'Health_Status_s'
          type: 'string'
        }
        {
          name: 'Count_s'
          type: 'string'
        }
        {
          name: 'Computer_Name_s'
          type: 'string'
        }
        {
          name: 'Computer_ID_s'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'Reason_s'
          type: 'string'
        }
        {
          name: 'Asset_System_UUID_g'
          type: 'string'
        }
        {
          name: 'Asset_OS_Platform_s'
          type: 'string'
        }
        {
          name: 'Asset_Operating_System_s'
          type: 'string'
        }
        {
          name: 'Asset_Model_s'
          type: 'string'
        }
        {
          name: 'Asset_Manufacturer_s'
          type: 'string'
        }
        {
          name: 'Asset_IP_Address_s'
          type: 'string'
        }
        {
          name: 'Asset_Domain_Name_s'
          type: 'string'
        }
        {
          name: 'Asset_Computer_Serial_Number_s'
          type: 'string'
        }
        {
          name: 'Asset_Chassis_Type_s'
          type: 'string'
        }
        {
          name: 'Asset_Service_Pack_s'
          type: 'string'
        }
        {
          name: 'Username_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = taniummainassetclTable.name
output tableId string = taniummainassetclTable.id
output provisioningState string = taniummainassetclTable.properties.provisioningState
