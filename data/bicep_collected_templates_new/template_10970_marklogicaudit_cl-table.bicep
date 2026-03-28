// Bicep template for Log Analytics custom table: MarkLogicAudit_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 29 (Type column filtered)
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

resource marklogicauditclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MarkLogicAudit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MarkLogicAudit_CL'
      description: 'Custom table MarkLogicAudit_CL - imported from JSON schema'
      displayName: 'MarkLogicAudit_CL'
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
          name: 'EventSubType'
          type: 'string'
        }
        {
          name: 'Roles'
          type: 'string'
        }
        {
          name: 'Function'
          type: 'string'
        }
        {
          name: 'Expr'
          type: 'string'
        }
        {
          name: 'Database'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'EventOriginalResult'
          type: 'string'
        }
        {
          name: 'HttpUserAgentOriginal'
          type: 'string'
        }
        {
          name: 'HttpReferrerOriginal'
          type: 'string'
        }
        {
          name: 'HttpResponseBodyBytes'
          type: 'string'
        }
        {
          name: 'HttpStatusCode'
          type: 'string'
        }
        {
          name: 'HttpVersion'
          type: 'string'
        }
        {
          name: 'HttpRequestMethod'
          type: 'string'
        }
        {
          name: 'SrcUserName'
          type: 'string'
        }
        {
          name: 'ClientIdentity'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'EventResult'
          type: 'string'
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'SourseSystem'
          type: 'string'
        }
        {
          name: 'TenanId'
          type: 'string'
        }
        {
          name: 'EventStartTime'
          type: 'dateTime'
        }
        {
          name: 'EventCount'
          type: 'string'
        }
        {
          name: 'EventSchemaVersion'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'ActorUsername'
          type: 'string'
        }
        {
          name: 'UrlOriginal'
          type: 'string'
          dataTypeHint: 0
        }
      ]
    }
  }
}

output tableName string = marklogicauditclTable.name
output tableId string = marklogicauditclTable.id
output provisioningState string = marklogicauditclTable.properties.provisioningState
