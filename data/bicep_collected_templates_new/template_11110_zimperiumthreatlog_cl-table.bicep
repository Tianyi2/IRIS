// Bicep template for Log Analytics custom table: ZimperiumThreatLog_CL
// Generated on 2025-09-19 14:14:00 UTC
// Source: JSON schema export
// Original columns: 72, Deployed columns: 70 (Type column filtered)
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

resource zimperiumthreatlogclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZimperiumThreatLog_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZimperiumThreatLog_CL'
      description: 'Custom table ZimperiumThreatLog_CL - imported from JSON schema'
      displayName: 'ZimperiumThreatLog_CL'
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
          name: 'basetation_lac'
          type: 'real'
        }
        {
          name: 'attacker_ip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'attacker_mac'
          type: 'string'
        }
        {
          name: 'attacker_bssid'
          type: 'string'
        }
        {
          name: 'attackersid'
          type: 'string'
        }
        {
          name: 'network'
          type: 'string'
        }
        {
          name: 'network_bssid'
          type: 'string'
        }
        {
          name: 'network_interface'
          type: 'string'
        }
        {
          name: 'jailbreak_reasons'
          type: 'string'
        }
        {
          name: 'process'
          type: 'string'
        }
        {
          name: 'sideloaded_appeveloper'
          type: 'string'
        }
        {
          name: 'sideloaded_app_name'
          type: 'string'
        }
        {
          name: 'sideloaded_app_package'
          type: 'string'
        }
        {
          name: 'event'
          type: 'string'
        }
        {
          name: 'file_name'
          type: 'string'
        }
        {
          name: 'file_hash'
          type: 'string'
        }
        {
          name: 'file_path'
          type: 'string'
        }
        {
          name: 'basetation'
          type: 'string'
        }
        {
          name: 'certificate'
          type: 'string'
        }
        {
          name: 'external_ip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'network_encryption'
          type: 'string'
        }
        {
          name: 'subnet_mask'
          type: 'string'
        }
        {
          name: 'profile_identifier'
          type: 'string'
        }
        {
          name: 'basetation_mcc'
          type: 'real'
        }
        {
          name: 'profileype'
          type: 'string'
        }
        {
          name: 'actionriggered'
          type: 'string'
        }
        {
          name: 'installerource'
          type: 'string'
        }
        {
          name: 'malware_family'
          type: 'string'
        }
        {
          name: 'package_name'
          type: 'string'
        }
        {
          name: 'malware_list'
          type: 'string'
        }
        {
          name: 'suspected_url'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'profile_name'
          type: 'string'
        }
        {
          name: 'stagefright_vulnerability_report'
          type: 'string'
        }
        {
          name: 'basetation_cid'
          type: 'real'
        }
        {
          name: 'basetation_psc'
          type: 'real'
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
          name: 'systemtoken'
          type: 'string'
        }
        {
          name: 'threatdetail'
          type: 'string'
        }
        {
          name: 'account_id'
          type: 'string'
        }
        {
          name: 'severity_name'
          type: 'string'
        }
        {
          name: 'event_id'
          type: 'string'
        }
        {
          name: 'threat_name'
          type: 'string'
        }
        {
          name: 'threat_uuid'
          type: 'string'
        }
        {
          name: 'threat_vector_s'
          type: 'string'
        }
        {
          name: 'devicetime'
          type: 'dateTime'
        }
        {
          name: 'device_id'
          type: 'string'
        }
        {
          name: 'device_model'
          type: 'string'
        }
        {
          name: 'device_jailbroken'
          type: 'boolean'
        }
        {
          name: 'basetation_mnc'
          type: 'real'
        }
        {
          name: 'gateway_mac'
          type: 'string'
        }
        {
          name: 'gateway_ip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'device_mac'
          type: 'string'
        }
        {
          name: 'device_ip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'device_owner_last_name'
          type: 'string'
        }
        {
          name: 'basetationtype'
          type: 'string'
        }
        {
          name: 'device_owner_first_name'
          type: 'string'
        }
        {
          name: 'device_owner_id'
          type: 'string'
        }
        {
          name: 'device_os_version'
          type: 'string'
        }
        {
          name: 'device_os_s'
          type: 'string'
        }
        {
          name: 'detection_app_version'
          type: 'string'
        }
        {
          name: 'detection_app_instance_id'
          type: 'string'
        }
        {
          name: 'zdevice_id'
          type: 'string'
        }
        {
          name: 'device_owner_email'
          type: 'string'
        }
        {
          name: 'event_timestamp_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zimperiumthreatlogclTable.name
output tableId string = zimperiumthreatlogclTable.id
output provisioningState string = zimperiumthreatlogclTable.properties.provisioningState
