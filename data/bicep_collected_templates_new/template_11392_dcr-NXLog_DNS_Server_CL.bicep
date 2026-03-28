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
// Data Collection Rule for NXLog_DNS_Server_CL
// ============================================================================
// Generated: 2025-09-19 14:20:27
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 69, DCR columns: 66 (Type column always filtered)
// Output stream: Custom-NXLog_DNS_Server_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-NXLog_DNS_Server_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-NXLog_DNS_Server_CL': {
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
            name: 'QNAME_s'
            type: 'string'
          }
          {
            name: 'QTYPE_s'
            type: 'string'
          }
          {
            name: 'XID_s'
            type: 'string'
          }
          {
            name: 'RecursionDepth_s'
            type: 'string'
          }
          {
            name: 'Port_s'
            type: 'string'
          }
          {
            name: 'RecursionScope_s'
            type: 'string'
          }
          {
            name: 'CacheScope_s'
            type: 'string'
          }
          {
            name: 'BufferSize_s'
            type: 'string'
          }
          {
            name: 'PacketData_s'
            type: 'string'
          }
          {
            name: 'AdditionalInfo_s'
            type: 'string'
          }
          {
            name: 'GUID_g'
            type: 'string'
          }
          {
            name: 'EventReceivedTime_t'
            type: 'string'
          }
          {
            name: 'SourceModuleName_s'
            type: 'string'
          }
          {
            name: 'SourceModuleType_s'
            type: 'string'
          }
          {
            name: 'HostIP_s'
            type: 'string'
          }
          {
            name: 'Destination_s'
            type: 'string'
          }
          {
            name: 'RD_s'
            type: 'string'
          }
          {
            name: 'QXID_s'
            type: 'string'
          }
          {
            name: 'PolicyName_s'
            type: 'string'
          }
          {
            name: 'DNSSEC_s'
            type: 'string'
          }
          {
            name: 'RCODE_s'
            type: 'string'
          }
          {
            name: 'Scope_s'
            type: 'string'
          }
          {
            name: 'Zone_s'
            type: 'string'
          }
          {
            name: 'ElapsedTime_s'
            type: 'string'
          }
          {
            name: 'Type_s'
            type: 'string'
          }
          {
            name: 'NAME_s'
            type: 'string'
          }
          {
            name: 'TTL_s'
            type: 'string'
          }
          {
            name: 'RDATA_s'
            type: 'string'
          }
          {
            name: 'ZoneScope_s'
            type: 'string'
          }
          {
            name: 'AD_s'
            type: 'string'
          }
          {
            name: 'VirtualizationID_s'
            type: 'string'
          }
          {
            name: 'AA_s'
            type: 'string'
          }
          {
            name: 'Source_s'
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
            name: 'DNS_LogType_s'
            type: 'string'
          }
          {
            name: 'FilePath_s'
            type: 'string'
          }
          {
            name: 'DNSSeverType_s'
            type: 'string'
          }
          {
            name: 'SourceName_s'
            type: 'string'
          }
          {
            name: 'ProviderGuid_g'
            type: 'string'
          }
          {
            name: 'EventID_d'
            type: 'string'
          }
          {
            name: 'Version_d'
            type: 'string'
          }
          {
            name: 'ChannelID_d'
            type: 'string'
          }
          {
            name: 'OpcodeValue_d'
            type: 'string'
          }
          {
            name: 'TaskValue_d'
            type: 'string'
          }
          {
            name: 'Keywords_s'
            type: 'string'
          }
          {
            name: 'EventTime_t'
            type: 'string'
          }
          {
            name: 'ExecutionProcessID_d'
            type: 'string'
          }
          {
            name: 'ExecutionThreadID_d'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'SeverityValue_d'
            type: 'string'
          }
          {
            name: 'Severity_s'
            type: 'string'
          }
          {
            name: 'Hostname_s'
            type: 'string'
          }
          {
            name: 'Domain_s'
            type: 'string'
          }
          {
            name: 'AccountName_s'
            type: 'string'
          }
          {
            name: 'UserID_s'
            type: 'string'
          }
          {
            name: 'AccountType_s'
            type: 'string'
          }
          {
            name: 'Flags_s'
            type: 'string'
          }
          {
            name: 'TCP_s'
            type: 'string'
          }
          {
            name: 'InterfaceIP_s'
            type: 'string'
          }
          {
            name: 'Reason_s'
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
          name: 'Sentinel-NXLog_DNS_Server_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-NXLog_DNS_Server_CL']
        destinations: ['Sentinel-NXLog_DNS_Server_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), QNAME_s = tostring(QNAME_s), QTYPE_s = tostring(QTYPE_s), XID_s = tostring(XID_s), RecursionDepth_s = tostring(RecursionDepth_s), Port_s = tostring(Port_s), RecursionScope_s = tostring(RecursionScope_s), CacheScope_s = tostring(CacheScope_s), BufferSize_s = tostring(BufferSize_s), PacketData_s = tostring(PacketData_s), AdditionalInfo_s = tostring(AdditionalInfo_s), GUID_g = tostring(GUID_g), EventReceivedTime_t = todatetime(EventReceivedTime_t), SourceModuleName_s = tostring(SourceModuleName_s), SourceModuleType_s = tostring(SourceModuleType_s), HostIP_s = tostring(HostIP_s), Destination_s = tostring(Destination_s), RD_s = tostring(RD_s), QXID_s = tostring(QXID_s), PolicyName_s = tostring(PolicyName_s), DNSSEC_s = tostring(DNSSEC_s), RCODE_s = tostring(RCODE_s), Scope_s = tostring(Scope_s), Zone_s = tostring(Zone_s), ElapsedTime_s = tostring(ElapsedTime_s), Type_s = tostring(Type_s), NAME_s = tostring(NAME_s), TTL_s = tostring(TTL_s), RDATA_s = tostring(RDATA_s), ZoneScope_s = tostring(ZoneScope_s), AD_s = tostring(AD_s), VirtualizationID_s = tostring(VirtualizationID_s), AA_s = tostring(AA_s), Source_s = tostring(Source_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), DNS_LogType_s = tostring(DNS_LogType_s), FilePath_s = tostring(FilePath_s), DNSSeverType_s = tostring(DNSSeverType_s), SourceName_s = tostring(SourceName_s), ProviderGuid_g = tostring(ProviderGuid_g), EventID_d = toreal(EventID_d), Version_d = toreal(Version_d), ChannelID_d = toreal(ChannelID_d), OpcodeValue_d = toreal(OpcodeValue_d), TaskValue_d = toreal(TaskValue_d), Keywords_s = tostring(Keywords_s), EventTime_t = todatetime(EventTime_t), ExecutionProcessID_d = toreal(ExecutionProcessID_d), ExecutionThreadID_d = toreal(ExecutionThreadID_d), EventType_s = tostring(EventType_s), SeverityValue_d = toreal(SeverityValue_d), Severity_s = tostring(Severity_s), Hostname_s = tostring(Hostname_s), Domain_s = tostring(Domain_s), AccountName_s = tostring(AccountName_s), UserID_s = tostring(UserID_s), AccountType_s = tostring(AccountType_s), Flags_s = tostring(Flags_s), TCP_s = tostring(TCP_s), InterfaceIP_s = tostring(InterfaceIP_s), Reason_s = tostring(Reason_s)'
        outputStream: 'Custom-NXLog_DNS_Server_CL'
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
