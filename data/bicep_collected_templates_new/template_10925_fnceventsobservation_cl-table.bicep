// Bicep template for Log Analytics custom table: FncEventsObservation_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 55, Deployed columns: 54 (Type column filtered)
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

resource fnceventsobservationclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'FncEventsObservation_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'FncEventsObservation_CL'
      description: 'Custom table FncEventsObservation_CL - imported from JSON schema'
      displayName: 'FncEventsObservation_CL'
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
          name: 'src_ip_enrichments_annotations_tags_s'
          type: 'string'
        }
        {
          name: 'dst_ip_enrichments_internal_b'
          type: 'boolean'
        }
        {
          name: 'dst_ip_enrichments_geo_location_lat_d'
          type: 'real'
        }
        {
          name: 'dst_ip_enrichments_geo_location_lon_d'
          type: 'real'
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
          type: 'int'
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
          type: 'real'
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
          type: 'dateTime'
        }
        {
          name: 'evidence_end_timestamp_t'
          type: 'dateTime'
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
          type: 'boolean'
        }
        {
          name: 'src_ip_enrichments_geo_location_lat_d'
          type: 'real'
        }
        {
          name: 'src_ip_enrichments_geo_location_lon_d'
          type: 'real'
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
          type: 'int'
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
}

output tableName string = fnceventsobservationclTable.name
output tableId string = fnceventsobservationclTable.id
output provisioningState string = fnceventsobservationclTable.properties.provisioningState
