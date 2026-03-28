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
// Data Collection Rule for GCP_MONITORING_CL
// ============================================================================
// Generated: 2025-09-19 14:20:19
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 25, DCR columns: 23 (Type column always filtered)
// Output stream: Custom-GCP_MONITORING_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-GCP_MONITORING_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-GCP_MONITORING_CL': {
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
            name: 'interval_startTime_t'
            type: 'string'
          }
          {
            name: 'valueType_s'
            type: 'string'
          }
          {
            name: 'metricKind_s'
            type: 'string'
          }
          {
            name: 'resource_labels_zone_s'
            type: 'string'
          }
          {
            name: 'resource_labels_instance_id_s'
            type: 'string'
          }
          {
            name: 'resource_labels_project_id_s'
            type: 'string'
          }
          {
            name: 'resource_type_s'
            type: 'string'
          }
          {
            name: 'metric_type_s'
            type: 'string'
          }
          {
            name: 'metric_labels_storage_type_s'
            type: 'string'
          }
          {
            name: 'metric_labels_device_name_s'
            type: 'string'
          }
          {
            name: 'metric_labels_instance_name_s'
            type: 'string'
          }
          {
            name: 'metric_labels_device_type_s'
            type: 'string'
          }
          {
            name: 'value_doubleValue_d'
            type: 'string'
          }
          {
            name: 'metric_labels_loadbalanced_s'
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
            name: 'interval_endTime_t'
            type: 'string'
          }
          {
            name: 'value_int64Value_d'
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
          name: 'Sentinel-GCP_MONITORING_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-GCP_MONITORING_CL']
        destinations: ['Sentinel-GCP_MONITORING_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), interval_startTime_t = todatetime(interval_startTime_t), valueType_s = tostring(valueType_s), metricKind_s = tostring(metricKind_s), resource_labels_zone_s = tostring(resource_labels_zone_s), resource_labels_instance_id_s = tostring(resource_labels_instance_id_s), resource_labels_project_id_s = tostring(resource_labels_project_id_s), resource_type_s = tostring(resource_type_s), metric_type_s = tostring(metric_type_s), metric_labels_storage_type_s = tostring(metric_labels_storage_type_s), metric_labels_device_name_s = tostring(metric_labels_device_name_s), metric_labels_instance_name_s = tostring(metric_labels_instance_name_s), metric_labels_device_type_s = tostring(metric_labels_device_type_s), value_doubleValue_d = toreal(value_doubleValue_d), metric_labels_loadbalanced_s = tostring(metric_labels_loadbalanced_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), interval_endTime_t = todatetime(interval_endTime_t), value_int64Value_d = toreal(value_int64Value_d)'
        outputStream: 'Custom-GCP_MONITORING_CL'
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
