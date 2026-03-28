// Bicep template for Log Analytics custom table: VaronisAlerts_CL
// Generated on 2025-09-19 14:13:59 UTC
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

resource varonisalertsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'VaronisAlerts_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'VaronisAlerts_CL'
      description: 'Custom table VaronisAlerts_CL - imported from JSON schema'
      displayName: 'VaronisAlerts_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'DeviceName_s'
          type: 'string'
        }
        {
          name: 'IngestTime_t'
          type: 'dateTime'
        }
        {
          name: 'EventUTC_t'
          type: 'dateTime'
        }
        {
          name: 'FileServerOrDomain_s'
          type: 'string'
        }
        {
          name: 'Platform_s'
          type: 'string'
        }
        {
          name: 'AssetContainsSensitiveData_s'
          type: 'string'
        }
        {
          name: 'AssetContainsFlaggedData_s'
          type: 'string'
        }
        {
          name: 'Asset_s'
          type: 'string'
        }
        {
          name: 'SamAccountName_s'
          type: 'string'
        }
        {
          name: 'UserName_s'
          type: 'string'
        }
        {
          name: 'NumOfAlertedEvents_d'
          type: 'real'
        }
        {
          name: 'StatusId_d'
          type: 'real'
        }
        {
          name: 'Status_s'
          type: 'string'
        }
        {
          name: 'SeverityId_d'
          type: 'real'
        }
        {
          name: 'Severity_s'
          type: 'string'
        }
        {
          name: 'Time_t'
          type: 'dateTime'
        }
        {
          name: 'Name_s'
          type: 'string'
        }
        {
          name: 'ID_g'
          type: 'string'
        }
        {
          name: 'Query_s'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = varonisalertsclTable.name
output tableId string = varonisalertsclTable.id
output provisioningState string = varonisalertsclTable.properties.provisioningState
