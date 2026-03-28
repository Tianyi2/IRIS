// Bicep template for Log Analytics custom table: ZeroFox_CTI_compromised_credentials_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 9, Deployed columns: 9 (Type column filtered)
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

resource zerofoxcticompromisedcredentialsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_compromised_credentials_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_compromised_credentials_CL'
      description: 'Custom table ZeroFox_CTI_compromised_credentials_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_compromised_credentials_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'domain_s'
          type: 'string'
        }
        {
          name: 'email_s'
          type: 'string'
        }
        {
          name: 'username_s'
          type: 'string'
        }
        {
          name: 'password_s'
          type: 'string'
        }
        {
          name: 'breach_name_s'
          type: 'string'
        }
        {
          name: 'breach_id_s'
          type: 'string'
        }
        {
          name: 'impacted_domain_s'
          type: 'string'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = zerofoxcticompromisedcredentialsclTable.name
output tableId string = zerofoxcticompromisedcredentialsclTable.id
output provisioningState string = zerofoxcticompromisedcredentialsclTable.properties.provisioningState
