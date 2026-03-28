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
// Data Collection Rule for HackerViewLog_Azure_1_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 34, DCR columns: 33 (Type column always filtered)
// Output stream: Custom-HackerViewLog_Azure_1_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-HackerViewLog_Azure_1_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-HackerViewLog_Azure_1_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'progress_status_s'
            type: 'string'
          }
          {
            name: 'potential_impact_s'
            type: 'string'
          }
          {
            name: 'potential_attack_type_s'
            type: 'string'
          }
          {
            name: 'meta_ticket_id_s'
            type: 'string'
          }
          {
            name: 'meta_technologies_s'
            type: 'string'
          }
          {
            name: 'meta_resolved_ip_s'
            type: 'string'
          }
          {
            name: 'meta_last_seen_s'
            type: 'string'
          }
          {
            name: 'meta_ip_type_s'
            type: 'string'
          }
          {
            name: 'meta_ip_s'
            type: 'string'
          }
          {
            name: 'meta_hosts_s'
            type: 'string'
          }
          {
            name: 'meta_host_type_s'
            type: 'string'
          }
          {
            name: 'meta_host_s'
            type: 'string'
          }
          {
            name: 'meta_first_seen_s'
            type: 'string'
          }
          {
            name: 'meta_environments_s'
            type: 'string'
          }
          {
            name: 'meta_domain_s'
            type: 'string'
          }
          {
            name: 'meta_discovery_source_s'
            type: 'string'
          }
          {
            name: 'meta_business_unit_s'
            type: 'string'
          }
          {
            name: 'meta_brand_s'
            type: 'string'
          }
          {
            name: 'meta_asset_type_s'
            type: 'string'
          }
          {
            name: 'meta_asset_s'
            type: 'string'
          }
          {
            name: 'issue_type_s'
            type: 'string'
          }
          {
            name: 'issue_name_s'
            type: 'string'
          }
          {
            name: 'issue_category_s'
            type: 'string'
          }
          {
            name: 'hackerview_link_s'
            type: 'string'
          }
          {
            name: 'fixing_effort_s'
            type: 'string'
          }
          {
            name: 'detail_s'
            type: 'string'
          }
          {
            name: 'cwe_s'
            type: 'string'
          }
          {
            name: 'assigned_to_s'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'status_s'
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
          name: 'Sentinel-HackerViewLog_Azure_1_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-HackerViewLog_Azure_1_CL']
        destinations: ['Sentinel-HackerViewLog_Azure_1_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), MG = tostring(MG), progress_status_s = tostring(progress_status_s), potential_impact_s = tostring(potential_impact_s), potential_attack_type_s = tostring(potential_attack_type_s), meta_ticket_id_s = tostring(meta_ticket_id_s), meta_technologies_s = tostring(meta_technologies_s), meta_resolved_ip_s = tostring(meta_resolved_ip_s), meta_last_seen_s = tostring(meta_last_seen_s), meta_ip_type_s = tostring(meta_ip_type_s), meta_ip_s = tostring(meta_ip_s), meta_hosts_s = tostring(meta_hosts_s), meta_host_type_s = tostring(meta_host_type_s), meta_host_s = tostring(meta_host_s), meta_first_seen_s = tostring(meta_first_seen_s), meta_environments_s = tostring(meta_environments_s), meta_domain_s = tostring(meta_domain_s), meta_discovery_source_s = tostring(meta_discovery_source_s), meta_business_unit_s = tostring(meta_business_unit_s), meta_brand_s = tostring(meta_brand_s), meta_asset_type_s = tostring(meta_asset_type_s), meta_asset_s = tostring(meta_asset_s), issue_type_s = tostring(issue_type_s), issue_name_s = tostring(issue_name_s), issue_category_s = tostring(issue_category_s), hackerview_link_s = tostring(hackerview_link_s), fixing_effort_s = tostring(fixing_effort_s), detail_s = tostring(detail_s), cwe_s = tostring(cwe_s), assigned_to_s = tostring(assigned_to_s), ManagementGroupName = tostring(ManagementGroupName), severity_s = tostring(severity_s), status_s = tostring(status_s)'
        outputStream: 'Custom-HackerViewLog_Azure_1_CL'
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
