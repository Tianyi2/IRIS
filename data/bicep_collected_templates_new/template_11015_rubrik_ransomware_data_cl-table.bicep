// Bicep template for Log Analytics custom table: Rubrik_Ransomware_Data_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 20, Deployed columns: 18 (Type column filtered)
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

resource rubrikransomwaredataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Rubrik_Ransomware_Data_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Rubrik_Ransomware_Data_CL'
      description: 'Custom table Rubrik_Ransomware_Data_CL - imported from JSON schema'
      displayName: 'Rubrik_Ransomware_Data_CL'
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
          name: 'custom_details_objectType_s'
          type: 'string'
        }
        {
          name: 'custom_details_objectName_s'
          type: 'string'
        }
        {
          name: 'custom_details_type_s'
          type: 'string'
        }
        {
          name: 'custom_details_id_g'
          type: 'string'
        }
        {
          name: 'class_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'custom_details_status_s'
          type: 'string'
        }
        {
          name: 'source_s'
          type: 'string'
        }
        {
          name: 'custom_details_objectId_g'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'summary_s'
          type: 'string'
        }
        {
          name: 'custom_details_clusterId_g'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = rubrikransomwaredataclTable.name
output tableId string = rubrikransomwaredataclTable.id
output provisioningState string = rubrikransomwaredataclTable.properties.provisioningState
