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
// Data Collection Rule for CarbonBlackEvents_CL
// ============================================================================
// Generated: 2025-09-19 14:19:58
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 115, DCR columns: 112 (Type column always filtered)
// Output stream: Custom-CarbonBlackEvents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CarbonBlackEvents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CarbonBlackEvents_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'eventTime_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'parent_hash_s'
            type: 'string'
          }
          {
            name: 'processDetails_parentPid_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'eventType_s'
            type: 'string'
          }
          {
            name: 'schema_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'event_description_s'
            type: 'string'
          }
          {
            name: 'processDetails_processId_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'securityEventCode_g'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'scriptload_count_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'modload_count_d'
            type: 'string'
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
            type: 'string'
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
          }
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-CarbonBlackEvents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CarbonBlackEvents_CL']
        destinations: ['Sentinel-CarbonBlackEvents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), eventTime_d = todatetime(eventTime_d), device_group_s = tostring(device_group_s), deviceDetails_msmGroupName_s = tostring(deviceDetails_msmGroupName_s), local_port_d = toreal(local_port_d), parent_hash_s = tostring(parent_hash_s), processDetails_parentPid_d = toreal(processDetails_parentPid_d), device_os_s = tostring(device_os_s), device_external_ip_s = tostring(device_external_ip_s), backend_timestamp_s = tostring(backend_timestamp_s), parent_path_s = tostring(parent_path_s), parent_pid_d = toreal(parent_pid_d), parent_cmdline_s = tostring(parent_cmdline_s), sensor_action_s = tostring(sensor_action_s), longDescription_s = tostring(longDescription_s), process_path_s = tostring(process_path_s), device_name_s = tostring(device_name_s), type_s = tostring(type_s), processDetails_parentName_s = tostring(processDetails_parentName_s), process_username_s = tostring(process_username_s), eventTime_s = tostring(eventTime_s), createTime_s = tostring(createTime_s), netconn_inbound_b = tobool(netconn_inbound_b), parent_reputation_s = tostring(parent_reputation_s), local_ip_s = tostring(local_ip_s), processDetails_targetCommandLine_s = tostring(processDetails_targetCommandLine_s), event_origin_s = tostring(event_origin_s), childproc_hash_s = tostring(childproc_hash_s), org_key_s = tostring(org_key_s), remote_ip_s = tostring(remote_ip_s), process_pid_d = toreal(process_pid_d), deviceDetails_deviceIpV4Address_s = tostring(deviceDetails_deviceIpV4Address_s), netconn_domain_s = tostring(netconn_domain_s), netFlow_peerFqdn_s = tostring(netFlow_peerFqdn_s), process_reputation_s = tostring(process_reputation_s), eventId_g = tostring(eventId_g), processDetails_parentCommandLine_s = tostring(processDetails_parentCommandLine_s), remote_port_d = toreal(remote_port_d), eventType_s = tostring(eventType_s), schema_d = toreal(schema_d), netconn_protocol_s = tostring(netconn_protocol_s), action_s = tostring(action_s), device_id_s = tostring(device_id_s), process_hash_s = tostring(process_hash_s), shortDescription_s = tostring(shortDescription_s), deviceDetails_deviceId_s = tostring(deviceDetails_deviceId_s), process_cmdline_s = tostring(process_cmdline_s), deviceDetails_deviceType_s = tostring(deviceDetails_deviceType_s), device_timestamp_s = tostring(device_timestamp_s), event_id_g = tostring(event_id_g), processDetails_commandLine_s = tostring(processDetails_commandLine_s), process_terminated_b = tobool(process_terminated_b), event_description_s = tostring(event_description_s), processDetails_processId_d = toreal(processDetails_processId_d), process_guid_s = tostring(process_guid_s), parent_guid_s = tostring(parent_guid_s), childproc_guid_s = tostring(childproc_guid_s), childproc_name_s = tostring(childproc_name_s), scriptload_publisher_s = tostring(scriptload_publisher_s), scriptload_effective_reputation_s = tostring(scriptload_effective_reputation_s), process_fork_pid_d = toreal(process_fork_pid_d), securityEventCode_g = tostring(securityEventCode_g), alert_id_g = tostring(alert_id_g), incidentId_g = tostring(incidentId_g), scriptload_content_s = tostring(scriptload_content_s), scriptload_content_length_d = toreal(scriptload_content_length_d), scriptload_hash_s = tostring(scriptload_hash_s), fileless_scriptload_cmdline_s = tostring(fileless_scriptload_cmdline_s), fileless_scriptload_cmdline_length_d = toreal(fileless_scriptload_cmdline_length_d), scriptload_count_d = toreal(scriptload_count_d), fileless_scriptload_hash_s = tostring(fileless_scriptload_hash_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), TenantId = toguid(TenantId), processDetails_targetName_s = tostring(processDetails_targetName_s), processDetails_fullUserName_s = tostring(processDetails_fullUserName_s), deviceDetails_deviceIpAddress_s = tostring(deviceDetails_deviceIpAddress_s), deviceDetails_deviceName_s = tostring(deviceDetails_deviceName_s), targetApp_effectiveReputation_s = tostring(targetApp_effectiveReputation_s), modload_md5_s = tostring(modload_md5_s), childproc_reputation_s = tostring(childproc_reputation_s), scriptload_reputation_s = tostring(scriptload_reputation_s), childproc_publisher_s = tostring(childproc_publisher_s), childproc_pid_d = toreal(childproc_pid_d), childproc_username_s = tostring(childproc_username_s), target_cmdline_s = tostring(target_cmdline_s), regmod_name_s = tostring(regmod_name_s), crossproc_api_s = tostring(crossproc_api_s), process_duration_d = toreal(process_duration_d), modload_count_d = toreal(modload_count_d), modload_sha256_s = tostring(modload_sha256_s), modload_name_s = tostring(modload_name_s), modload_effective_reputation_s = tostring(modload_effective_reputation_s), modload_hash_s = tostring(modload_hash_s), scriptload_name_s = tostring(scriptload_name_s), modload_publisher_s = tostring(modload_publisher_s), netconn_community_id_s = tostring(netconn_community_id_s), filemod_hash_s = tostring(filemod_hash_s), filemod_name_s = tostring(filemod_name_s), process_publisher_s = tostring(process_publisher_s), crossproc_reputation_s = tostring(crossproc_reputation_s), crossproc_target_b = tobool(crossproc_target_b), crossproc_publisher_s = tostring(crossproc_publisher_s), crossproc_action_s = tostring(crossproc_action_s), crossproc_guid_s = tostring(crossproc_guid_s), crossproc_hash_s = tostring(crossproc_hash_s), crossproc_name_s = tostring(crossproc_name_s), modload_md5_g = tostring(modload_md5_g), netFlow_peerIpAddress_s = tostring(netFlow_peerIpAddress_s)'
        outputStream: 'Custom-CarbonBlackEvents_CL'
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
