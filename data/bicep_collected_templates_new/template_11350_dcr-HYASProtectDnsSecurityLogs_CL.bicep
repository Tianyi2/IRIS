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
// Data Collection Rule for HYASProtectDnsSecurityLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 57, DCR columns: 55 (Type column always filtered)
// Output stream: Custom-HYASProtectDnsSecurityLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-HYASProtectDnsSecurityLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-HYASProtectDnsSecurityLogs_CL': {
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
            name: 'Nameserver2TLD_s'
            type: 'string'
          }
          {
            name: 'NameserverTLD_s'
            type: 'string'
          }
          {
            name: 'NameserverIP_s'
            type: 'string'
          }
          {
            name: 'NameserverCountryISOCode_s'
            type: 'string'
          }
          {
            name: 'NameserverCountryName_s'
            type: 'string'
          }
          {
            name: 'ARecord_s'
            type: 'string'
          }
          {
            name: 'CName_s'
            type: 'string'
          }
          {
            name: 'CName2TLD_s'
            type: 'string'
          }
          {
            name: 'CNameTLD_s'
            type: 'string'
          }
          {
            name: 'ThreatLevel_s'
            type: 'string'
          }
          {
            name: 'QueryType_s'
            type: 'string'
          }
          {
            name: 'ResponseCode_d'
            type: 'string'
          }
          {
            name: 'ResponseName_s'
            type: 'string'
          }
          {
            name: 'ResponseDescription_s'
            type: 'string'
          }
          {
            name: 'ResolverMode_s'
            type: 'string'
          }
          {
            name: 'ReasonLists_s'
            type: 'string'
          }
          {
            name: 'ReasonType_s'
            type: 'string'
          }
          {
            name: 'DomainAge_d'
            type: 'string'
          }
          {
            name: 'DomainCategory_s'
            type: 'string'
          }
          {
            name: 'DomainCreationDate_t'
            type: 'string'
          }
          {
            name: 'DomainExpiresDate_t'
            type: 'string'
          }
          {
            name: 'DomainUpdatedDate_t'
            type: 'string'
          }
          {
            name: 'NameserverVerdict_s'
            type: 'string'
          }
          {
            name: 'DomainTLD_s'
            type: 'string'
          }
          {
            name: 'Domain2TLD_s'
            type: 'string'
          }
          {
            name: 'ClientIP_s'
            type: 'string'
          }
          {
            name: 'ClientName_s'
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
            name: 'IPVerdict_s'
            type: 'string'
          }
          {
            name: 'TLDVerdict_s'
            type: 'string'
          }
          {
            name: 'Reputation_d'
            type: 'string'
          }
          {
            name: 'DateTime_s'
            type: 'string'
          }
          {
            name: 'Domain_s'
            type: 'string'
          }
          {
            name: 'DeviceName_s'
            type: 'string'
          }
          {
            name: 'FQDNVerdict_s'
            type: 'string'
          }
          {
            name: 'ProcessName_s'
            type: 'string'
          }
          {
            name: 'Verdict_s'
            type: 'string'
          }
          {
            name: 'VerdictSource_s'
            type: 'string'
          }
          {
            name: 'VerdictStatus_s'
            type: 'string'
          }
          {
            name: 'Registrar_s'
            type: 'string'
          }
          {
            name: 'PolicyName_s'
            type: 'string'
          }
          {
            name: 'PolicyID_d'
            type: 'string'
          }
          {
            name: 'RegistrarVerdict_s'
            type: 'string'
          }
          {
            name: 'TTL_d'
            type: 'string'
          }
          {
            name: 'Tags_s'
            type: 'string'
          }
          {
            name: 'LogID_s'
            type: 'string'
          }
          {
            name: 'ClientID_g'
            type: 'string'
          }
          {
            name: 'Nameserver_s'
            type: 'string'
          }
          {
            name: 'DomainVerdict_s'
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
          name: 'Sentinel-HYASProtectDnsSecurityLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-HYASProtectDnsSecurityLogs_CL']
        destinations: ['Sentinel-HYASProtectDnsSecurityLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), Nameserver2TLD_s = tostring(Nameserver2TLD_s), NameserverTLD_s = tostring(NameserverTLD_s), NameserverIP_s = tostring(NameserverIP_s), NameserverCountryISOCode_s = tostring(NameserverCountryISOCode_s), NameserverCountryName_s = tostring(NameserverCountryName_s), ARecord_s = tostring(ARecord_s), CName_s = tostring(CName_s), CName2TLD_s = tostring(CName2TLD_s), CNameTLD_s = tostring(CNameTLD_s), ThreatLevel_s = tostring(ThreatLevel_s), QueryType_s = tostring(QueryType_s), ResponseCode_d = toreal(ResponseCode_d), ResponseName_s = tostring(ResponseName_s), ResponseDescription_s = tostring(ResponseDescription_s), ResolverMode_s = tostring(ResolverMode_s), ReasonLists_s = tostring(ReasonLists_s), ReasonType_s = tostring(ReasonType_s), DomainAge_d = toreal(DomainAge_d), DomainCategory_s = tostring(DomainCategory_s), DomainCreationDate_t = todatetime(DomainCreationDate_t), DomainExpiresDate_t = todatetime(DomainExpiresDate_t), DomainUpdatedDate_t = todatetime(DomainUpdatedDate_t), NameserverVerdict_s = tostring(NameserverVerdict_s), DomainTLD_s = tostring(DomainTLD_s), Domain2TLD_s = tostring(Domain2TLD_s), ClientIP_s = tostring(ClientIP_s), ClientName_s = tostring(ClientName_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), IPVerdict_s = tostring(IPVerdict_s), TLDVerdict_s = tostring(TLDVerdict_s), Reputation_d = toreal(Reputation_d), DateTime_s = tostring(DateTime_s), Domain_s = tostring(Domain_s), DeviceName_s = tostring(DeviceName_s), FQDNVerdict_s = tostring(FQDNVerdict_s), ProcessName_s = tostring(ProcessName_s), Verdict_s = tostring(Verdict_s), VerdictSource_s = tostring(VerdictSource_s), VerdictStatus_s = tostring(VerdictStatus_s), Registrar_s = tostring(Registrar_s), PolicyName_s = tostring(PolicyName_s), PolicyID_d = toreal(PolicyID_d), RegistrarVerdict_s = tostring(RegistrarVerdict_s), TTL_d = toreal(TTL_d), Tags_s = tostring(Tags_s), LogID_s = tostring(LogID_s), ClientID_g = tostring(ClientID_g), Nameserver_s = tostring(Nameserver_s), DomainVerdict_s = tostring(DomainVerdict_s)'
        outputStream: 'Custom-HYASProtectDnsSecurityLogs_CL'
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
