// Bicep template for Log Analytics custom table: Jira_Audit_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 18, Deployed columns: 18 (Type column filtered)
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

resource jiraauditclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Jira_Audit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Jira_Audit_CL'
      description: 'Custom table Jira_Audit_CL - imported from JSON schema'
      displayName: 'Jira_Audit_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'objectItem_parentId_s'
          type: 'string'
        }
        {
          name: 'associatedItems_s'
          type: 'string'
        }
        {
          name: 'changedValues_s'
          type: 'string'
        }
        {
          name: 'objectItem_typeName_s'
          type: 'string'
        }
        {
          name: 'objectItem_name_s'
          type: 'string'
        }
        {
          name: 'objectItem_id_s'
          type: 'string'
        }
        {
          name: 'objectItem_parentName_s'
          type: 'string'
        }
        {
          name: 'eventSource_s'
          type: 'string'
        }
        {
          name: 'authorAccountId_s'
          type: 'string'
        }
        {
          name: 'authorKey_s'
          type: 'string'
        }
        {
          name: 'remoteAddress_s'
          type: 'string'
        }
        {
          name: 'summary_s'
          type: 'string'
        }
        {
          name: 'id_d'
          type: 'real'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'created_t'
          type: 'dateTime'
        }
        {
          name: 'Category'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = jiraauditclTable.name
output tableId string = jiraauditclTable.id
output provisioningState string = jiraauditclTable.properties.provisioningState
