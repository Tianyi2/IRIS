// Bicep template for Log Analytics custom table: ForcepointDLPEvents_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 29, Deployed columns: 27 (Type column filtered)
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

resource forcepointdlpeventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ForcepointDLPEvents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ForcepointDLPEvents_CL'
      description: 'Custom table ForcepointDLPEvents_CL - imported from JSON schema'
      displayName: 'ForcepointDLPEvents_CL'
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
          name: 'ForcepointDLPSourceIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'Title'
          type: 'string'
        }
        {
          name: 'SourceDomain'
          type: 'string'
        }
        {
          name: 'DestinationIpV4'
          type: 'real'
        }
        {
          name: 'DestinationCommonName'
          type: 'real'
        }
        {
          name: 'Text'
          type: 'real'
        }
        {
          name: 'SourceIpV4_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ExternalId'
          type: 'string'
        }
        {
          name: 'DestinationHostname'
          type: 'string'
        }
        {
          name: 'UpdatedAt'
          type: 'string'
        }
        {
          name: 'Severity_s'
          type: 'string'
        }
        {
          name: 'RuleName_1_s'
          type: 'string'
        }
        {
          name: 'Id'
          type: 'string'
        }
        {
          name: 'GeneratorId'
          type: 'string'
        }
        {
          name: 'PolicyCategoryId'
          type: 'string'
        }
        {
          name: 'Protocol'
          type: 'string'
        }
        {
          name: 'CreatedAt_t'
          type: 'dateTime'
        }
        {
          name: 'DestinationDomain'
          type: 'string'
        }
        {
          name: 'RawData'
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
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'UpdatedBy'
          type: 'string'
        }
        {
          name: 'Description'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = forcepointdlpeventsclTable.name
output tableId string = forcepointdlpeventsclTable.id
output provisioningState string = forcepointdlpeventsclTable.properties.provisioningState
