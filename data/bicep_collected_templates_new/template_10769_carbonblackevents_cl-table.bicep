// Bicep template for Log Analytics custom table: CarbonBlackEvents_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 115, Deployed columns: 112 (Type column filtered)
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

resource carbonblackeventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CarbonBlackEvents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CarbonBlackEvents_CL'
      description: 'Custom table CarbonBlackEvents_CL - imported from JSON schema'
      displayName: 'CarbonBlackEvents_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'eventTime_d'
          type: 'dateTime'
        }
        {
          name: 'device_group_s'
          type: 'string'
        }
        {
          name: 'deviceDetails_msmGroupName_s'
          type: 'string'
        }
        {
          name: 'local_port_d'
          type: 'real'
        }
        {
          name: 'parent_hash_s'
          type: 'string'
        }
        {
          name: 'processDetails_parentPid_d'
          type: 'real'
        }
        {
          name: 'device_os_s'
          type: 'string'
        }
        {
          name: 'device_external_ip_s'
          type: 'string'
        }
        {
          name: 'backend_timestamp_s'
          type: 'string'
        }
        {
          name: 'parent_path_s'
          type: 'string'
        }
        {
          name: 'parent_pid_d'
          type: 'real'
        }
        {
          name: 'parent_cmdline_s'
          type: 'string'
        }
        {
          name: 'sensor_action_s'
          type: 'string'
        }
        {
          name: 'longDescription_s'
          type: 'string'
        }
        {
          name: 'process_path_s'
          type: 'string'
        }
        {
          name: 'device_name_s'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'processDetails_parentName_s'
          type: 'string'
        }
        {
          name: 'process_username_s'
          type: 'string'
        }
        {
          name: 'eventTime_s'
          type: 'string'
        }
        {
          name: 'createTime_s'
          type: 'string'
        }
        {
          name: 'netconn_inbound_b'
          type: 'boolean'
        }
        {
          name: 'parent_reputation_s'
          type: 'string'
        }
        {
          name: 'local_ip_s'
          type: 'string'
        }
        {
          name: 'processDetails_targetCommandLine_s'
          type: 'string'
        }
        {
          name: 'event_origin_s'
          type: 'string'
        }
        {
          name: 'childproc_hash_s'
          type: 'string'
        }
        {
          name: 'org_key_s'
          type: 'string'
        }
        {
          name: 'remote_ip_s'
          type: 'string'
        }
        {
          name: 'process_pid_d'
          type: 'real'
        }
        {
          name: 'deviceDetails_deviceIpV4Address_s'
          type: 'string'
        }
        {
          name: 'netconn_domain_s'
          type: 'string'
        }
        {
          name: 'netFlow_peerFqdn_s'
          type: 'string'
        }
        {
          name: 'process_reputation_s'
          type: 'string'
        }
        {
          name: 'eventId_g'
          type: 'string'
        }
        {
          name: 'processDetails_parentCommandLine_s'
          type: 'string'
        }
        {
          name: 'remote_port_d'
          type: 'real'
        }
        {
          name: 'eventType_s'
          type: 'string'
        }
        {
          name: 'schema_d'
          type: 'real'
        }
        {
          name: 'netconn_protocol_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'device_id_s'
          type: 'string'
        }
        {
          name: 'process_hash_s'
          type: 'string'
        }
        {
          name: 'shortDescription_s'
          type: 'string'
        }
        {
          name: 'deviceDetails_deviceId_s'
          type: 'string'
        }
        {
          name: 'process_cmdline_s'
          type: 'string'
        }
        {
          name: 'deviceDetails_deviceType_s'
          type: 'string'
        }
        {
          name: 'device_timestamp_s'
          type: 'string'
        }
        {
          name: 'event_id_g'
          type: 'string'
        }
        {
          name: 'processDetails_commandLine_s'
          type: 'string'
        }
        {
          name: 'process_terminated_b'
          type: 'boolean'
        }
        {
          name: 'event_description_s'
          type: 'string'
        }
        {
          name: 'processDetails_processId_d'
          type: 'real'
        }
        {
          name: 'process_guid_s'
          type: 'string'
        }
        {
          name: 'parent_guid_s'
          type: 'string'
        }
        {
          name: 'childproc_guid_s'
          type: 'string'
        }
        {
          name: 'childproc_name_s'
          type: 'string'
        }
        {
          name: 'scriptload_publisher_s'
          type: 'string'
        }
        {
          name: 'scriptload_effective_reputation_s'
          type: 'string'
        }
        {
          name: 'process_fork_pid_d'
          type: 'real'
        }
        {
          name: 'securityEventCode_g'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'alert_id_g'
          type: 'string'
        }
        {
          name: 'incidentId_g'
          type: 'string'
        }
        {
          name: 'scriptload_content_s'
          type: 'string'
        }
        {
          name: 'scriptload_content_length_d'
          type: 'real'
        }
        {
          name: 'scriptload_hash_s'
          type: 'string'
        }
        {
          name: 'fileless_scriptload_cmdline_s'
          type: 'string'
        }
        {
          name: 'fileless_scriptload_cmdline_length_d'
          type: 'real'
        }
        {
          name: 'scriptload_count_d'
          type: 'real'
        }
        {
          name: 'fileless_scriptload_hash_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'processDetails_targetName_s'
          type: 'string'
        }
        {
          name: 'processDetails_fullUserName_s'
          type: 'string'
        }
        {
          name: 'deviceDetails_deviceIpAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'deviceDetails_deviceName_s'
          type: 'string'
        }
        {
          name: 'targetApp_effectiveReputation_s'
          type: 'string'
        }
        {
          name: 'modload_md5_s'
          type: 'string'
        }
        {
          name: 'childproc_reputation_s'
          type: 'string'
        }
        {
          name: 'scriptload_reputation_s'
          type: 'string'
        }
        {
          name: 'childproc_publisher_s'
          type: 'string'
        }
        {
          name: 'childproc_pid_d'
          type: 'real'
        }
        {
          name: 'childproc_username_s'
          type: 'string'
        }
        {
          name: 'target_cmdline_s'
          type: 'string'
        }
        {
          name: 'regmod_name_s'
          type: 'string'
        }
        {
          name: 'crossproc_api_s'
          type: 'string'
        }
        {
          name: 'process_duration_d'
          type: 'real'
        }
        {
          name: 'modload_count_d'
          type: 'real'
        }
        {
          name: 'modload_sha256_s'
          type: 'string'
        }
        {
          name: 'modload_name_s'
          type: 'string'
        }
        {
          name: 'modload_effective_reputation_s'
          type: 'string'
        }
        {
          name: 'modload_hash_s'
          type: 'string'
        }
        {
          name: 'scriptload_name_s'
          type: 'string'
        }
        {
          name: 'modload_publisher_s'
          type: 'string'
        }
        {
          name: 'netconn_community_id_s'
          type: 'string'
        }
        {
          name: 'filemod_hash_s'
          type: 'string'
        }
        {
          name: 'filemod_name_s'
          type: 'string'
        }
        {
          name: 'process_publisher_s'
          type: 'string'
        }
        {
          name: 'crossproc_reputation_s'
          type: 'string'
        }
        {
          name: 'crossproc_target_b'
          type: 'boolean'
        }
        {
          name: 'crossproc_publisher_s'
          type: 'string'
        }
        {
          name: 'crossproc_action_s'
          type: 'string'
        }
        {
          name: 'crossproc_guid_s'
          type: 'string'
        }
        {
          name: 'crossproc_hash_s'
          type: 'string'
        }
        {
          name: 'crossproc_name_s'
          type: 'string'
        }
        {
          name: 'modload_md5_g'
          type: 'string'
        }
        {
          name: 'netFlow_peerIpAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = carbonblackeventsclTable.name
output tableId string = carbonblackeventsclTable.id
output provisioningState string = carbonblackeventsclTable.properties.provisioningState
