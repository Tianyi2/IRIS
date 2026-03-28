// Bicep template for Log Analytics custom table: MailGuard365_Threats_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 32, Deployed columns: 31 (Type column filtered)
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

resource mailguard365threatsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MailGuard365_Threats_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MailGuard365_Threats_CL'
      description: 'Custom table MailGuard365_Threats_CL - imported from JSON schema'
      displayName: 'MailGuard365_Threats_CL'
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
          name: 'Email_s'
          type: 'string'
        }
        {
          name: 'IsInBlackList_b'
          type: 'boolean'
        }
        {
          name: 'IsInWhiteList_b'
          type: 'boolean'
        }
        {
          name: 'MicrosoftAntiSpam_s'
          type: 'string'
        }
        {
          name: 'ForefrontAntiSpam_s'
          type: 'string'
        }
        {
          name: 'ReceivedDateTime_d'
          type: 'real'
        }
        {
          name: 'Action_s'
          type: 'string'
        }
        {
          name: 'MessageSize_d'
          type: 'real'
        }
        {
          name: 'MessageDate_t'
          type: 'dateTime'
        }
        {
          name: 'OriginCountry_s'
          type: 'string'
        }
        {
          name: 'Subject_s'
          type: 'string'
        }
        {
          name: 'CcHeader_s'
          type: 'string'
        }
        {
          name: 'ToHeader_s'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'SenderHeader_s'
          type: 'string'
        }
        {
          name: 'ReceivedHeaders_s'
          type: 'string'
        }
        {
          name: 'Recipients_s'
          type: 'string'
        }
        {
          name: 'Sender_Domain_s'
          type: 'dateTime'
        }
        {
          name: 'Sender_Email_s'
          type: 'real'
        }
        {
          name: 'Attachments_s'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'Virus_b'
          type: 'boolean'
        }
        {
          name: 'Score_d'
          type: 'real'
        }
        {
          name: 'CustomerTenantId_g'
          type: 'string'
        }
        {
          name: 'UserId_g'
          type: 'string'
        }
        {
          name: 'HeaderMessageId_s'
          type: 'string'
        }
        {
          name: 'MessageId_s'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'HasAttachment_b'
          type: 'boolean'
        }
        {
          name: 'HasImage_b'
          type: 'boolean'
        }
      ]
    }
  }
}

output tableName string = mailguard365threatsclTable.name
output tableId string = mailguard365threatsclTable.id
output provisioningState string = mailguard365threatsclTable.properties.provisioningState
