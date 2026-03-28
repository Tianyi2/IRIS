// Bicep template for Log Analytics custom table: TaniumDefenderHealth_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 19, Deployed columns: 18 (Type column filtered)
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

resource taniumdefenderhealthclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TaniumDefenderHealth_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TaniumDefenderHealth_CL'
      description: 'Custom table TaniumDefenderHealth_CL - imported from JSON schema'
      displayName: 'TaniumDefenderHealth_CL'
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
          name: 'Signature_Update_Age_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'QuickScan_Age_s'
          type: 'string'
        }
        {
          name: 'Health_s'
          type: 'string'
        }
        {
          name: 'Defender_Process_StartType_s'
          type: 'string'
        }
        {
          name: 'Defender_Process_s'
          type: 'string'
        }
        {
          name: 'Windows_Defender_Client_Version_s'
          type: 'string'
        }
        {
          name: 'Count_s'
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
          name: 'Asset_OS_Platform_s'
          type: 'string'
        }
        {
          name: 'Asset_IP_Address_s'
          type: 'string'
        }
        {
          name: 'Antivirus_State_s'
          type: 'string'
        }
        {
          name: 'AntiSpyware_State_s'
          type: 'string'
        }
        {
          name: 'Computer_Name_s'
          type: 'string'
        }
        {
          name: 'Windows_Defender_Installed_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = taniumdefenderhealthclTable.name
output tableId string = taniumdefenderhealthclTable.id
output provisioningState string = taniumdefenderhealthclTable.properties.provisioningState
