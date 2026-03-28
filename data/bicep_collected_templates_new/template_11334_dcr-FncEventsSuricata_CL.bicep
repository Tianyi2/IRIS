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
// Data Collection Rule for FncEventsSuricata_CL
// ============================================================================
// Generated: 2025-09-19 14:20:19
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 81, DCR columns: 80 (Type column always filtered)
// Output stream: Custom-FncEventsSuricata_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-FncEventsSuricata_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-FncEventsSuricata_CL': {
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
            name: 'http_hostname_enrichments_ip_enrichments_geo_subdivision_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_geo_location_lon_d'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_geo_location_lat_d'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_internal_b'
            type: 'string'
          }
          {
            name: 'http_hostname_s'
            type: 'string'
          }
          {
            name: 'http_url_s'
            type: 'string'
          }
          {
            name: 'http_protocol_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_geo_city_s'
            type: 'string'
          }
          {
            name: 'http_status_d'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_tags_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_roles_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_owners_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_locations_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_environments_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_annotations_applications_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_asn_asn_org_s'
            type: 'string'
          }
          {
            name: 'geo_distance_d'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_asn_isp_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_asn_asn_d'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_asn_isp_s'
            type: 'string'
          }
          {
            name: 'http_xtf_s'
            type: 'string'
          }
          {
            name: 'http_redirect_s'
            type: 'string'
          }
          {
            name: 'http_http_user_agent_s'
            type: 'string'
          }
          {
            name: 'http_http_refer_s'
            type: 'string'
          }
          {
            name: 'http_http_content_type_s'
            type: 'string'
          }
          {
            name: 'http_http_method_s'
            type: 'string'
          }
          {
            name: 'http_length_d'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_asn_org_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_domain_enrichments_domain_entropy_d'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_annotations_roles_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_annotations_owners_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_annotations_locations_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_annotations_environments_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_annotations_applications_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_geo_country_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_asn_asn_org_s'
            type: 'string'
          }
          {
            name: 'http_hostname_enrichments_ip_enrichments_annotations_tags_s'
            type: 'string'
          }
          {
            name: 'payload_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_asn_org_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_city_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_internal_b'
            type: 'string'
          }
          {
            name: 'alert_severity_d'
            type: 'string'
          }
          {
            name: 'alert_category_s'
            type: 'string'
          }
          {
            name: 'alert_signature_s'
            type: 'string'
          }
          {
            name: 'alert_rev_d'
            type: 'string'
          }
          {
            name: 'alert_signature_id_d'
            type: 'string'
          }
          {
            name: 'proto_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_location_lat_d'
            type: 'string'
          }
          {
            name: 'dest_port_d'
            type: 'string'
          }
          {
            name: 'src_port_d'
            type: 'string'
          }
          {
            name: 'src_ip_s'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'sensor_id_s'
            type: 'string'
          }
          {
            name: 'customer_id_s'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'uuid_g'
            type: 'string'
          }
          {
            name: 'dest_ip_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_asn_asn_d'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_location_lon_d'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_subdivision_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_subdivision_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_country_s'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_location_lon_d'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_geo_location_lat_d'
            type: 'string'
          }
          {
            name: 'dst_ip_enrichments_internal_b'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_tags_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_roles_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_country_s'
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
            name: 'src_ip_enrichments_annotations_applications_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_asn_asn_org_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_asn_isp_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_asn_org_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_asn_asn_d'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_geo_city_s'
            type: 'string'
          }
          {
            name: 'src_ip_enrichments_annotations_locations_s'
            type: 'string'
          }
          {
            name: 'intel_s'
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
          name: 'Sentinel-FncEventsSuricata_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-FncEventsSuricata_CL']
        destinations: ['Sentinel-FncEventsSuricata_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), timestamp_t = todatetime(timestamp_t), http_hostname_enrichments_ip_enrichments_geo_subdivision_s = tostring(http_hostname_enrichments_ip_enrichments_geo_subdivision_s), http_hostname_enrichments_ip_enrichments_geo_location_lon_d = toreal(http_hostname_enrichments_ip_enrichments_geo_location_lon_d), http_hostname_enrichments_ip_enrichments_geo_location_lat_d = toreal(http_hostname_enrichments_ip_enrichments_geo_location_lat_d), http_hostname_enrichments_ip_enrichments_internal_b = tobool(http_hostname_enrichments_ip_enrichments_internal_b), http_hostname_s = tostring(http_hostname_s), http_url_s = tostring(http_url_s), http_protocol_s = tostring(http_protocol_s), http_hostname_enrichments_ip_enrichments_geo_city_s = tostring(http_hostname_enrichments_ip_enrichments_geo_city_s), http_status_d = toint(http_status_d), dst_ip_enrichments_annotations_tags_s = tostring(dst_ip_enrichments_annotations_tags_s), dst_ip_enrichments_annotations_roles_s = tostring(dst_ip_enrichments_annotations_roles_s), dst_ip_enrichments_annotations_owners_s = tostring(dst_ip_enrichments_annotations_owners_s), dst_ip_enrichments_annotations_locations_s = tostring(dst_ip_enrichments_annotations_locations_s), dst_ip_enrichments_annotations_environments_s = tostring(dst_ip_enrichments_annotations_environments_s), dst_ip_enrichments_annotations_applications_s = tostring(dst_ip_enrichments_annotations_applications_s), dst_ip_enrichments_asn_asn_org_s = tostring(dst_ip_enrichments_asn_asn_org_s), geo_distance_d = toreal(geo_distance_d), dst_ip_enrichments_asn_isp_s = tostring(dst_ip_enrichments_asn_isp_s), http_hostname_enrichments_ip_enrichments_asn_asn_d = toint(http_hostname_enrichments_ip_enrichments_asn_asn_d), http_hostname_enrichments_ip_enrichments_asn_isp_s = tostring(http_hostname_enrichments_ip_enrichments_asn_isp_s), http_xtf_s = tostring(http_xtf_s), http_redirect_s = tostring(http_redirect_s), http_http_user_agent_s = tostring(http_http_user_agent_s), http_http_refer_s = tostring(http_http_refer_s), http_http_content_type_s = tostring(http_http_content_type_s), http_http_method_s = tostring(http_http_method_s), http_length_d = toint(http_length_d), http_hostname_enrichments_ip_enrichments_asn_org_s = tostring(http_hostname_enrichments_ip_enrichments_asn_org_s), http_hostname_enrichments_domain_enrichments_domain_entropy_d = toreal(http_hostname_enrichments_domain_enrichments_domain_entropy_d), http_hostname_enrichments_ip_enrichments_annotations_roles_s = tostring(http_hostname_enrichments_ip_enrichments_annotations_roles_s), http_hostname_enrichments_ip_enrichments_annotations_owners_s = tostring(http_hostname_enrichments_ip_enrichments_annotations_owners_s), http_hostname_enrichments_ip_enrichments_annotations_locations_s = tostring(http_hostname_enrichments_ip_enrichments_annotations_locations_s), http_hostname_enrichments_ip_enrichments_annotations_environments_s = tostring(http_hostname_enrichments_ip_enrichments_annotations_environments_s), http_hostname_enrichments_ip_enrichments_annotations_applications_s = tostring(http_hostname_enrichments_ip_enrichments_annotations_applications_s), http_hostname_enrichments_ip_enrichments_geo_country_s = tostring(http_hostname_enrichments_ip_enrichments_geo_country_s), http_hostname_enrichments_ip_enrichments_asn_asn_org_s = tostring(http_hostname_enrichments_ip_enrichments_asn_asn_org_s), http_hostname_enrichments_ip_enrichments_annotations_tags_s = tostring(http_hostname_enrichments_ip_enrichments_annotations_tags_s), payload_s = tostring(payload_s), dst_ip_enrichments_asn_org_s = tostring(dst_ip_enrichments_asn_org_s), dst_ip_enrichments_geo_city_s = tostring(dst_ip_enrichments_geo_city_s), src_ip_enrichments_internal_b = tobool(src_ip_enrichments_internal_b), alert_severity_d = toint(alert_severity_d), alert_category_s = tostring(alert_category_s), alert_signature_s = tostring(alert_signature_s), alert_rev_d = toint(alert_rev_d), alert_signature_id_d = toint(alert_signature_id_d), proto_s = tostring(proto_s), src_ip_enrichments_geo_location_lat_d = toreal(src_ip_enrichments_geo_location_lat_d), dest_port_d = toreal(dest_port_d), src_port_d = toreal(src_port_d), src_ip_s = tostring(src_ip_s), source_s = tostring(source_s), sensor_id_s = tostring(sensor_id_s), customer_id_s = tostring(customer_id_s), event_type_s = tostring(event_type_s), uuid_g = tostring(uuid_g), dest_ip_s = tostring(dest_ip_s), dst_ip_enrichments_asn_asn_d = toint(dst_ip_enrichments_asn_asn_d), src_ip_enrichments_geo_location_lon_d = toreal(src_ip_enrichments_geo_location_lon_d), src_ip_enrichments_geo_subdivision_s = tostring(src_ip_enrichments_geo_subdivision_s), dst_ip_enrichments_geo_subdivision_s = tostring(dst_ip_enrichments_geo_subdivision_s), dst_ip_enrichments_geo_country_s = tostring(dst_ip_enrichments_geo_country_s), dst_ip_enrichments_geo_location_lon_d = toreal(dst_ip_enrichments_geo_location_lon_d), dst_ip_enrichments_geo_location_lat_d = toreal(dst_ip_enrichments_geo_location_lat_d), dst_ip_enrichments_internal_b = tobool(dst_ip_enrichments_internal_b), src_ip_enrichments_annotations_tags_s = tostring(src_ip_enrichments_annotations_tags_s), src_ip_enrichments_annotations_roles_s = tostring(src_ip_enrichments_annotations_roles_s), src_ip_enrichments_geo_country_s = tostring(src_ip_enrichments_geo_country_s), src_ip_enrichments_annotations_owners_s = tostring(src_ip_enrichments_annotations_owners_s), src_ip_enrichments_annotations_environments_s = tostring(src_ip_enrichments_annotations_environments_s), src_ip_enrichments_annotations_applications_s = tostring(src_ip_enrichments_annotations_applications_s), src_ip_enrichments_asn_asn_org_s = tostring(src_ip_enrichments_asn_asn_org_s), src_ip_enrichments_asn_isp_s = tostring(src_ip_enrichments_asn_isp_s), src_ip_enrichments_asn_org_s = tostring(src_ip_enrichments_asn_org_s), src_ip_enrichments_asn_asn_d = toint(src_ip_enrichments_asn_asn_d), src_ip_enrichments_geo_city_s = tostring(src_ip_enrichments_geo_city_s), src_ip_enrichments_annotations_locations_s = tostring(src_ip_enrichments_annotations_locations_s), intel_s = tostring(intel_s)'
        outputStream: 'Custom-FncEventsSuricata_CL'
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
