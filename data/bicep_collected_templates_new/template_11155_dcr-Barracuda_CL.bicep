@description('The location of the resources')
param location string = 'Australia East'
@description('The name of the Data Collection Endpoint Id')
param dataCollectionEndpointId string
@description('The Log Analytics Workspace Id used for Sentinel')
param workspaceResourceId string
@description('The Target Sentinel workspace name')
param workspaceName string = 'sentinel-workspace'
@description('The Service Principal Object ID of the Entra App')
param servicePrincipalObjectId string

// ============================================================================
// Data Collection Rule for Barracuda_CL
// ============================================================================
// Generated: 2025-09-19 14:19:55
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 69, DCR columns: 66 (Type column always filtered)
// Output stream: Custom-Barracuda_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Barracuda_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Barracuda_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'DestinationIP_s'
            type: 'string'
          }
          {
            name: 'DestinationPort_d'
            type: 'string'
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
          }
          {
            name: 'BytesReceived_d'
            type: 'string'
          }
          {
            name: 'ServerPort_d'
            type: 'string'
          }
          {
            name: 'ServicePort_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'TimeTaken_d'
            type: 'string'
          }
          {
            name: 'SessionID_s'
            type: 'string'
          }
          {
            name: 'ClientPort_d'
            type: 'string'
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
          }
          {
            name: 'CacheHit_d'
            type: 'string'
          }
          {
            name: 'SourcePort_d'
            type: 'string'
          }
          {
            name: 'ProxyIP_s'
            type: 'string'
          }
          {
            name: 'SourceIP'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'ChangeType_s'
            type: 'string'
          }
          {
            name: 'TransactionID_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-Barracuda_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Barracuda_CL']
        destinations: ['Sentinel-Barracuda_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), DestinationIP_s = tostring(DestinationIP_s), DestinationPort_d = toreal(DestinationPort_d), ActionID_s = tostring(ActionID_s), UnitName_s = tostring(UnitName_s), Protocol_s = tostring(Protocol_s), DeviceReceiptTime_s = tostring(DeviceReceiptTime_s), Details_s = tostring(Details_s), HostIP_s = tostring(HostIP_s), WAF_Serial_s = tostring(WAF_Serial_s), ServerIP_s = tostring(ServerIP_s), HTTPStatus_s = tostring(HTTPStatus_s), Action_s = tostring(Action_s), ClientIP_s = tostring(ClientIP_s), BytesReceived_d = toreal(BytesReceived_d), ServerPort_d = toreal(ServerPort_d), ServicePort_d = toreal(ServicePort_d), ProtocolVersion_s = tostring(ProtocolVersion_s), Cookie_s = tostring(Cookie_s), Referer_s = tostring(Referer_s), Method_s = tostring(Method_s), BytesSent_d = toreal(BytesSent_d), TimeTaken_d = toreal(TimeTaken_d), SessionID_s = tostring(SessionID_s), ClientPort_d = toreal(ClientPort_d), RuleType_s = tostring(RuleType_s), AuthenticatedUser_s = tostring(AuthenticatedUser_s), UserAgent_s = tostring(UserAgent_s), URL_s = tostring(URL_s), CacheHit_d = toreal(CacheHit_d), SourcePort_d = toreal(SourcePort_d), ProxyIP_s = tostring(ProxyIP_s), SourceIP = tostring(SourceIP), Severity_s = tostring(Severity_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), ObjectName_s = tostring(ObjectName_s), ObjectType_s = tostring(ObjectType_s), AdminName_s = tostring(AdminName_s), ClientType_s = tostring(ClientType_s), CommandName_s = tostring(CommandName_s), LoginIP_s = tostring(LoginIP_s), LoginPort_d = toreal(LoginPort_d), ChangeType_s = tostring(ChangeType_s), TransactionID_d = toreal(TransactionID_d), NewValue_s = tostring(NewValue_s), OldValue_s = tostring(OldValue_s), Variable_s = tostring(Variable_s), AdminRole_s = tostring(AdminRole_s), EventMessage_s = tostring(EventMessage_s), EventID_d = toreal(EventID_d), host_s = tostring(host_s), ident_s = tostring(ident_s), Message = tostring(Message), cef_version_d = toreal(cef_version_d), Vendor_s = tostring(Vendor_s), Product_s = tostring(Product_s), DeviceVersion_s = tostring(DeviceVersion_s), SignatureId_s = tostring(SignatureId_s), EventName_s = tostring(EventName_s), LogType_s = tostring(LogType_s), ProxyPort_d = toreal(ProxyPort_d)'
        outputStream: 'Custom-Barracuda_CL'
      }
    ]
  }
}

// Role Assignment to the DCR
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: dataCollectionRule
  name: guid(resourceGroup().id, roleDefinitionResourceId, dataCollectionRule.name)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

output immutableId string = dataCollectionRule.properties.immutableId
output dataCollectionRuleId string = dataCollectionRule.id
output dataCollectionRuleName string = dataCollectionRule.name
