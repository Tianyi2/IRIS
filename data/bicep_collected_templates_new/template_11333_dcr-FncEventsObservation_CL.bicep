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
// Data Collection Rule for FncEventsObservation_CL
// ============================================================================
// Generated: 2025-09-19 14:20:18
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 55, DCR columns: 54 (Type column always filtered)
// Output stream: Custom-FncEventsObservation_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-FncEventsObservation_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-FncEventsObservation_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'timestamp_t'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_tags_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_internal_b'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_location_lat_d'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_location_lon_d'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_country_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_subdivision_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_city_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_asn_asn_d'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_asn_org_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_asn_isp_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_asn_asn_org_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_applications_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_environments_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_locations_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_owners_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_roles_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_tags_s'
            type: 'string'
          }
          {
            name: 'geo_distance_d'
            type: 'string'
          }
          {
            name: 'sensor_ids_s'
            type: 'string'
          }
          {
            name: 'evidence_iql_s'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'context_s'
            type: 'string'
          }
          {
            name: 'class_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_roles_s'
            type: 'string'
          }
          {
            name: 'intel_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_owners_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_environments_s'
            type: 'string'
          }
          {
            name: 'uuid_g'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'customer_id_s'
            type: 'string'
          }
          {
            name: 'sensor_id_s'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'evidence_start_timestamp_t'
            type: 'string'
          }
          {
            name: 'evidence_end_timestamp_t'
            type: 'string'
          }
          {
            name: 'observation_uuid_g'
            type: 'string'
          }
          {
            name: 'title_s'
            type: 'string'
          }
          {
            name: 'confidence_s'
            type: 'string'
          }
          {
            name: 'src_ip_s'
            type: 'string'
          }
          {
            name: 'dst_ip_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_internal_b'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_location_lat_d'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_location_lon_d'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_country_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_subdivision_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_city_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_asn_asn_d'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_asn_org_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_asn_isp_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_asn_asn_org_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_applications_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_locations_s'
            type: 'string'
          }
          {
            name: 'Category'
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
          name: 'Sentinel-FncEventsObservation_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-FncEventsObservation_CL']
        destinations: ['Sentinel-FncEventsObservation_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), timestamp_t = todatetime(timestamp_t), src_ip_enrichments_annotations_tags_s = tostring(src_ip_enrichments_annotations_tags_s), dst_ip_enrichments_internal_b = tobool(dst_ip_enrichments_internal_b), dst_ip_enrichments_geo_location_lat_d = toreal(dst_ip_enrichments_geo_location_lat_d), dst_ip_enrichments_geo_location_lon_d = toreal(dst_ip_enrichments_geo_location_lon_d), dst_ip_enrichments_geo_country_s = tostring(dst_ip_enrichments_geo_country_s), dst_ip_enrichments_geo_subdivision_s = tostring(dst_ip_enrichments_geo_subdivision_s), dst_ip_enrichments_geo_city_s = tostring(dst_ip_enrichments_geo_city_s), dst_ip_enrichments_asn_asn_d = toint(dst_ip_enrichments_asn_asn_d), dst_ip_enrichments_asn_org_s = tostring(dst_ip_enrichments_asn_org_s), dst_ip_enrichments_asn_isp_s = tostring(dst_ip_enrichments_asn_isp_s), dst_ip_enrichments_asn_asn_org_s = tostring(dst_ip_enrichments_asn_asn_org_s), dst_ip_enrichments_annotations_applications_s = tostring(dst_ip_enrichments_annotations_applications_s), dst_ip_enrichments_annotations_environments_s = tostring(dst_ip_enrichments_annotations_environments_s), dst_ip_enrichments_annotations_locations_s = tostring(dst_ip_enrichments_annotations_locations_s), dst_ip_enrichments_annotations_owners_s = tostring(dst_ip_enrichments_annotations_owners_s), dst_ip_enrichments_annotations_roles_s = tostring(dst_ip_enrichments_annotations_roles_s), dst_ip_enrichments_annotations_tags_s = tostring(dst_ip_enrichments_annotations_tags_s), geo_distance_d = toreal(geo_distance_d), sensor_ids_s = tostring(sensor_ids_s), evidence_iql_s = tostring(evidence_iql_s), description_s = tostring(description_s), context_s = tostring(context_s), class_s = tostring(class_s), src_ip_enrichments_annotations_roles_s = tostring(src_ip_enrichments_annotations_roles_s), intel_s = tostring(intel_s), src_ip_enrichments_annotations_owners_s = tostring(src_ip_enrichments_annotations_owners_s), src_ip_enrichments_annotations_environments_s = tostring(src_ip_enrichments_annotations_environments_s), uuid_g = tostring(uuid_g), event_type_s = tostring(event_type_s), customer_id_s = tostring(customer_id_s), sensor_id_s = tostring(sensor_id_s), source_s = tostring(source_s), evidence_start_timestamp_t = todatetime(evidence_start_timestamp_t), evidence_end_timestamp_t = todatetime(evidence_end_timestamp_t), observation_uuid_g = tostring(observation_uuid_g), title_s = tostring(title_s), confidence_s = tostring(confidence_s), src_ip_s = tostring(src_ip_s), dst_ip_s = tostring(dst_ip_s), src_ip_enrichments_internal_b = tobool(src_ip_enrichments_internal_b), src_ip_enrichments_geo_location_lat_d = toreal(src_ip_enrichments_geo_location_lat_d), src_ip_enrichments_geo_location_lon_d = toreal(src_ip_enrichments_geo_location_lon_d), src_ip_enrichments_geo_country_s = tostring(src_ip_enrichments_geo_country_s), src_ip_enrichments_geo_subdivision_s = tostring(src_ip_enrichments_geo_subdivision_s), src_ip_enrichments_geo_city_s = tostring(src_ip_enrichments_geo_city_s), src_ip_enrichments_asn_asn_d = toint(src_ip_enrichments_asn_asn_d), src_ip_enrichments_asn_org_s = tostring(src_ip_enrichments_asn_org_s), src_ip_enrichments_asn_isp_s = tostring(src_ip_enrichments_asn_isp_s), src_ip_enrichments_asn_asn_org_s = tostring(src_ip_enrichments_asn_asn_org_s), src_ip_enrichments_annotations_applications_s = tostring(src_ip_enrichments_annotations_applications_s), src_ip_enrichments_annotations_locations_s = tostring(src_ip_enrichments_annotations_locations_s), Category = tostring(Category)'
        outputStream: 'Custom-FncEventsObservation_CL'
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
