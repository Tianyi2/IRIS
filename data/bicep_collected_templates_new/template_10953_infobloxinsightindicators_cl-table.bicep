// Bicep template for Log Analytics custom table: InfobloxInsightIndicators_CL
// Generated on 2025-09-19 14:13:56 UTC
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

resource infobloxinsightindicatorsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'InfobloxInsightIndicators_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'InfobloxInsightIndicators_CL'
      description: 'Custom table InfobloxInsightIndicators_CL - imported from JSON schema'
      displayName: 'InfobloxInsightIndicators_CL'
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
          name: 'properties_friendlyName_s'
          type: 'string'
        }
        {
          name: 'properties_category_s'
          type: 'string'
        }
        {
          name: 'properties_malwareName_s'
          type: 'string'
        }
        {
          name: 'kind_s'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'name_g'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'properties_friendlyName_g'
          type: 'string'
        }
        {
          name: 'properties_objectGuid_g'
          type: 'string'
        }
        {
          name: 'actor_s'
          type: 'string'
        }
        {
          name: 'timeMin_t'
          type: 'dateTime'
        }
        {
          name: 'timeMax_t'
          type: 'dateTime'
        }
        {
          name: 'indicator_s'
          type: 'string'
        }
        {
          name: 'threatLevelMax_s'
          type: 'string'
        }
        {
          name: 'feedName_s'
          type: 'string'
        }
        {
          name: 'count_d'
          type: 'real'
        }
        {
          name: 'confidence_s'
          type: 'string'
        }
        {
          name: 'action_s'
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
          name: 'InfobloxInsightID_g'
          type: 'string'
        }
        {
          name: 'InfobloxInsightLogType_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = infobloxinsightindicatorsclTable.name
output tableId string = infobloxinsightindicatorsclTable.id
output provisioningState string = infobloxinsightindicatorsclTable.properties.provisioningState
