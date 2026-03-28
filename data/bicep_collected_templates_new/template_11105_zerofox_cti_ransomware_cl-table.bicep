// Bicep template for Log Analytics custom table: ZeroFox_CTI_ransomware_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 12, Deployed columns: 12 (Type column filtered)
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

resource zerofoxctiransomwareclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_ransomware_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_ransomware_CL'
      description: 'Custom table ZeroFox_CTI_ransomware_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_ransomware_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
        {
          name: 'md5_s'
          type: 'string'
        }
        {
          name: 'sha1_s'
          type: 'string'
        }
        {
          name: 'sha256_s'
          type: 'string'
        }
        {
          name: 'sha512_s'
          type: 'string'
        }
        {
          name: 'emails_s'
          type: 'string'
        }
        {
          name: 'ransom_note_s'
          type: 'string'
        }
        {
          name: 'note_urls_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'crypto_wallets_s'
          type: 'string'
        }
        {
          name: 'ransomware_name_s'
          type: 'string'
        }
        {
          name: 'tags_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zerofoxctiransomwareclTable.name
output tableId string = zerofoxctiransomwareclTable.id
output provisioningState string = zerofoxctiransomwareclTable.properties.provisioningState
