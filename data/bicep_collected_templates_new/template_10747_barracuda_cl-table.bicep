// Bicep template for Log Analytics custom table: Barracuda_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 69, Deployed columns: 66 (Type column filtered)
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

resource barracudaclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Barracuda_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Barracuda_CL'
      description: 'Custom table Barracuda_CL - imported from JSON schema'
      displayName: 'Barracuda_CL'
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
          name: 'DestinationIP_s'
          type: 'string'
        }
        {
          name: 'DestinationPort_d'
          type: 'real'
        }
        {
          name: 'ActionID_s'
          type: 'string'
        }
        {
          name: 'UnitName_s'
          type: 'string'
        }
        {
          name: 'Protocol_s'
          type: 'string'
        }
        {
          name: 'DeviceReceiptTime_s'
          type: 'string'
        }
        {
          name: 'Details_s'
          type: 'string'
        }
        {
          name: 'HostIP_s'
          type: 'string'
        }
        {
          name: 'WAF_Serial_s'
          type: 'string'
        }
        {
          name: 'ServerIP_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'HTTPStatus_s'
          type: 'string'
        }
        {
          name: 'Action_s'
          type: 'string'
        }
        {
          name: 'ClientIP_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'BytesReceived_d'
          type: 'real'
        }
        {
          name: 'ServerPort_d'
          type: 'real'
        }
        {
          name: 'ServicePort_d'
          type: 'real'
        }
        {
          name: 'ProtocolVersion_s'
          type: 'string'
        }
        {
          name: 'Cookie_s'
          type: 'string'
        }
        {
          name: 'Referer_s'
          type: 'string'
        }
        {
          name: 'Method_s'
          type: 'string'
        }
        {
          name: 'BytesSent_d'
          type: 'real'
        }
        {
          name: 'TimeTaken_d'
          type: 'real'
        }
        {
          name: 'SessionID_s'
          type: 'string'
        }
        {
          name: 'ClientPort_d'
          type: 'real'
        }
        {
          name: 'RuleType_s'
          type: 'string'
        }
        {
          name: 'AuthenticatedUser_s'
          type: 'string'
        }
        {
          name: 'UserAgent_s'
          type: 'string'
        }
        {
          name: 'URL_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'CacheHit_d'
          type: 'real'
        }
        {
          name: 'SourcePort_d'
          type: 'real'
        }
        {
          name: 'ProxyIP_s'
          type: 'string'
        }
        {
          name: 'SourceIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'Severity_s'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'ObjectName_s'
          type: 'string'
        }
        {
          name: 'ObjectType_s'
          type: 'string'
        }
        {
          name: 'AdminName_s'
          type: 'string'
        }
        {
          name: 'ClientType_s'
          type: 'string'
        }
        {
          name: 'CommandName_s'
          type: 'string'
        }
        {
          name: 'LoginIP_s'
          type: 'string'
        }
        {
          name: 'LoginPort_d'
          type: 'real'
        }
        {
          name: 'ChangeType_s'
          type: 'string'
        }
        {
          name: 'TransactionID_d'
          type: 'real'
        }
        {
          name: 'NewValue_s'
          type: 'string'
        }
        {
          name: 'OldValue_s'
          type: 'string'
        }
        {
          name: 'Variable_s'
          type: 'string'
        }
        {
          name: 'AdminRole_s'
          type: 'string'
        }
        {
          name: 'EventMessage_s'
          type: 'string'
        }
        {
          name: 'EventID_d'
          type: 'real'
        }
        {
          name: 'host_s'
          type: 'string'
        }
        {
          name: 'ident_s'
          type: 'string'
        }
        {
          name: 'Message'
          type: 'string'
        }
        {
          name: 'cef_version_d'
          type: 'real'
        }
        {
          name: 'Vendor_s'
          type: 'string'
        }
        {
          name: 'Product_s'
          type: 'string'
        }
        {
          name: 'DeviceVersion_s'
          type: 'string'
        }
        {
          name: 'SignatureId_s'
          type: 'string'
        }
        {
          name: 'EventName_s'
          type: 'string'
        }
        {
          name: 'LogType_s'
          type: 'string'
        }
        {
          name: 'ProxyPort_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = barracudaclTable.name
output tableId string = barracudaclTable.id
output provisioningState string = barracudaclTable.properties.provisioningState
