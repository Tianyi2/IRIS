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
// Data Collection Rule for darktrace_model_alerts_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 79, DCR columns: 79 (Type column always filtered)
// Output stream: Custom-darktrace_model_alerts_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-darktrace_model_alerts_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-darktrace_model_alerts_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'dtProduct_s'
            type: 'string'
          }
          {
            name: 'activityId_s'
            type: 'string'
          }
          {
            name: 'identifier_s'
            type: 'string'
          }
          {
            name: 'deviceId_d'
            type: 'string'
          }
          {
            name: 'antigena_b'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'blocked_b'
            type: 'string'
          }
          {
            name: 'mac_s'
            type: 'string'
          }
          {
            name: 'cSensorID_g'
            type: 'string'
          }
          {
            name: 'uuid_s'
            type: 'string'
          }
          {
            name: 'timestamp_t'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'recipients_s'
            type: 'string'
          }
          {
            name: 'link_hosts_s'
            type: 'string'
          }
          {
            name: 'from_s'
            type: 'string'
          }
          {
            name: 'direction_s'
            type: 'string'
          }
          {
            name: 'groupingId_s'
            type: 'string'
          }
          {
            name: 'groupByActivity_b'
            type: 'string'
          }
          {
            name: 'summaryFirstSentence_s'
            type: 'string'
          }
          {
            name: 'newEvent_b'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'typeLabel_s'
            type: 'string'
          }
          {
            name: 'uuid_g'
            type: 'string'
          }
          {
            name: 'last_updated_status_d'
            type: 'string'
          }
          {
            name: 'last_updated_d'
            type: 'string'
          }
          {
            name: 'alert_name_s'
            type: 'string'
          }
          {
            name: 'priority_level_s'
            type: 'string'
          }
          {
            name: 'attachment_sha1s_s'
            type: 'string'
          }
          {
            name: 'priority_d'
            type: 'string'
          }
          {
            name: 'ip_address_s'
            type: 'string'
          }
          {
            name: 'child_id_d'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
          }
          {
            name: 'tags_s'
            type: 'string'
          }
          {
            name: 'sid_d'
            type: 'string'
          }
          {
            name: 'groupPreviousGroups_s'
            type: 'string'
          }
          {
            name: 'currentGroup_s'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'anomaly_score_d'
            type: 'string'
          }
          {
            name: 'actions_s'
            type: 'string'
          }
          {
            name: 'cSensorID_s'
            type: 'string'
          }
          {
            name: 'endTime_s'
            type: 'string'
          }
          {
            name: 'startTime_s'
            type: 'string'
          }
          {
            name: 'mitreTechniques_s'
            type: 'string'
          }
          {
            name: 'destMac_s'
            type: 'string'
          }
          {
            name: 'destHost_s'
            type: 'string'
          }
          {
            name: 'destPort_s'
            type: 'string'
          }
          {
            name: 'destIP_s'
            type: 'string'
          }
          {
            name: 'title_s'
            type: 'string'
          }
          {
            name: 'sourcePort_s'
            type: 'string'
          }
          {
            name: 'sourceHost_s'
            type: 'string'
          }
          {
            name: 'SourceIP'
            type: 'string'
          }
          {
            name: 'threatID_d'
            type: 'string'
          }
          {
            name: 'pid_d'
            type: 'string'
          }
          {
            name: 'modelName_s'
            type: 'string'
          }
          {
            name: 'breachTime_s'
            type: 'string'
          }
          {
            name: 'score_d'
            type: 'string'
          }
          {
            name: 'sourceMac_s'
            type: 'string'
          }
          {
            name: 'longitude_d'
            type: 'string'
          }
          {
            name: 'externalId_g'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'compliance_b'
            type: 'string'
          }
          {
            name: 'cSensor_b'
            type: 'string'
          }
          {
            name: 'Message'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'deviceIP_s'
            type: 'string'
          }
          {
            name: 'time_s'
            type: 'string'
          }
          {
            name: 'hostname_s'
            type: 'string'
          }
          {
            name: 'priority_s'
            type: 'string'
          }
          {
            name: 'friendlyName_s'
            type: 'string'
          }
          {
            name: 'bestDeviceName_s'
            type: 'string'
          }
          {
            name: 'groupCategory_s'
            type: 'string'
          }
          {
            name: 'groupScore_d'
            type: 'string'
          }
          {
            name: 'summary_s'
            type: 'string'
          }
          {
            name: 'triggeredComponents_s'
            type: 'string'
          }
          {
            name: 'breachUrl_s'
            type: 'string'
          }
          {
            name: 'priority_code_d'
            type: 'string'
          }
          {
            name: 'latitude_d'
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
          name: 'Sentinel-darktrace_model_alerts_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-darktrace_model_alerts_CL']
        destinations: ['Sentinel-darktrace_model_alerts_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), dtProduct_s = tostring(dtProduct_s), activityId_s = tostring(activityId_s), identifier_s = tostring(identifier_s), deviceId_d = toreal(deviceId_d), antigena_b = tobool(antigena_b), description_s = tostring(description_s), blocked_b = tobool(blocked_b), mac_s = tostring(mac_s), cSensorID_g = toguid(cSensorID_g), uuid_s = tostring(uuid_s), timestamp_t = tostring(timestamp_t), subject_s = tostring(subject_s), recipients_s = tostring(recipients_s), link_hosts_s = tostring(link_hosts_s), from_s = tostring(from_s), direction_s = tostring(direction_s), groupingId_s = tostring(groupingId_s), groupByActivity_b = tobool(groupByActivity_b), summaryFirstSentence_s = tostring(summaryFirstSentence_s), newEvent_b = tobool(newEvent_b), details_s = tostring(details_s), typeLabel_s = tostring(typeLabel_s), uuid_g = toguid(uuid_g), last_updated_status_d = toreal(last_updated_status_d), last_updated_d = toreal(last_updated_d), alert_name_s = tostring(alert_name_s), priority_level_s = tostring(priority_level_s), attachment_sha1s_s = tostring(attachment_sha1s_s), priority_d = toreal(priority_d), ip_address_s = tostring(ip_address_s), child_id_d = toreal(child_id_d), Severity = toreal(Severity), tags_s = tostring(tags_s), sid_d = toreal(sid_d), groupPreviousGroups_s = tostring(groupPreviousGroups_s), currentGroup_s = tostring(currentGroup_s), name_s = tostring(name_s), anomaly_score_d = toreal(anomaly_score_d), actions_s = tostring(actions_s), cSensorID_s = tostring(cSensorID_s), endTime_s = tostring(endTime_s), startTime_s = tostring(startTime_s), mitreTechniques_s = tostring(mitreTechniques_s), destMac_s = tostring(destMac_s), destHost_s = tostring(destHost_s), destPort_s = tostring(destPort_s), destIP_s = tostring(destIP_s), title_s = tostring(title_s), sourcePort_s = tostring(sourcePort_s), sourceHost_s = tostring(sourceHost_s), SourceIP = tostring(SourceIP), threatID_d = toreal(threatID_d), pid_d = toreal(pid_d), modelName_s = tostring(modelName_s), breachTime_s = tostring(breachTime_s), score_d = toreal(score_d), sourceMac_s = tostring(sourceMac_s), longitude_d = toreal(longitude_d), externalId_g = toguid(externalId_g), url_s = tostring(url_s), Category = tostring(Category), compliance_b = tobool(compliance_b), cSensor_b = tobool(cSensor_b), Message = tostring(Message), status_s = tostring(status_s), deviceIP_s = tostring(deviceIP_s), time_s = tostring(time_s), hostname_s = tostring(hostname_s), priority_s = tostring(priority_s), friendlyName_s = tostring(friendlyName_s), bestDeviceName_s = tostring(bestDeviceName_s), groupCategory_s = tostring(groupCategory_s), groupScore_d = tostring(groupScore_d), summary_s = tostring(summary_s), triggeredComponents_s = tostring(triggeredComponents_s), breachUrl_s = tostring(breachUrl_s), priority_code_d = toreal(priority_code_d), latitude_d = toreal(latitude_d)'
        outputStream: 'Custom-darktrace_model_alerts_CL'
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
