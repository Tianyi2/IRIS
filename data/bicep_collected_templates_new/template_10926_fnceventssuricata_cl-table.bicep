// Bicep template for Log Analytics custom table: FncEventsSuricata_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 81, Deployed columns: 80 (Type column filtered)
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

resource fnceventssuricataclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'FncEventsSuricata_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'FncEventsSuricata_CL'
      description: 'Custom table FncEventsSuricata_CL - imported from JSON schema'
      displayName: 'FncEventsSuricata_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'http_hostname_enrichments_ip_enrichments_geo_subdivision_s'
          type: 'string'
        }
        {
          name: 'http_hostname_enrichments_ip_enrichments_geo_location_lon_d'
          type: 'real'
        }
        {
          name: 'http_hostname_enrichments_ip_enrichments_geo_location_lat_d'
          type: 'real'
        }
        {
          name: 'http_hostname_enrichments_ip_enrichments_internal_b'
          type: 'boolean'
        }
        {
          name: 'http_hostname_s'
          type: 'string'
        }
        {
          name: 'http_url_s'
          type: 'string'
          dataTypeHint: 0
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
          type: 'int'
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
          type: 'real'
        }
        {
          name: 'dst_ip_enrichments_asn_isp_s'
          type: 'string'
        }
        {
          name: 'http_hostname_enrichments_ip_enrichments_asn_asn_d'
          type: 'int'
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
          type: 'int'
        }
        {
          name: 'http_hostname_enrichments_ip_enrichments_asn_org_s'
          type: 'string'
        }
        {
          name: 'http_hostname_enrichments_domain_enrichments_domain_entropy_d'
          type: 'real'
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
          type: 'boolean'
        }
        {
          name: 'alert_severity_d'
          type: 'int'
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
          type: 'int'
        }
        {
          name: 'alert_signature_id_d'
          type: 'int'
        }
        {
          name: 'proto_s'
          type: 'string'
        }
        {
          name: 'src_ip_enrichments_geo_location_lat_d'
          type: 'real'
        }
        {
          name: 'dest_port_d'
          type: 'real'
        }
        {
          name: 'src_port_d'
          type: 'real'
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
          type: 'int'
        }
        {
          name: 'src_ip_enrichments_geo_location_lon_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'dst_ip_enrichments_geo_location_lat_d'
          type: 'real'
        }
        {
          name: 'dst_ip_enrichments_internal_b'
          type: 'boolean'
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
          type: 'int'
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
}

output tableName string = fnceventssuricataclTable.name
output tableId string = fnceventssuricataclTable.id
output provisioningState string = fnceventssuricataclTable.properties.provisioningState
