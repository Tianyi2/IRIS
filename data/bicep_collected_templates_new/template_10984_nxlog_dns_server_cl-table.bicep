// Bicep template for Log Analytics custom table: NXLog_DNS_Server_CL
// Generated on 2025-09-19 14:13:57 UTC
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

resource nxlogdnsserverclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'NXLog_DNS_Server_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'NXLog_DNS_Server_CL'
      description: 'Custom table NXLog_DNS_Server_CL - imported from JSON schema'
      displayName: 'NXLog_DNS_Server_CL'
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
          type: 'dateTime'
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
          type: 'real'
        }
        {
          name: 'Version_d'
          type: 'real'
        }
        {
          name: 'ChannelID_d'
          type: 'real'
        }
        {
          name: 'OpcodeValue_d'
          type: 'real'
        }
        {
          name: 'TaskValue_d'
          type: 'real'
        }
        {
          name: 'Keywords_s'
          type: 'string'
        }
        {
          name: 'EventTime_t'
          type: 'dateTime'
        }
        {
          name: 'ExecutionProcessID_d'
          type: 'real'
        }
        {
          name: 'ExecutionThreadID_d'
          type: 'real'
        }
        {
          name: 'EventType_s'
          type: 'string'
        }
        {
          name: 'SeverityValue_d'
          type: 'real'
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
}

output tableName string = nxlogdnsserverclTable.name
output tableId string = nxlogdnsserverclTable.id
output provisioningState string = nxlogdnsserverclTable.properties.provisioningState
