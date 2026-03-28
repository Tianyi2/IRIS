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
// Data Collection Rule for SophosEP_CL
// ============================================================================
// Generated: 2025-09-19 14:20:32
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 43, DCR columns: 40 (Type column always filtered)
// Output stream: Custom-SophosEP_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SophosEP_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SophosEP_CL': {
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
            name: 'amsi_threat_data_processPath_s'
            type: 'string'
          }
          {
            name: 'amsi_threat_data_processId_s'
            type: 'string'
          }
          {
            name: 'amsi_threat_data_processName_s'
            type: 'string'
          }
          {
            name: 'amsi_threat_data_parentProcessId_s'
            type: 'string'
          }
          {
            name: 'amsi_threat_data_parentProcessPath_s'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'when_t'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'group_s'
            type: 'string'
          }
          {
            name: 'datastream_s'
            type: 'string'
          }
          {
            name: 'Type_s'
            type: 'string'
          }
          {
            name: 'EventVendor_s'
            type: 'string'
          }
          {
            name: 'EventProduct_s'
            type: 'string'
          }
          {
            name: 'TimeGenerated_s'
            type: 'string'
          }
          {
            name: 'location_s'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'origin_s'
            type: 'string'
          }
          {
            name: 'endpoint_id_g'
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
            name: 'amsi_threat_data_processPath_s_s'
            type: 'string'
          }
          {
            name: 'amsi_threat_data_processId_s_s'
            type: 'string'
          }
          {
            name: 'endpoint_type_s'
            type: 'string'
          }
          {
            name: 'amsi_threat_data_processName_s_s'
            type: 'string'
          }
          {
            name: 'amsi_threat_data_parentProcessPath_s_s'
            type: 'string'
          }
          {
            name: 'user_id_s'
            type: 'string'
          }
          {
            name: 'customer_id_g'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'created_at_t'
            type: 'string'
          }
          {
            name: 'source_info_ip_s'
            type: 'string'
          }
          {
            name: 'threat_s'
            type: 'string'
          }
          {
            name: 'amsi_threat_data_parentProcessId_s_s'
            type: 'string'
          }
          {
            name: 'Created'
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
          name: 'Sentinel-SophosEP_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SophosEP_CL']
        destinations: ['Sentinel-SophosEP_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), amsi_threat_data_processPath_s = tostring(amsi_threat_data_processPath_s), amsi_threat_data_processId_s = tostring(amsi_threat_data_processId_s), amsi_threat_data_processName_s = tostring(amsi_threat_data_processName_s), amsi_threat_data_parentProcessId_s = tostring(amsi_threat_data_parentProcessId_s), amsi_threat_data_parentProcessPath_s = tostring(amsi_threat_data_parentProcessPath_s), source_s = tostring(source_s), type_s = tostring(type_s), when_t = todatetime(when_t), name_s = tostring(name_s), id_g = tostring(id_g), group_s = tostring(group_s), datastream_s = tostring(datastream_s), Type_s = tostring(Type_s), EventVendor_s = tostring(EventVendor_s), EventProduct_s = tostring(EventProduct_s), TimeGenerated_s = tostring(TimeGenerated_s), location_s = tostring(location_s), EventEndTime = todatetime(EventEndTime), origin_s = tostring(origin_s), endpoint_id_g = tostring(endpoint_id_g), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), amsi_threat_data_processPath_s_s = tostring(amsi_threat_data_processPath_s_s), amsi_threat_data_processId_s_s = tostring(amsi_threat_data_processId_s_s), endpoint_type_s = tostring(endpoint_type_s), amsi_threat_data_processName_s_s = tostring(amsi_threat_data_processName_s_s), amsi_threat_data_parentProcessPath_s_s = tostring(amsi_threat_data_parentProcessPath_s_s), user_id_s = tostring(user_id_s), customer_id_g = tostring(customer_id_g), severity_s = tostring(severity_s), created_at_t = todatetime(created_at_t), source_info_ip_s = tostring(source_info_ip_s), threat_s = tostring(threat_s), amsi_threat_data_parentProcessId_s_s = tostring(amsi_threat_data_parentProcessId_s_s), Created = todatetime(Created)'
        outputStream: 'Custom-SophosEP_CL'
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
