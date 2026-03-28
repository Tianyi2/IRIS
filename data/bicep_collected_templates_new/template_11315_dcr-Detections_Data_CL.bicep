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
// Data Collection Rule for Detections_Data_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 33, DCR columns: 31 (Type column always filtered)
// Output stream: Custom-Detections_Data_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Detections_Data_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Detections_Data_CL': {
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
            name: 'src_ip_s'
            type: 'string'
          }
          {
            name: 'normal_domains_s'
            type: 'string'
          }
          {
            name: 'src_host_s'
            type: 'string'
          }
          {
            name: 'is_targeting_key_asset_s'
            type: 'string'
          }
          {
            name: 'd_detection_details_s'
            type: 'string'
          }
          {
            name: 'detail_s'
            type: 'string'
          }
          {
            name: 'entity_uid_s'
            type: 'string'
          }
          {
            name: 'detection_id_d'
            type: 'string'
          }
          {
            name: 'event_timestamp_t'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
          }
          {
            name: 'url_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'entity_type_s'
            type: 'string'
          }
          {
            name: 'entity_id_d'
            type: 'string'
          }
          {
            name: 'detection_href_s'
            type: 'string'
          }
          {
            name: 'd_type_vname_s'
            type: 'string'
          }
          {
            name: 'detection_type_s'
            type: 'string'
          }
          {
            name: 'triaged_b'
            type: 'string'
          }
          {
            name: 'certainty_d'
            type: 'string'
          }
          {
            name: 'threat_d'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'id_d'
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
            name: 'summary_s'
            type: 'string'
          }
          {
            name: 'grouped_details_s'
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
          name: 'Sentinel-Detections_Data_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Detections_Data_CL']
        destinations: ['Sentinel-Detections_Data_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), src_ip_s = tostring(src_ip_s), normal_domains_s = tostring(normal_domains_s), src_host_s = tostring(src_host_s), is_targeting_key_asset_s = tostring(is_targeting_key_asset_s), d_detection_details_s = tostring(d_detection_details_s), detail_s = tostring(detail_s), entity_uid_s = tostring(entity_uid_s), detection_id_d = toreal(detection_id_d), event_timestamp_t = todatetime(event_timestamp_t), Severity = toint(Severity), url_s = tostring(url_s), type_s = tostring(type_s), entity_type_s = tostring(entity_type_s), entity_id_d = toreal(entity_id_d), detection_href_s = tostring(detection_href_s), d_type_vname_s = tostring(d_type_vname_s), detection_type_s = tostring(detection_type_s), triaged_b = tobool(triaged_b), certainty_d = toreal(certainty_d), threat_d = toreal(threat_d), Category = tostring(Category), id_d = toreal(id_d), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), summary_s = tostring(summary_s), grouped_details_s = tostring(grouped_details_s)'
        outputStream: 'Custom-Detections_Data_CL'
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
