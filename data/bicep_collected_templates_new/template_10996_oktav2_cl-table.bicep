// Bicep template for Log Analytics custom table: OktaV2_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 60, Deployed columns: 59 (Type column filtered)
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

resource oktav2clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'OktaV2_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'OktaV2_CL'
      description: 'Custom table OktaV2_CL - imported from JSON schema'
      displayName: 'OktaV2_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ActingAppName'
          type: 'string'
        }
        {
          name: 'OriginalSeverity'
          type: 'string'
        }
        {
          name: 'OriginalTarget'
          type: 'dynamic'
        }
        {
          name: 'OriginalUserId'
          type: 'string'
        }
        {
          name: 'OriginalUserType'
          type: 'string'
        }
        {
          name: 'Request'
          type: 'dynamic'
        }
        {
          name: 'SecurityContextAsNumber'
          type: 'int'
        }
        {
          name: 'SecurityContextAsOrg'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'SecurityContextDomain'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'SecurityContextIsProxy'
          type: 'boolean'
        }
        {
          name: 'SrcDeviceType'
          type: 'string'
        }
        {
          name: 'SrcDvcId'
          type: 'string'
        }
        {
          name: 'SrcDvcOs'
          type: 'string'
        }
        {
          name: 'SrcGeoCity'
          type: 'string'
        }
        {
          name: 'SrcGeoCountry'
          type: 'string'
        }
        {
          name: 'SrcGeoLatitude'
          type: 'real'
        }
        {
          name: 'SrcGeoLongitude'
          type: 'real'
        }
        {
          name: 'SrcGeoPostalCode'
          type: 'string'
        }
        {
          name: 'SrcGeoRegion'
          type: 'string'
        }
        {
          name: 'SrcIpAddr'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'SrcIsp'
          type: 'string'
        }
        {
          name: 'SrcZone'
          type: 'string'
        }
        {
          name: 'TransactionDetail'
          type: 'dynamic'
        }
        {
          name: 'TransactionId'
          type: 'string'
        }
        {
          name: 'TransactionType'
          type: 'string'
        }
        {
          name: 'Version'
          type: 'string'
        }
        {
          name: 'OriginalOutcomeResult'
          type: 'string'
        }
        {
          name: 'OriginalClientDevice'
          type: 'string'
        }
        {
          name: 'OriginalActorAlternateId'
          type: 'string'
        }
        {
          name: 'LogonMethod'
          type: 'string'
        }
        {
          name: 'ActingAppType'
          type: 'string'
        }
        {
          name: 'ActorDetailEntry'
          type: 'dynamic'
        }
        {
          name: 'ActorDisplayName'
          type: 'string'
        }
        {
          name: 'ActorSessionId'
          type: 'string'
        }
        {
          name: 'ActorUserId'
          type: 'string'
        }
        {
          name: 'ActorUserIdType'
          type: 'string'
        }
        {
          name: 'ActorUsername'
          type: 'string'
        }
        {
          name: 'ActorUsernameType'
          type: 'string'
        }
        {
          name: 'ActorUserType'
          type: 'string'
        }
        {
          name: 'AuthenticationContextAuthenticationProvider'
          type: 'string'
        }
        {
          name: 'AuthenticationContextAuthenticationStep'
          type: 'int'
        }
        {
          name: 'AuthenticationContextCredentialProvider'
          type: 'string'
        }
        {
          name: 'SrcDvcIdType'
          type: 'string'
        }
        {
          name: 'AuthenticationContextInterface'
          type: 'string'
        }
        {
          name: 'AuthenticationContextIssuerType'
          type: 'string'
        }
        {
          name: 'DebugData'
          type: 'dynamic'
        }
        {
          name: 'DomainName'
          type: 'string'
        }
        {
          name: 'DvcAction'
          type: 'string'
        }
        {
          name: 'EventMessage'
          type: 'string'
        }
        {
          name: 'EventOriginalResultDetails'
          type: 'string'
        }
        {
          name: 'EventOriginalType'
          type: 'string'
        }
        {
          name: 'EventOriginalUid'
          type: 'string'
        }
        {
          name: 'EventResult'
          type: 'string'
        }
        {
          name: 'EventSeverity'
          type: 'string'
        }
        {
          name: 'HttpUserAgent'
          type: 'string'
        }
        {
          name: 'LegacyEventType'
          type: 'string'
        }
        {
          name: 'AuthenticationContextIssuerId'
          type: 'string'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
      ]
    }
  }
}

output tableName string = oktav2clTable.name
output tableId string = oktav2clTable.id
output provisioningState string = oktav2clTable.properties.provisioningState
