// Bicep template for Log Analytics custom table: Authomize_v2_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 30, Deployed columns: 30 (Type column filtered)
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

resource authomizev2clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Authomize_v2_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Authomize_v2_CL'
      description: 'Custom table Authomize_v2_CL - imported from JSON schema'
      displayName: 'Authomize_v2_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'app_s'
          type: 'string'
        }
        {
          name: 'updatedAt_t'
          type: 'dateTime'
        }
        {
          name: 'techniques_s'
          type: 'string'
        }
        {
          name: 'tactics_s'
          type: 'string'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'slot_ID_d'
          type: 'real'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'recommendation_s'
          type: 'string'
        }
        {
          name: 'policyId_s'
          type: 'string'
        }
        {
          name: 'policy_templateId_s'
          type: 'string'
        }
        {
          name: 'policy_name_s'
          type: 'string'
        }
        {
          name: 'policy_id_s'
          type: 'string'
        }
        {
          name: 'performance_Value_d'
          type: 'real'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'measurement_Name_s'
          type: 'string'
        }
        {
          name: 'IsActive_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'ID_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'entities_s'
          type: 'string'
        }
        {
          name: 'duration_d'
          type: 'real'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'critical_Threshold_d'
          type: 'real'
        }
        {
          name: 'createdAt_t'
          type: 'dateTime'
        }
        {
          name: 'compliance_s'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'availability_Value_d'
          type: 'real'
        }
        {
          name: 'assigneeId_s'
          type: 'string'
        }
        {
          name: 'isResolved_b'
          type: 'boolean'
        }
        {
          name: 'warning_Threshold_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = authomizev2clTable.name
output tableId string = authomizev2clTable.id
output provisioningState string = authomizev2clTable.properties.provisioningState
