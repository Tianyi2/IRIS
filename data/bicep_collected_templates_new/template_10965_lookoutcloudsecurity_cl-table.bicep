// Bicep template for Log Analytics custom table: LookoutCloudSecurity_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 35, Deployed columns: 33 (Type column filtered)
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

resource lookoutcloudsecurityclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'LookoutCloudSecurity_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'LookoutCloudSecurity_CL'
      description: 'Custom table LookoutCloudSecurity_CL - imported from JSON schema'
      displayName: 'LookoutCloudSecurity_CL'
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
          name: 'statusCode_d'
          type: 'real'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'violation_s'
          type: 'string'
        }
        {
          name: 'scanType_s'
          type: 'string'
        }
        {
          name: 'policyName_s'
          type: 'string'
        }
        {
          name: 'externalCollaborators_s'
          type: 'string'
        }
        {
          name: 'cloudType_s'
          type: 'string'
        }
        {
          name: 'previousCity_s'
          type: 'string'
        }
        {
          name: 'previousEventId_g'
          type: 'string'
        }
        {
          name: 'currentEventId_g'
          type: 'string'
        }
        {
          name: 'previousTimestamp_t'
          type: 'dateTime'
        }
        {
          name: 'currentTimestamp_t'
          type: 'dateTime'
        }
        {
          name: 'currentCity_s'
          type: 'string'
        }
        {
          name: 'anomalyName_s'
          type: 'string'
        }
        {
          name: 'userEmail_s'
          type: 'string'
        }
        {
          name: 'anomalyType_s'
          type: 'string'
        }
        {
          name: 'eventId_g'
          type: 'string'
        }
        {
          name: 'contentUrl_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'contentName_s'
          type: 'string'
        }
        {
          name: 'appName_s'
          type: 'string'
        }
        {
          name: 'activityType_s'
          type: 'string'
        }
        {
          name: 'actionType_s'
          type: 'string'
        }
        {
          name: 'eventType_s'
          type: 'string'
        }
        {
          name: 'timeStamp_t'
          type: 'dateTime'
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
          name: 'Message'
          type: 'string'
        }
        {
          name: 'data_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = lookoutcloudsecurityclTable.name
output tableId string = lookoutcloudsecurityclTable.id
output provisioningState string = lookoutcloudsecurityclTable.properties.provisioningState
