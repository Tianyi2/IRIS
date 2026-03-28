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
// Data Collection Rule for ZimperiumThreatLog_CL
// ============================================================================
// Generated: 2025-09-19 14:20:41
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 72, DCR columns: 70 (Type column always filtered)
// Output stream: Custom-ZimperiumThreatLog_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZimperiumThreatLog_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZimperiumThreatLog_CL': {
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
            name: 'basetation_lac'
            type: 'string'
          }
          {
            name: 'attacker_ip'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'basetation_psc'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'basetation_mnc'
            type: 'string'
          }
          {
            name: 'gateway_mac'
            type: 'string'
          }
          {
            name: 'gateway_ip'
            type: 'string'
          }
          {
            name: 'device_mac'
            type: 'string'
          }
          {
            name: 'device_ip'
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-ZimperiumThreatLog_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZimperiumThreatLog_CL']
        destinations: ['Sentinel-ZimperiumThreatLog_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), basetation_lac = toreal(basetation_lac), attacker_ip = tostring(attacker_ip), attacker_mac = tostring(attacker_mac), attacker_bssid = tostring(attacker_bssid), attackersid = tostring(attackersid), network = tostring(network), network_bssid = tostring(network_bssid), network_interface = tostring(network_interface), jailbreak_reasons = tostring(jailbreak_reasons), process = tostring(process), sideloaded_appeveloper = tostring(sideloaded_appeveloper), sideloaded_app_name = tostring(sideloaded_app_name), sideloaded_app_package = tostring(sideloaded_app_package), event = tostring(event), file_name = tostring(file_name), file_hash = tostring(file_hash), file_path = tostring(file_path), basetation = tostring(basetation), certificate = tostring(certificate), external_ip = tostring(external_ip), network_encryption = tostring(network_encryption), subnet_mask = tostring(subnet_mask), profile_identifier = tostring(profile_identifier), basetation_mcc = toreal(basetation_mcc), profileype = tostring(profileype), actionriggered = tostring(actionriggered), installerource = tostring(installerource), malware_family = tostring(malware_family), package_name = tostring(package_name), malware_list = tostring(malware_list), suspected_url = tostring(suspected_url), profile_name = tostring(profile_name), stagefright_vulnerability_report = tostring(stagefright_vulnerability_report), basetation_cid = toreal(basetation_cid), basetation_psc = toreal(basetation_psc), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), systemtoken = tostring(systemtoken), threatdetail = tostring(threatdetail), account_id = tostring(account_id), severity_name = tostring(severity_name), event_id = tostring(event_id), threat_name = tostring(threat_name), threat_uuid = tostring(threat_uuid), threat_vector_s = tostring(threat_vector_s), devicetime = todatetime(devicetime), device_id = tostring(device_id), device_model = tostring(device_model), device_jailbroken = tobool(device_jailbroken), basetation_mnc = toreal(basetation_mnc), gateway_mac = tostring(gateway_mac), gateway_ip = tostring(gateway_ip), device_mac = tostring(device_mac), device_ip = tostring(device_ip), device_owner_last_name = tostring(device_owner_last_name), basetationtype = tostring(basetationtype), device_owner_first_name = tostring(device_owner_first_name), device_owner_id = tostring(device_owner_id), device_os_version = tostring(device_os_version), device_os_s = tostring(device_os_s), detection_app_version = tostring(detection_app_version), detection_app_instance_id = tostring(detection_app_instance_id), zdevice_id = tostring(zdevice_id), device_owner_email = tostring(device_owner_email), event_timestamp_s = tostring(event_timestamp_s)'
        outputStream: 'Custom-ZimperiumThreatLog_CL'
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
