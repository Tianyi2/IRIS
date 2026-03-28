// Bicep template for Log Analytics custom table: CyberSixgill_Alerts_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 28 (Type column filtered)
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

resource cybersixgillalertsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CyberSixgill_Alerts_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CyberSixgill_Alerts_CL'
      description: 'Custom table CyberSixgill_Alerts_CL - imported from JSON schema'
      displayName: 'CyberSixgill_Alerts_CL'
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
          name: 'threat_actor'
          type: 'string'
        }
        {
          name: 'assets'
          type: 'string'
        }
        {
          name: 'user_id'
          type: 'string'
        }
        {
          name: 'title_s'
          type: 'string'
        }
        {
          name: 'threats'
          type: 'string'
        }
        {
          name: 'threat_level'
          type: 'string'
        }
        {
          name: 'sub_alertsize'
          type: 'real'
        }
        {
          name: 'sub_alerts'
          type: 'string'
        }
        {
          name: 'status_name'
          type: 'string'
        }
        {
          name: 'Severity'
          type: 'int'
        }
        {
          name: 'read'
          type: 'boolean'
        }
        {
          name: 'threatource'
          type: 'string'
        }
        {
          name: 'langcode'
          type: 'string'
        }
        {
          name: 'id'
          type: 'string'
        }
        {
          name: 'date_s'
          type: 'string'
        }
        {
          name: 'content'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'alert_type_id'
          type: 'string'
        }
        {
          name: 'alert_name'
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
          name: 'lang'
          type: 'string'
        }
        {
          name: 'portal_url'
          type: 'string'
          dataTypeHint: 0
        }
      ]
    }
  }
}

output tableName string = cybersixgillalertsclTable.name
output tableId string = cybersixgillalertsclTable.id
output provisioningState string = cybersixgillalertsclTable.properties.provisioningState
