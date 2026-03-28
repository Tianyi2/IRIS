// Bicep template for Log Analytics custom table: MuleSoft_Cloudhub_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 33, Deployed columns: 31 (Type column filtered)
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

resource mulesoftcloudhubclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'MuleSoft_Cloudhub_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'MuleSoft_Cloudhub_CL'
      description: 'Custom table MuleSoft_Cloudhub_CL - imported from JSON schema'
      displayName: 'MuleSoft_Cloudhub_CL'
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
          name: 'event_timestamp_d'
          type: 'real'
        }
        {
          name: 'event_threadName_s'
          type: 'string'
        }
        {
          name: 'event_loggerName_s'
          type: 'string'
        }
        {
          name: 'line_d'
          type: 'real'
        }
        {
          name: 'instanceId_s'
          type: 'string'
        }
        {
          name: 'deploymentId_s'
          type: 'string'
        }
        {
          name: 'recordId_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'createdAt_d'
          type: 'real'
        }
        {
          name: 'isSystem_b'
          type: 'boolean'
        }
        {
          name: 'lastModified_d'
          type: 'real'
        }
        {
          name: 'enabled_b'
          type: 'boolean'
        }
        {
          name: 'actions_s'
          type: 'string'
        }
        {
          name: 'productName_s'
          type: 'string'
        }
        {
          name: 'id_g'
          type: 'string'
        }
        {
          name: 'environmentId_g'
          type: 'string'
        }
        {
          name: 'organizationId_g'
          type: 'string'
        }
        {
          name: 'condition_resourceType_s'
          type: 'string'
        }
        {
          name: 'condition_resources_s'
          type: 'string'
        }
        {
          name: 'condition_type_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'name_s'
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
          name: 'event_message_s'
          type: 'string'
        }
        {
          name: 'event_priority_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = mulesoftcloudhubclTable.name
output tableId string = mulesoftcloudhubclTable.id
output provisioningState string = mulesoftcloudhubclTable.properties.provisioningState
