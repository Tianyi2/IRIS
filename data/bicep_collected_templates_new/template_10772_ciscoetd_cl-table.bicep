// Bicep template for Log Analytics custom table: CiscoETD_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 41, Deployed columns: 41 (Type column filtered)
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

resource ciscoetdclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CiscoETD_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CiscoETD_CL'
      description: 'Custom table CiscoETD_CL - imported from JSON schema'
      displayName: 'CiscoETD_CL'
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
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'toAddresses_s'
          type: 'string'
        }
        {
          name: 'timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'urls_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'verdict_isManualVerdict_b'
          type: 'boolean'
        }
        {
          name: 'verdict_userId_s'
          type: 'string'
        }
        {
          name: 'verdict_isRetroVerdict_b'
          type: 'boolean'
        }
        {
          name: 'serverIP_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'verdict_techniques_s'
          type: 'string'
        }
        {
          name: 'verdict_originalVerdict_s'
          type: 'string'
        }
        {
          name: 'verdict_latestVerdict_s'
          type: 'string'
        }
        {
          name: 'verdict_category_s'
          type: 'string'
        }
        {
          name: 'verdict_publicApiClientId_s'
          type: 'string'
        }
        {
          name: 'verdict_businessRisk_s'
          type: 'string'
        }
        {
          name: 'secureEmailGateway_originalCIP_s'
          type: 'string'
        }
        {
          name: 'secureEmailGateway_headerName_s'
          type: 'string'
        }
        {
          name: 'verdict_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'returnPath_s'
          type: 'string'
        }
        {
          name: 'internetMessageId_s'
          type: 'string'
        }
        {
          name: 'mailboxes_s'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'attachments_s'
          type: 'string'
        }
        {
          name: 'senderName_s'
          type: 'string'
        }
        {
          name: 'action_type_s'
          type: 'string'
        }
        {
          name: 'action_isAutoRemediated_b'
          type: 'boolean'
        }
        {
          name: 'action_folder_s'
          type: 'string'
        }
        {
          name: 'action_timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'action_publicApiClientId_s'
          type: 'string'
        }
        {
          name: 'fromAddress_s'
          type: 'string'
        }
        {
          name: 'clientIP_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'direction_s'
          type: 'string'
        }
        {
          name: 'domain_s'
          type: 'string'
        }
        {
          name: 'id_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'envelopeTo_s'
          type: 'string'
        }
        {
          name: 'deliveredTo_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ciscoetdclTable.name
output tableId string = ciscoetdclTable.id
output provisioningState string = ciscoetdclTable.properties.provisioningState
