// Bicep template for Log Analytics custom table: Entity_Scoring_Data_CL
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

resource entityscoringdataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Entity_Scoring_Data_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Entity_Scoring_Data_CL'
      description: 'Custom table Entity_Scoring_Data_CL - imported from JSON schema'
      displayName: 'Entity_Scoring_Data_CL'
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
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'last_detection_type_s'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'active_detection_types_s'
          type: 'string'
        }
        {
          name: 'attack_rating_d'
          type: 'real'
        }
        {
          name: 'velocity_contrib_d'
          type: 'real'
        }
        {
          name: 'urgency_score_d'
          type: 'real'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'last_detection_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'is_prioritized_b'
          type: 'boolean'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'entity_type_s'
          type: 'string'
        }
        {
          name: 'importance_d'
          type: 'real'
        }
        {
          name: 'entity_importance_d'
          type: 'real'
        }
        {
          name: 'breadth_contrib_d'
          type: 'real'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'entity_id_d'
          type: 'real'
        }
        {
          name: 'id_d'
          type: 'real'
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
          name: 'last_detection_id_d'
          type: 'real'
        }
        {
          name: 'event_timestamp_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = entityscoringdataclTable.name
output tableId string = entityscoringdataclTable.id
output provisioningState string = entityscoringdataclTable.properties.provisioningState
