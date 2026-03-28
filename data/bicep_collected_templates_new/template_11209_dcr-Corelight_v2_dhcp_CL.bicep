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
// Data Collection Rule for Corelight_v2_dhcp_CL
// ============================================================================
// Generated: 2025-09-19 14:20:03
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 19, DCR columns: 16 (Type column always filtered)
// Output stream: Custom-Corelight_v2_dhcp_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_dhcp_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_dhcp_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'ts_t'
            type: 'string'
          }
          {
            name: 'uids_s'
            type: 'string'
          }
          {
            name: 'client_addr_s'
            type: 'string'
          }
          {
            name: 'server_addr_s'
            type: 'string'
          }
          {
            name: 'mac_s'
            type: 'string'
          }
          {
            name: 'host_name_s'
            type: 'string'
          }
          {
            name: 'client_fqdn_s'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'requested_addr_s'
            type: 'string'
          }
          {
            name: 'assigned_addr_s'
            type: 'string'
          }
          {
            name: 'lease_time_d'
            type: 'string'
          }
          {
            name: 'client_message_s'
            type: 'string'
          }
          {
            name: 'server_message_s'
            type: 'string'
          }
          {
            name: 'msg_types_s'
            type: 'string'
          }
          {
            name: 'duration_d'
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
          name: 'Sentinel-Corelight_v2_dhcp_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_dhcp_CL']
        destinations: ['Sentinel-Corelight_v2_dhcp_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), uids_s = tostring(uids_s), client_addr_s = tostring(client_addr_s), server_addr_s = tostring(server_addr_s), mac_s = tostring(mac_s), host_name_s = tostring(host_name_s), client_fqdn_s = tostring(client_fqdn_s), domain_s = tostring(domain_s), requested_addr_s = tostring(requested_addr_s), assigned_addr_s = tostring(assigned_addr_s), lease_time_d = toreal(lease_time_d), client_message_s = tostring(client_message_s), server_message_s = tostring(server_message_s), msg_types_s = tostring(msg_types_s), duration_d = toreal(duration_d)'
        outputStream: 'Custom-Corelight_v2_dhcp_CL'
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
