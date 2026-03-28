// Bicep template for Log Analytics custom table: ASimUserManagementLogs_CL
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 87, Deployed columns: 87 (Type column filtered)
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

resource asimusermanagementlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ASimUserManagementLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ASimUserManagementLogs_CL'
      description: 'Custom table ASimUserManagementLogs_CL - imported from JSON schema'
      displayName: 'ASimUserManagementLogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'AdditionalFields'
          type: 'dynamic'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'GroupOriginalType'
          type: 'string'
        }
        {
          name: 'GroupType'
          type: 'string'
        }
        {
          name: 'GroupNameType'
          type: 'string'
        }
        {
          name: 'GroupName'
          type: 'string'
        }
        {
          name: 'GroupIdType'
          type: 'string'
        }
        {
          name: 'GroupId'
          type: 'string'
        }
        {
          name: 'TargetOriginalUserType'
          type: 'string'
        }
        {
          name: 'TargetUserType'
          type: 'string'
        }
        {
          name: 'TargetUsernameType'
          type: 'string'
        }
        {
          name: 'TargetUsername'
          type: 'string'
        }
        {
          name: 'TargetScope'
          type: 'string'
        }
        {
          name: 'TargetScopeId'
          type: 'string'
        }
        {
          name: 'TargetUserIdType'
          type: 'string'
        }
        {
          name: 'TargetUserId'
          type: 'string'
        }
        {
          name: 'ActorSessionId'
          type: 'string'
        }
        {
          name: 'ActorOriginalUserType'
          type: 'string'
        }
        {
          name: 'SrcPortNumber'
          type: 'int'
        }
        {
          name: 'SrcHostname'
          type: 'string'
        }
        {
          name: 'SrcDomain'
          type: 'string'
        }
        {
          name: 'SrcDomainType'
          type: 'string'
        }
        {
          name: 'HttpUserAgent'
          type: 'string'
        }
        {
          name: 'ActingAppType'
          type: 'string'
        }
        {
          name: 'ActingAppName'
          type: 'string'
        }
        {
          name: 'ActingAppId'
          type: 'string'
        }
        {
          name: 'SrcOriginalRiskLevel'
          type: 'string'
        }
        {
          name: 'SrcRiskLevel'
          type: 'int'
        }
        {
          name: 'SrcGeoCity'
          type: 'string'
        }
        {
          name: 'SrcGeoRegion'
          type: 'string'
        }
        {
          name: 'ActorUserType'
          type: 'string'
        }
        {
          name: 'SrcGeoLongitude'
          type: 'real'
        }
        {
          name: 'SrcGeoCountry'
          type: 'string'
        }
        {
          name: 'SrcDeviceType'
          type: 'string'
        }
        {
          name: 'SrcDvcScope'
          type: 'string'
        }
        {
          name: 'SrcDvcScopeId'
          type: 'string'
        }
        {
          name: 'SrcDvcIdType'
          type: 'string'
        }
        {
          name: 'SrcDvcId'
          type: 'string'
        }
        {
          name: 'SrcDescription'
          type: 'string'
        }
        {
          name: 'SrcFQDN'
          type: 'string'
        }
        {
          name: 'SrcGeoLatitude'
          type: 'real'
        }
        {
          name: 'ActorUsernameType'
          type: 'string'
        }
        {
          name: 'ActorUsername'
          type: 'string'
        }
        {
          name: 'ActorScope'
          type: 'string'
        }
        {
          name: 'EventSchemaVersion'
          type: 'string'
        }
        {
          name: 'EventVendor'
          type: 'string'
        }
        {
          name: 'EventProductVersion'
          type: 'string'
        }
        {
          name: 'EventProduct'
          type: 'string'
        }
        {
          name: 'EventOriginalSeverity'
          type: 'string'
        }
        {
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'EventOriginalResultDetails'
          type: 'string'
        }
        {
          name: 'EventOriginalSubType'
          type: 'string'
        }
        {
          name: 'EventOwner'
          type: 'string'
        }
        {
          name: 'EventOriginalType'
          type: 'string'
        }
        {
          name: 'EventResultDetails'
          type: 'string'
        }
        {
          name: 'EventResult'
          type: 'string'
        }
        {
          name: 'EventSubType'
          type: 'string'
        }
        {
          name: 'EventType'
          type: 'string'
        }
        {
          name: 'EventEndTime'
          type: 'dateTime'
        }
        {
          name: 'EventStartTime'
          type: 'dateTime'
        }
        {
          name: 'EventCount'
          type: 'int'
        }
        {
          name: 'EventMessage'
          type: 'string'
        }
        {
          name: 'EventOriginalUid'
          type: 'string'
        }
        {
          name: 'PreviousPropertyValue'
          type: 'string'
        }
        {
          name: 'EventReportUrl'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'DvcHostname'
          type: 'string'
        }
        {
          name: 'ActorScopeId'
          type: 'string'
        }
        {
          name: 'ActorUserIdType'
          type: 'string'
        }
        {
          name: 'ActorUserId'
          type: 'string'
        }
        {
          name: 'DvcScope'
          type: 'string'
        }
        {
          name: 'DvcScopeId'
          type: 'string'
        }
        {
          name: 'DvcInterface'
          type: 'string'
        }
        {
          name: 'DvcOriginalAction'
          type: 'string'
        }
        {
          name: 'DvcAction'
          type: 'string'
        }
        {
          name: 'DvcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'DvcOsVersion'
          type: 'string'
        }
        {
          name: 'DvcZone'
          type: 'string'
        }
        {
          name: 'DvcMacAddr'
          type: 'string'
        }
        {
          name: 'DvcIdType'
          type: 'string'
        }
        {
          name: 'DvcId'
          type: 'string'
        }
        {
          name: 'DvcDescription'
          type: 'string'
        }
        {
          name: 'DvcFQDN'
          type: 'string'
        }
        {
          name: 'DvcDomainType'
          type: 'string'
        }
        {
          name: 'DvcDomain'
          type: 'string'
        }
        {
          name: 'DvcOs'
          type: 'string'
        }
        {
          name: 'NewPropertyValue'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = asimusermanagementlogsclTable.name
output tableId string = asimusermanagementlogsclTable.id
output provisioningState string = asimusermanagementlogsclTable.properties.provisioningState
