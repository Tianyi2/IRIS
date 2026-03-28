// Bicep template for Log Analytics custom table: DigitalShadows_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 22, Deployed columns: 22 (Type column filtered)
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

resource digitalshadowsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'DigitalShadows_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'DigitalShadows_CL'
      description: 'Custom table DigitalShadows_CL - imported from JSON schema'
      displayName: 'DigitalShadows_CL'
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
          name: 'triage_raised_time_t'
          type: 'dateTime'
        }
        {
          name: 'triage_id_g'
          type: 'string'
        }
        {
          name: 'title_s'
          type: 'dateTime'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'risk_level_s'
          type: 'string'
        }
        {
          name: 'risk_factors_s'
          type: 'string'
        }
        {
          name: 'risk_assessment_risk_level_s'
          type: 'string'
        }
        {
          name: 'raised_t'
          type: 'dateTime'
        }
        {
          name: 'triage_updated_time_t'
          type: 'dateTime'
        }
        {
          name: 'portal_id_s'
          type: 'string'
        }
        {
          name: 'impact_description_s'
          type: 'string'
        }
        {
          name: 'id_g'
          type: 'string'
        }
        {
          name: 'id_d'
          type: 'real'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'comments_s'
          type: 'string'
        }
        {
          name: 'classification_s'
          type: 'string'
        }
        {
          name: 'assets_s'
          type: 'string'
        }
        {
          name: 'mitigation_s'
          type: 'string'
        }
        {
          name: 'updated_t'
          type: 'dateTime'
        }
      ]
    }
  }
}

output tableName string = digitalshadowsclTable.name
output tableId string = digitalshadowsclTable.id
output provisioningState string = digitalshadowsclTable.properties.provisioningState
