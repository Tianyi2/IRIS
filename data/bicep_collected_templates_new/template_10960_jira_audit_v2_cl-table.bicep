// Bicep template for Log Analytics custom table: Jira_Audit_v2_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 19, Deployed columns: 19 (Type column filtered)
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

resource jiraauditv2clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Jira_Audit_v2_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Jira_Audit_v2_CL'
      description: 'Custom table Jira_Audit_v2_CL - imported from JSON schema'
      displayName: 'Jira_Audit_v2_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'AssociatedItems'
          type: 'dynamic'
        }
        {
          name: 'ObjectItemTypeName'
          type: 'string'
        }
        {
          name: 'ObjectItemName'
          type: 'string'
        }
        {
          name: 'ObjectItemId'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'EventMessage'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'objectItem'
          type: 'dynamic'
        }
        {
          name: 'EventId'
          type: 'int'
        }
        {
          name: 'EventSource'
          type: 'string'
        }
        {
          name: 'EventCreationTime'
          type: 'dateTime'
        }
        {
          name: 'ChangedValues'
          type: 'dynamic'
        }
        {
          name: 'EventCategoryType'
          type: 'string'
        }
        {
          name: 'UserName'
          type: 'string'
        }
        {
          name: 'UserSid'
          type: 'string'
        }
        {
          name: 'ObjectItemParentId'
          type: 'string'
        }
        {
          name: 'ObjectItemParentName'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = jiraauditv2clTable.name
output tableId string = jiraauditv2clTable.id
output provisioningState string = jiraauditv2clTable.properties.provisioningState
