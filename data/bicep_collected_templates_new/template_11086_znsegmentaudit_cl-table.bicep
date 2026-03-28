// Bicep template for Log Analytics custom table: ZNSegmentAudit_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 22, Deployed columns: 20 (Type column filtered)
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

resource znsegmentauditclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZNSegmentAudit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZNSegmentAudit_CL'
      description: 'Custom table ZNSegmentAudit_CL - imported from JSON schema'
      displayName: 'ZNSegmentAudit_CL'
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
          name: 'reportedObjectGeneration_d'
          type: 'real'
        }
        {
          name: 'reportedObjectId_g'
          type: 'string'
        }
        {
          name: 'details_s'
          type: 'string'
        }
        {
          name: 'destinationEntitiesList_s'
          type: 'string'
        }
        {
          name: 'userRole_d'
          type: 'real'
        }
        {
          name: 'enforcementSource_d'
          type: 'real'
        }
        {
          name: 'auditType_d'
          type: 'real'
        }
        {
          name: 'performedBy_id_g'
          type: 'string'
        }
        {
          name: 'timestamp_d'
          type: 'string'
        }
        {
          name: 'reportedObjectId_s'
          type: 'string'
        }
        {
          name: 'parentObjectId_g'
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
          name: 'performedBy_id_s'
          type: 'string'
        }
        {
          name: 'performedBy_name_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = znsegmentauditclTable.name
output tableId string = znsegmentauditclTable.id
output provisioningState string = znsegmentauditclTable.properties.provisioningState
