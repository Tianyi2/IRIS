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
// Data Collection Rule for FncEventsDetections_CL
// ============================================================================
// Generated: 2025-09-19 14:20:18
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 29 (Type column always filtered)
// Output stream: Custom-FncEventsDetections_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-FncEventsDetections_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-FncEventsDetections_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'vendor_s'
            type: 'string'
          }
          {
            name: 'primary_dhcp_machost_pairs_s'
            type: 'string'
          }
          {
            name: 'other_pdns_hostnames_s'
            type: 'string'
          }
          {
            name: 'primary_pdns_hostnames_s'
            type: 'string'
          }
          {
            name: 'customer_id_s'
            type: 'string'
          }
          {
            name: 'indicators_s'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'uuid_g'
            type: 'string'
          }
          {
            name: 'updated_t'
            type: 'string'
          }
          {
            name: 'created_t'
            type: 'string'
          }
          {
            name: 'last_seen_t'
            type: 'string'
          }
          {
            name: 'first_seen_t'
            type: 'string'
          }
          {
            name: 'muted_comment_s'
            type: 'string'
          }
          {
            name: 'rule_uuid_g'
            type: 'string'
          }
          {
            name: 'muted_rule_b'
            type: 'string'
          }
          {
            name: 'muted_b'
            type: 'string'
          }
          {
            name: 'sensor_id_s'
            type: 'string'
          }
          {
            name: 'confidence_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'device_ip_s'
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
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'signal_version_s'
            type: 'string'
          }
          {
            name: 'product_s'
            type: 'string'
          }
          {
            name: 'other_dhcp_machost_pairs_s'
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
          name: 'Sentinel-FncEventsDetections_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-FncEventsDetections_CL']
        destinations: ['Sentinel-FncEventsDetections_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), vendor_s = tostring(vendor_s), primary_dhcp_machost_pairs_s = tostring(primary_dhcp_machost_pairs_s), other_pdns_hostnames_s = tostring(other_pdns_hostnames_s), primary_pdns_hostnames_s = tostring(primary_pdns_hostnames_s), customer_id_s = tostring(customer_id_s), indicators_s = tostring(indicators_s), status_s = tostring(status_s), uuid_g = tostring(uuid_g), updated_t = todatetime(updated_t), created_t = todatetime(created_t), last_seen_t = todatetime(last_seen_t), first_seen_t = todatetime(first_seen_t), muted_comment_s = tostring(muted_comment_s), rule_uuid_g = tostring(rule_uuid_g), muted_rule_b = tobool(muted_rule_b), muted_b = tobool(muted_b), sensor_id_s = tostring(sensor_id_s), confidence_s = tostring(confidence_s), severity_s = tostring(severity_s), name_s = tostring(name_s), device_ip_s = tostring(device_ip_s), timestamp_t = todatetime(timestamp_t), subject_s = tostring(subject_s), event_type_s = tostring(event_type_s), signal_version_s = tostring(signal_version_s), product_s = tostring(product_s), other_dhcp_machost_pairs_s = tostring(other_dhcp_machost_pairs_s), Category = tostring(Category)'
        outputStream: 'Custom-FncEventsDetections_CL'
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
