// Bicep template for Log Analytics custom table: HYASProtectDnsSecurityLogs_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 57, Deployed columns: 55 (Type column filtered)
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

resource hyasprotectdnssecuritylogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'HYASProtectDnsSecurityLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'HYASProtectDnsSecurityLogs_CL'
      description: 'Custom table HYASProtectDnsSecurityLogs_CL - imported from JSON schema'
      displayName: 'HYASProtectDnsSecurityLogs_CL'
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
          dataTypeHint: 3
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'DomainCategory_s'
          type: 'string'
        }
        {
          name: 'DomainCreationDate_t'
          type: 'dateTime'
        }
        {
          name: 'DomainExpiresDate_t'
          type: 'dateTime'
        }
        {
          name: 'DomainUpdatedDate_t'
          type: 'dateTime'
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
          dataTypeHint: 3
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'RegistrarVerdict_s'
          type: 'string'
        }
        {
          name: 'TTL_d'
          type: 'real'
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
}

output tableName string = hyasprotectdnssecuritylogsclTable.name
output tableId string = hyasprotectdnssecuritylogsclTable.id
output provisioningState string = hyasprotectdnssecuritylogsclTable.properties.provisioningState
