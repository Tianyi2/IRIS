// Bicep template for Log Analytics custom table: Cloudflare_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 104, Deployed columns: 104 (Type column filtered)
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

resource cloudflareclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Cloudflare_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Cloudflare_CL'
      description: 'Custom table Cloudflare_CL - imported from JSON schema'
      displayName: 'Cloudflare_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'BotScore_d'
          type: 'real'
        }
        {
          name: 'DisconnectTimestamp_t'
          type: 'dateTime'
        }
        {
          name: 'ConnectTimestamp_t'
          type: 'dateTime'
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
          type: 'real'
        }
        {
          name: 'ClientProto_s'
          type: 'string'
        }
        {
          name: 'ClientPort_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'WorkerSubrequestCount_d'
          type: 'real'
        }
        {
          name: 'WorkerSubrequest_b'
          type: 'boolean'
        }
        {
          name: 'WorkerStatus_s'
          type: 'string'
        }
        {
          name: 'WorkerCPUTime_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'WAFFlags_s'
          type: 'string'
        }
        {
          name: 'IpFirewall_b'
          type: 'boolean'
        }
        {
          name: 'OriginPort_d'
          type: 'real'
        }
        {
          name: 'OriginatorRayID_s'
          type: 'string'
        }
        {
          name: 'MatchIndex_d'
          type: 'real'
        }
        {
          name: 'Kind_s'
          type: 'string'
        }
        {
          name: 'Datetime_t'
          type: 'dateTime'
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
          type: 'real'
        }
        {
          name: 'ClientASNDescription_s'
          type: 'string'
        }
        {
          name: 'Timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'Status_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          dataTypeHint: 0
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
          dataTypeHint: 3
        }
        {
          name: 'ClientIP_s'
          type: 'string'
          dataTypeHint: 3
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
          type: 'real'
        }
        {
          name: 'CacheTieredFill_b'
          type: 'boolean'
        }
        {
          name: 'CacheResponseStatus_d'
          type: 'real'
        }
        {
          name: 'CacheResponseBytes_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'SecurityLevel_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'EdgeColoID_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'OriginResponseStatus_d'
          type: 'real'
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
          type: 'real'
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
          type: 'dateTime'
        }
        {
          name: 'FirewallMatchesActions_s'
          type: 'string'
        }
        {
          name: 'EdgeServerIP_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'EdgeResponseStatus_d'
          type: 'real'
        }
        {
          name: 'EdgeResponseContentType_s'
          type: 'string'
        }
        {
          name: 'EdgeResponseCompressionRatio_d'
          type: 'real'
        }
        {
          name: 'EdgeResponseBytes_d'
          type: 'real'
        }
        {
          name: 'EdgeRequestHost_s'
          type: 'string'
        }
        {
          name: 'EdgeRateLimitID_d'
          type: 'real'
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
          type: 'dateTime'
        }
        {
          name: 'Source_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = cloudflareclTable.name
output tableId string = cloudflareclTable.id
output provisioningState string = cloudflareclTable.properties.provisioningState
