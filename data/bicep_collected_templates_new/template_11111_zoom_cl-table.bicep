// Bicep template for Log Analytics custom table: Zoom_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 42, Deployed columns: 42 (Type column filtered)
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

resource zoomclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Zoom_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Zoom_CL'
      description: 'Custom table Zoom_CL - imported from JSON schema'
      displayName: 'Zoom_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'EventCategoryType'
          type: 'string'
        }
        {
          name: 'CreateTime'
          type: 'dateTime'
        }
        {
          name: 'EventCreationTime'
          type: 'dateTime'
        }
        {
          name: 'Usage'
          type: 'string'
        }
        {
          name: 'PlanUsage'
          type: 'string'
        }
        {
          name: 'FreeUsage'
          type: 'string'
        }
        {
          name: 'Time'
          type: 'dateTime'
        }
        {
          name: 'Operator'
          type: 'string'
        }
        {
          name: 'CategoryType'
          type: 'string'
        }
        {
          name: 'Action'
          type: 'string'
        }
        {
          name: 'OperationDetail'
          type: 'string'
        }
        {
          name: 'EventOriginalMessage'
          type: 'string'
        }
        {
          name: 'EventResult'
          type: 'string'
        }
        {
          name: 'IpAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ClientType'
          type: 'string'
        }
        {
          name: 'SrcDvcModelName'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
        }
        {
          name: 'Version'
          type: 'string'
        }
        {
          name: 'LastLoginTime'
          type: 'dateTime'
        }
        {
          name: 'Department'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventDay'
          type: 'string'
        }
        {
          name: 'Date'
          type: 'string'
        }
        {
          name: 'NewUsersCount'
          type: 'real'
        }
        {
          name: 'MeetingsCount'
          type: 'real'
        }
        {
          name: 'ParticipantsCount'
          type: 'real'
        }
        {
          name: 'MeetingMinutes'
          type: 'real'
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'EventName'
          type: 'string'
        }
        {
          name: 'EventMessage'
          type: 'string'
        }
        {
          name: 'Id'
          type: 'string'
        }
        {
          name: 'UserIdentity'
          type: 'string'
        }
        {
          name: 'Email'
          type: 'string'
        }
        {
          name: 'UserEmail'
          type: 'string'
        }
        {
          name: 'UserName'
          type: 'string'
        }
        {
          name: 'UserType'
          type: 'real'
        }
        {
          name: 'Dept'
          type: 'string'
        }
        {
          name: 'LastClientVersion'
          type: 'string'
        }
        {
          name: 'SrcDvcModelNumber'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zoomclTable.name
output tableId string = zoomclTable.id
output provisioningState string = zoomclTable.properties.provisioningState
