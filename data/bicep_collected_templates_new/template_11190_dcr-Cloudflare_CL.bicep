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
// Data Collection Rule for Cloudflare_CL
// ============================================================================
// Generated: 2025-09-19 14:20:00
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 104, DCR columns: 104 (Type column always filtered)
// Output stream: Custom-Cloudflare_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Cloudflare_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Cloudflare_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'BotScore_d'
            type: 'string'
          }
          {
            name: 'DisconnectTimestamp_t'
            type: 'string'
          }
          {
            name: 'ConnectTimestamp_t'
            type: 'string'
          }
          {
            name: 'ColoCode_s'
            type: 'string'
          }
          {
            name: 'ClientTlsStatus_s'
            type: 'string'
          }
          {
            name: 'ClientTlsProtocol_s'
            type: 'string'
          }
          {
            name: 'ClientTlsClientHelloServerName_s'
            type: 'string'
          }
          {
            name: 'ClientTlsCipher_s'
            type: 'string'
          }
          {
            name: 'ClientTcpRtt_d'
            type: 'string'
          }
          {
            name: 'ClientProto_s'
            type: 'string'
          }
          {
            name: 'ClientPort_d'
            type: 'string'
          }
          {
            name: 'Event_s'
            type: 'string'
          }
          {
            name: 'ClientMatchedIpFirewall_s'
            type: 'string'
          }
          {
            name: 'Application_s'
            type: 'string'
          }
          {
            name: 'ZoneID_d'
            type: 'string'
          }
          {
            name: 'WorkerSubrequestCount_d'
            type: 'string'
          }
          {
            name: 'WorkerSubrequest_b'
            type: 'string'
          }
          {
            name: 'WorkerStatus_s'
            type: 'string'
          }
          {
            name: 'WorkerCPUTime_d'
            type: 'string'
          }
          {
            name: 'WAFRuleMessage_s'
            type: 'string'
          }
          {
            name: 'WAFRuleID_s'
            type: 'string'
          }
          {
            name: 'WAFProfile_s'
            type: 'string'
          }
          {
            name: 'WAFMatchedVar_s'
            type: 'string'
          }
          {
            name: 'ClientBytes_d'
            type: 'string'
          }
          {
            name: 'WAFFlags_s'
            type: 'string'
          }
          {
            name: 'IpFirewall_b'
            type: 'string'
          }
          {
            name: 'OriginPort_d'
            type: 'string'
          }
          {
            name: 'OriginatorRayID_s'
            type: 'string'
          }
          {
            name: 'MatchIndex_d'
            type: 'string'
          }
          {
            name: 'Kind_s'
            type: 'string'
          }
          {
            name: 'Datetime_t'
            type: 'string'
          }
          {
            name: 'ClientRequestScheme_s'
            type: 'string'
          }
          {
            name: 'ClientRequestQuery_s'
            type: 'string'
          }
          {
            name: 'ClientRefererScheme_s'
            type: 'string'
          }
          {
            name: 'ClientRefererQuery_s'
            type: 'string'
          }
          {
            name: 'ClientRefererPath_s'
            type: 'string'
          }
          {
            name: 'ClientRefererHost_s'
            type: 'string'
          }
          {
            name: 'OriginBytes_d'
            type: 'string'
          }
          {
            name: 'ClientASNDescription_s'
            type: 'string'
          }
          {
            name: 'Timestamp_t'
            type: 'string'
          }
          {
            name: 'Status_d'
            type: 'string'
          }
          {
            name: 'ProxyProtocol_s'
            type: 'string'
          }
          {
            name: 'OriginTlsStatus_s'
            type: 'string'
          }
          {
            name: 'OriginTlsProtocol_s'
            type: 'string'
          }
          {
            name: 'OriginTlsMode_s'
            type: 'string'
          }
          {
            name: 'OriginTlsFingerprint_s'
            type: 'string'
          }
          {
            name: 'OriginTlsCipher_s'
            type: 'string'
          }
          {
            name: 'OriginTcpRtt_d'
            type: 'string'
          }
          {
            name: 'OriginProto_s'
            type: 'string'
          }
          {
            name: 'Action_s'
            type: 'string'
          }
          {
            name: 'RuleID_s'
            type: 'string'
          }
          {
            name: 'WAFAction_s'
            type: 'string'
          }
          {
            name: 'RayID_s'
            type: 'string'
          }
          {
            name: 'ClientXRequestedWith_s'
            type: 'string'
          }
          {
            name: 'ClientSrcPort_d'
            type: 'string'
          }
          {
            name: 'ClientSSLProtocol_s'
            type: 'string'
          }
          {
            name: 'ClientSSLCipher_s'
            type: 'string'
          }
          {
            name: 'ClientRequestUserAgent_s'
            type: 'string'
          }
          {
            name: 'ClientRequestURI_s'
            type: 'string'
          }
          {
            name: 'ClientRequestReferer_s'
            type: 'string'
          }
          {
            name: 'ClientRequestProtocol_s'
            type: 'string'
          }
          {
            name: 'ClientRequestPath_s'
            type: 'string'
          }
          {
            name: 'ClientRequestMethod_s'
            type: 'string'
          }
          {
            name: 'EdgeColoCode_s'
            type: 'string'
          }
          {
            name: 'ClientRequestHost_s'
            type: 'string'
          }
          {
            name: 'ClientIPClass_s'
            type: 'string'
          }
          {
            name: 'ClientIP_s'
            type: 'string'
          }
          {
            name: 'ClientDeviceType_s'
            type: 'string'
          }
          {
            name: 'ClientCountry_s'
            type: 'string'
          }
          {
            name: 'ClientASN_d'
            type: 'string'
          }
          {
            name: 'CacheTieredFill_b'
            type: 'string'
          }
          {
            name: 'CacheResponseStatus_d'
            type: 'string'
          }
          {
            name: 'CacheResponseBytes_d'
            type: 'string'
          }
          {
            name: 'CacheCacheStatus_s'
            type: 'string'
          }
          {
            name: 'BotScoreSrc_s'
            type: 'string'
          }
          {
            name: 'ClientRequestBytes_d'
            type: 'string'
          }
          {
            name: 'SecurityLevel_s'
            type: 'string'
          }
          {
            name: 'EdgeColoID_d'
            type: 'string'
          }
          {
            name: 'EdgePathingOp_s'
            type: 'string'
          }
          {
            name: 'ParentRayID_s'
            type: 'string'
          }
          {
            name: 'OriginSSLProtocol_s'
            type: 'string'
          }
          {
            name: 'OriginResponseTime_d'
            type: 'string'
          }
          {
            name: 'OriginResponseStatus_d'
            type: 'string'
          }
          {
            name: 'OriginResponseHTTPLastModified_s'
            type: 'string'
          }
          {
            name: 'OriginResponseHTTPExpires_s'
            type: 'string'
          }
          {
            name: 'OriginResponseBytes_d'
            type: 'string'
          }
          {
            name: 'OriginIP_s'
            type: 'string'
          }
          {
            name: 'FirewallMatchesSources_s'
            type: 'string'
          }
          {
            name: 'FirewallMatchesRuleIDs_s'
            type: 'string'
          }
          {
            name: 'EdgeEndTimestamp_t'
            type: 'string'
          }
          {
            name: 'FirewallMatchesActions_s'
            type: 'string'
          }
          {
            name: 'EdgeServerIP_s'
            type: 'string'
          }
          {
            name: 'EdgeResponseStatus_d'
            type: 'string'
          }
          {
            name: 'EdgeResponseContentType_s'
            type: 'string'
          }
          {
            name: 'EdgeResponseCompressionRatio_d'
            type: 'string'
          }
          {
            name: 'EdgeResponseBytes_d'
            type: 'string'
          }
          {
            name: 'EdgeRequestHost_s'
            type: 'string'
          }
          {
            name: 'EdgeRateLimitID_d'
            type: 'string'
          }
          {
            name: 'EdgeRateLimitAction_s'
            type: 'string'
          }
          {
            name: 'EdgePathingStatus_s'
            type: 'string'
          }
          {
            name: 'EdgePathingSrc_s'
            type: 'string'
          }
          {
            name: 'EdgeStartTimestamp_t'
            type: 'string'
          }
          {
            name: 'Source_s'
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
          name: 'Sentinel-Cloudflare_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Cloudflare_CL']
        destinations: ['Sentinel-Cloudflare_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), BotScore_d = toreal(BotScore_d), DisconnectTimestamp_t = todatetime(DisconnectTimestamp_t), ConnectTimestamp_t = todatetime(ConnectTimestamp_t), ColoCode_s = tostring(ColoCode_s), ClientTlsStatus_s = tostring(ClientTlsStatus_s), ClientTlsProtocol_s = tostring(ClientTlsProtocol_s), ClientTlsClientHelloServerName_s = tostring(ClientTlsClientHelloServerName_s), ClientTlsCipher_s = tostring(ClientTlsCipher_s), ClientTcpRtt_d = toreal(ClientTcpRtt_d), ClientProto_s = tostring(ClientProto_s), ClientPort_d = toreal(ClientPort_d), Event_s = tostring(Event_s), ClientMatchedIpFirewall_s = tostring(ClientMatchedIpFirewall_s), Application_s = tostring(Application_s), ZoneID_d = toreal(ZoneID_d), WorkerSubrequestCount_d = toreal(WorkerSubrequestCount_d), WorkerSubrequest_b = tobool(WorkerSubrequest_b), WorkerStatus_s = tostring(WorkerStatus_s), WorkerCPUTime_d = toreal(WorkerCPUTime_d), WAFRuleMessage_s = tostring(WAFRuleMessage_s), WAFRuleID_s = tostring(WAFRuleID_s), WAFProfile_s = tostring(WAFProfile_s), WAFMatchedVar_s = tostring(WAFMatchedVar_s), ClientBytes_d = toreal(ClientBytes_d), WAFFlags_s = tostring(WAFFlags_s), IpFirewall_b = tobool(IpFirewall_b), OriginPort_d = toreal(OriginPort_d), OriginatorRayID_s = tostring(OriginatorRayID_s), MatchIndex_d = toreal(MatchIndex_d), Kind_s = tostring(Kind_s), Datetime_t = todatetime(Datetime_t), ClientRequestScheme_s = tostring(ClientRequestScheme_s), ClientRequestQuery_s = tostring(ClientRequestQuery_s), ClientRefererScheme_s = tostring(ClientRefererScheme_s), ClientRefererQuery_s = tostring(ClientRefererQuery_s), ClientRefererPath_s = tostring(ClientRefererPath_s), ClientRefererHost_s = tostring(ClientRefererHost_s), OriginBytes_d = toreal(OriginBytes_d), ClientASNDescription_s = tostring(ClientASNDescription_s), Timestamp_t = todatetime(Timestamp_t), Status_d = toreal(Status_d), ProxyProtocol_s = tostring(ProxyProtocol_s), OriginTlsStatus_s = tostring(OriginTlsStatus_s), OriginTlsProtocol_s = tostring(OriginTlsProtocol_s), OriginTlsMode_s = tostring(OriginTlsMode_s), OriginTlsFingerprint_s = tostring(OriginTlsFingerprint_s), OriginTlsCipher_s = tostring(OriginTlsCipher_s), OriginTcpRtt_d = toreal(OriginTcpRtt_d), OriginProto_s = tostring(OriginProto_s), Action_s = tostring(Action_s), RuleID_s = tostring(RuleID_s), WAFAction_s = tostring(WAFAction_s), RayID_s = tostring(RayID_s), ClientXRequestedWith_s = tostring(ClientXRequestedWith_s), ClientSrcPort_d = toreal(ClientSrcPort_d), ClientSSLProtocol_s = tostring(ClientSSLProtocol_s), ClientSSLCipher_s = tostring(ClientSSLCipher_s), ClientRequestUserAgent_s = tostring(ClientRequestUserAgent_s), ClientRequestURI_s = tostring(ClientRequestURI_s), ClientRequestReferer_s = tostring(ClientRequestReferer_s), ClientRequestProtocol_s = tostring(ClientRequestProtocol_s), ClientRequestPath_s = tostring(ClientRequestPath_s), ClientRequestMethod_s = tostring(ClientRequestMethod_s), EdgeColoCode_s = tostring(EdgeColoCode_s), ClientRequestHost_s = tostring(ClientRequestHost_s), ClientIPClass_s = tostring(ClientIPClass_s), ClientIP_s = tostring(ClientIP_s), ClientDeviceType_s = tostring(ClientDeviceType_s), ClientCountry_s = tostring(ClientCountry_s), ClientASN_d = toreal(ClientASN_d), CacheTieredFill_b = tobool(CacheTieredFill_b), CacheResponseStatus_d = toreal(CacheResponseStatus_d), CacheResponseBytes_d = toreal(CacheResponseBytes_d), CacheCacheStatus_s = tostring(CacheCacheStatus_s), BotScoreSrc_s = tostring(BotScoreSrc_s), ClientRequestBytes_d = toreal(ClientRequestBytes_d), SecurityLevel_s = tostring(SecurityLevel_s), EdgeColoID_d = toreal(EdgeColoID_d), EdgePathingOp_s = tostring(EdgePathingOp_s), ParentRayID_s = tostring(ParentRayID_s), OriginSSLProtocol_s = tostring(OriginSSLProtocol_s), OriginResponseTime_d = toreal(OriginResponseTime_d), OriginResponseStatus_d = toreal(OriginResponseStatus_d), OriginResponseHTTPLastModified_s = tostring(OriginResponseHTTPLastModified_s), OriginResponseHTTPExpires_s = tostring(OriginResponseHTTPExpires_s), OriginResponseBytes_d = toreal(OriginResponseBytes_d), OriginIP_s = tostring(OriginIP_s), FirewallMatchesSources_s = tostring(FirewallMatchesSources_s), FirewallMatchesRuleIDs_s = tostring(FirewallMatchesRuleIDs_s), EdgeEndTimestamp_t = todatetime(EdgeEndTimestamp_t), FirewallMatchesActions_s = tostring(FirewallMatchesActions_s), EdgeServerIP_s = tostring(EdgeServerIP_s), EdgeResponseStatus_d = toreal(EdgeResponseStatus_d), EdgeResponseContentType_s = tostring(EdgeResponseContentType_s), EdgeResponseCompressionRatio_d = toreal(EdgeResponseCompressionRatio_d), EdgeResponseBytes_d = toreal(EdgeResponseBytes_d), EdgeRequestHost_s = tostring(EdgeRequestHost_s), EdgeRateLimitID_d = toreal(EdgeRateLimitID_d), EdgeRateLimitAction_s = tostring(EdgeRateLimitAction_s), EdgePathingStatus_s = tostring(EdgePathingStatus_s), EdgePathingSrc_s = tostring(EdgePathingSrc_s), EdgeStartTimestamp_t = todatetime(EdgeStartTimestamp_t), Source_s = tostring(Source_s)'
        outputStream: 'Custom-Cloudflare_CL'
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
