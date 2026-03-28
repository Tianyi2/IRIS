// Bicep template for Log Analytics custom table: TheHive_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 34, Deployed columns: 34 (Type column filtered)
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

resource thehiveclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TheHive_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TheHive_CL'
      description: 'Custom table TheHive_CL - imported from JSON schema'
      displayName: 'TheHive_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'iobject_updatedBy_s'
          type: 'string'
        }
        {
          name: 'object_startDate_d'
          type: 'real'
        }
        {
          name: 'object_tlp_d'
          type: 'real'
        }
        {
          name: 'object_severity_d'
          type: 'real'
        }
        {
          name: 'object_caseId_d'
          type: 'real'
        }
        {
          name: 'object_createdAt_d'
          type: 'real'
        }
        {
          name: 'object_owner_s'
          type: 'string'
        }
        {
          name: 'object_status_s'
          type: 'string'
        }
        {
          name: 'object_title_s'
          type: 'string'
        }
        {
          name: 'object_user_s'
          type: 'string'
        }
        {
          name: 'object_flag_b'
          type: 'boolean'
        }
        {
          name: 'object_description_s'
          type: 'string'
        }
        {
          name: 'object_createdBy_s'
          type: 'string'
        }
        {
          name: 'rootId_s'
          type: 'string'
        }
        {
          name: 'base_b'
          type: 'boolean'
        }
        {
          name: 'object_tags_s'
          type: 'string'
        }
        {
          name: 'details_tags_s'
          type: 'string'
        }
        {
          name: 'details_tlp_d'
          type: 'real'
        }
        {
          name: 'details_severity_d'
          type: 'real'
        }
        {
          name: 'details_caseId_d'
          type: 'real'
        }
        {
          name: 'details_owner_s'
          type: 'string'
        }
        {
          name: 'details_status_s'
          type: 'string'
        }
        {
          name: 'details_title_s'
          type: 'string'
        }
        {
          name: 'details_flag_b'
          type: 'boolean'
        }
        {
          name: 'details_description_s'
          type: 'string'
        }
        {
          name: 'requestId_s'
          type: 'string'
        }
        {
          name: 'startDate_d'
          type: 'real'
        }
        {
          name: 'object_id_s'
          type: 'string'
        }
        {
          name: 'object__type_s'
          type: 'string'
        }
        {
          name: 'operation_s'
          type: 'string'
        }
        {
          name: 'object_updatedAt_d'
          type: 'real'
        }
        {
          name: 'details_startDate_d'
          type: 'real'
        }
        {
          name: 'objectType_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = thehiveclTable.name
output tableId string = thehiveclTable.id
output provisioningState string = thehiveclTable.properties.provisioningState
