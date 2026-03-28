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
// Data Collection Rule for CortexXDR_Incidents_CL
// ============================================================================
// Generated: 2025-09-19 14:20:15
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 43, DCR columns: 41 (Type column always filtered)
// Output stream: Custom-CortexXDR_Incidents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CortexXDR_Incidents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CortexXDR_Incidents_CL': {
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
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'alert_count_d'
            type: 'string'
          }
          {
            name: 'low_severity_alert_count_d'
            type: 'string'
          }
          {
            name: 'med_severity_alert_count_d'
            type: 'string'
          }
          {
            name: 'high_severity_alert_count_d'
            type: 'string'
          }
          {
            name: 'user_count_d'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'host_count_d'
            type: 'string'
          }
          {
            name: 'starred_b'
            type: 'string'
          }
          {
            name: 'hosts_s'
            type: 'string'
          }
          {
            name: 'users_s'
            type: 'string'
          }
          {
            name: 'incident_sources_s'
            type: 'string'
          }
          {
            name: 'wildfire_hits_d'
            type: 'string'
          }
          {
            name: 'alerts_grouping_status_s'
            type: 'string'
          }
          {
            name: 'mitre_tactics_ids_and_names_s'
            type: 'string'
          }
          {
            name: 'xdr_url_s'
            type: 'string'
          }
          {
            name: 'modification_time_d'
            type: 'string'
          }
          {
            name: 'creation_time_d'
            type: 'string'
          }
          {
            name: 'incident_id_s'
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
            name: 'aggregated_score_d'
            type: 'string'
          }
          {
            name: 'original_tags_s'
            type: 'string'
          }
          {
            name: 'manual_description_s'
            type: 'string'
          }
          {
            name: 'predicted_score_d'
            type: 'string'
          }
          {
            name: 'tags_s'
            type: 'string'
          }
          {
            name: 'manual_severity_s'
            type: 'string'
          }
          {
            name: 'critical_severity_alert_count_d'
            type: 'string'
          }
          {
            name: 'assigned_user_mail_s'
            type: 'string'
          }
          {
            name: 'assigned_user_pretty_name_s'
            type: 'string'
          }
          {
            name: 'notes_s'
            type: 'string'
          }
          {
            name: 'resolve_comment_s'
            type: 'string'
          }
          {
            name: 'resolved_timestamp_d'
            type: 'string'
          }
          {
            name: 'mitre_techniques_ids_and_names_s'
            type: 'string'
          }
          {
            name: 'alert_categories_s'
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
          name: 'Sentinel-CortexXDR_Incidents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CortexXDR_Incidents_CL']
        destinations: ['Sentinel-CortexXDR_Incidents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), severity_s = tostring(severity_s), description_s = tostring(description_s), alert_count_d = toreal(alert_count_d), low_severity_alert_count_d = toreal(low_severity_alert_count_d), med_severity_alert_count_d = toreal(med_severity_alert_count_d), high_severity_alert_count_d = toreal(high_severity_alert_count_d), user_count_d = toreal(user_count_d), status_s = tostring(status_s), host_count_d = toreal(host_count_d), starred_b = tobool(starred_b), hosts_s = tostring(hosts_s), users_s = tostring(users_s), incident_sources_s = tostring(incident_sources_s), wildfire_hits_d = toreal(wildfire_hits_d), alerts_grouping_status_s = tostring(alerts_grouping_status_s), mitre_tactics_ids_and_names_s = tostring(mitre_tactics_ids_and_names_s), xdr_url_s = tostring(xdr_url_s), modification_time_d = toreal(modification_time_d), creation_time_d = toreal(creation_time_d), incident_id_s = tostring(incident_id_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), aggregated_score_d = toreal(aggregated_score_d), original_tags_s = tostring(original_tags_s), manual_description_s = tostring(manual_description_s), predicted_score_d = toreal(predicted_score_d), tags_s = tostring(tags_s), manual_severity_s = tostring(manual_severity_s), critical_severity_alert_count_d = toreal(critical_severity_alert_count_d), assigned_user_mail_s = tostring(assigned_user_mail_s), assigned_user_pretty_name_s = tostring(assigned_user_pretty_name_s), notes_s = tostring(notes_s), resolve_comment_s = tostring(resolve_comment_s), resolved_timestamp_d = toreal(resolved_timestamp_d), mitre_techniques_ids_and_names_s = tostring(mitre_techniques_ids_and_names_s), alert_categories_s = tostring(alert_categories_s)'
        outputStream: 'Custom-CortexXDR_Incidents_CL'
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
