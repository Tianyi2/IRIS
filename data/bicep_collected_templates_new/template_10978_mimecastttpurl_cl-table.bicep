// Bicep template for Log Analytics custom table: MimecastTTPUrl_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 25, Deployed columns: 25 (Type column filtered)
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

resource mimecastttpurlclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MimecastTTPUrl_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MimecastTTPUrl_CL'
      description: 'Custom table MimecastTTPUrl_CL - imported from JSON schema'
      displayName: 'MimecastTTPUrl_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'userEmailAddress_s'
          type: 'string'
        }
        {
          name: 'mimecastEventId_s'
          type: 'string'
        }
        {
          name: 'messageId_s'
          type: 'string'
        }
        {
          name: 'emailPartsDescription_s'
          type: 'string'
        }
        {
          name: 'creationMethod_s'
          type: 'string'
        }
        {
          name: 'route_s'
          type: 'string'
        }
        {
          name: 'actions_s'
          type: 'string'
        }
        {
          name: 'date_t'
          type: 'dateTime'
        }
        {
          name: 'userAwarenessAction_s'
          type: 'string'
        }
        {
          name: 'advancedPhishingResult_CredentialTheftEvidence_s'
          type: 'string'
        }
        {
          name: 'advancedPhishingResult_CredentialTheftTags_s'
          type: 'string'
        }
        {
          name: 'advancedPhishingResult_CredentialTheftBrands_s'
          type: 'string'
        }
        {
          name: 'sendingIp_s'
          type: 'string'
        }
        {
          name: 'category_s'
          type: 'string'
        }
        {
          name: 'scanResult_s'
          type: 'string'
        }
        {
          name: 'userOverride_s'
          type: 'string'
        }
        {
          name: 'adminOverride_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'ttpDefinition_s'
          type: 'string'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'fromUserEmailAddress_s'
          type: 'string'
        }
        {
          name: 'mimecastEventCategory_s'
          type: 'string'
        }
        {
          name: 'time_generated'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = mimecastttpurlclTable.name
output tableId string = mimecastttpurlclTable.id
output provisioningState string = mimecastttpurlclTable.properties.provisioningState
