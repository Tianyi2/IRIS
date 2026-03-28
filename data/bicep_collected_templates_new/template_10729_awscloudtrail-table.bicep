// Bicep template for Log Analytics custom table: AWSCloudTrail
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 51, Deployed columns: 50 (Type column filtered)
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

resource awscloudtrailTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'AWSCloudTrail'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'AWSCloudTrail'
      description: 'Custom table AWSCloudTrail - imported from JSON schema'
      displayName: 'AWSCloudTrail'
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
          name: 'RequestParameters'
          type: 'string'
        }
        {
          name: 'ResponseElements'
          type: 'string'
        }
        {
          name: 'AdditionalEventData'
          type: 'string'
        }
        {
          name: 'AwsRequestId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'AwsRequestId_'
          type: 'string'
        }
        {
          name: 'Resources'
          type: 'string'
        }
        {
          name: 'APIVersion'
          type: 'string'
        }
        {
          name: 'ReadOnly'
          type: 'boolean'
        }
        {
          name: 'RecipientAccountId'
          type: 'string'
        }
        {
          name: 'ServiceEventDetails'
          type: 'string'
        }
        {
          name: 'SharedEventId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'VpcEndpointId'
          type: 'string'
        }
        {
          name: 'ManagementEvent'
          type: 'boolean'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'OperationName'
          type: 'string'
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'TlsVersion'
          type: 'string'
        }
        {
          name: 'CipherSuite'
          type: 'string'
        }
        {
          name: 'ClientProvidedHostHeader'
          type: 'string'
        }
        {
          name: 'IpProtocol'
          type: 'string'
        }
        {
          name: 'SourcePort'
          type: 'string'
        }
        {
          name: 'ErrorMessage'
          type: 'string'
        }
        {
          name: 'DestinationPort'
          type: 'string'
        }
        {
          name: 'ErrorCode'
          type: 'string'
        }
        {
          name: 'SourceIpAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'AwsEventId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'EventVersion'
          type: 'string'
        }
        {
          name: 'EventSource'
          type: 'string'
        }
        {
          name: 'EventTypeName'
          type: 'string'
        }
        {
          name: 'EventName'
          type: 'string'
        }
        {
          name: 'UserIdentityType'
          type: 'string'
        }
        {
          name: 'UserIdentityPrincipalid'
          type: 'string'
        }
        {
          name: 'UserIdentityArn'
          type: 'string'
        }
        {
          name: 'UserIdentityAccountId'
          type: 'string'
        }
        {
          name: 'UserIdentityInvokedBy'
          type: 'string'
        }
        {
          name: 'UserIdentityAccessKeyId'
          type: 'string'
        }
        {
          name: 'UserIdentityUserName'
          type: 'string'
        }
        {
          name: 'SessionMfaAuthenticated'
          type: 'boolean'
        }
        {
          name: 'SessionCreationDate'
          type: 'dateTime'
        }
        {
          name: 'SessionIssuerType'
          type: 'string'
        }
        {
          name: 'SessionIssuerPrincipalId'
          type: 'string'
        }
        {
          name: 'SessionIssuerArn'
          type: 'string'
        }
        {
          name: 'SessionIssuerAccountId'
          type: 'string'
        }
        {
          name: 'SessionIssuerUserName'
          type: 'string'
        }
        {
          name: 'EC2RoleDelivery'
          type: 'string'
        }
        {
          name: 'AWSRegion'
          type: 'string'
        }
        {
          name: 'UserAgent'
          type: 'string'
        }
        {
          name: 'CidrIp'
          type: 'string'
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = awscloudtrailTable.name
output tableId string = awscloudtrailTable.id
output provisioningState string = awscloudtrailTable.properties.provisioningState
