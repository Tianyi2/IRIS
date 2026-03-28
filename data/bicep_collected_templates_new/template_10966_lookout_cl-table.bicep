// Bicep template for Log Analytics custom table: Lookout_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 35, Deployed columns: 35 (Type column filtered)
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

resource lookoutclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Lookout_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Lookout_CL'
      description: 'Custom table Lookout_CL - imported from JSON schema'
      displayName: 'Lookout_CL'
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
          name: 'target_osVersion_s'
          type: 'string'
        }
        {
          name: 'target_platform_s'
          type: 'string'
        }
        {
          name: 'target_emailAddress_s'
          type: 'string'
        }
        {
          name: 'target_id_g'
          type: 'string'
        }
        {
          name: 'target_type_s'
          type: 'string'
        }
        {
          name: 'details_pcpDeviceResponse_s'
          type: 'string'
        }
        {
          name: 'details_pcpReportingReason_s'
          type: 'string'
        }
        {
          name: 'details_assessments_s'
          type: 'dynamic'
        }
        {
          name: 'details_classifications_s'
          type: 'dynamic'
        }
        {
          name: 'details_severity_s'
          type: 'string'
        }
        {
          name: 'details_action_s'
          type: 'string'
        }
        {
          name: 'details_id_g'
          type: 'string'
        }
        {
          name: 'details_type_s'
          type: 'string'
        }
        {
          name: 'actor_id_g'
          type: 'string'
        }
        {
          name: 'actor_type_s'
          type: 'string'
        }
        {
          name: 'changeType_s'
          type: 'string'
        }
        {
          name: 'eventTime_t'
          type: 'dateTime'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'details_activationStatus_s'
          type: 'string'
        }
        {
          name: 'details_securityStatus_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'details_protectionStatus_s'
          type: 'string'
        }
        {
          name: 'updatedDetails_s'
          type: 'dynamic'
        }
        {
          name: 'details_description_s'
          type: 'string'
        }
        {
          name: 'target_manufacturer_s'
          type: 'string'
        }
        {
          name: 'details_applicationName_s'
          type: 'string'
        }
        {
          name: 'details_path_s'
          type: 'string'
        }
        {
          name: 'details_fileName_s'
          type: 'string'
        }
        {
          name: 'details_packageSha_s'
          type: 'string'
        }
        {
          name: 'details_attributeChanges_s'
          type: 'dynamic'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'details_packageName_s'
          type: 'string'
        }
        {
          name: 'target_model_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = lookoutclTable.name
output tableId string = lookoutclTable.id
output provisioningState string = lookoutclTable.properties.provisioningState
