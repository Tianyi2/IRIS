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
// Data Collection Rule for Illumio_Flow_Events_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 32, DCR columns: 31 (Type column always filtered)
// Output stream: Custom-Illumio_Flow_Events_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Illumio_Flow_Events_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Illumio_Flow_Events_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'code'
            type: 'string'
          }
          {
            name: 'interval_sec'
            type: 'string'
          }
          {
            name: 'dst_labels'
            type: 'dynamic'
          }
          {
            name: 'src_labels'
            type: 'dynamic'
          }
          {
            name: 'network'
            type: 'string'
          }
          {
            name: 'dst_href'
            type: 'string'
          }
          {
            name: 'dst_hostname'
            type: 'string'
          }
          {
            name: 'src_href'
            type: 'string'
          }
          {
            name: 'src_hostname'
            type: 'string'
          }
          {
            name: 'pd'
            type: 'string'
          }
          {
            name: 'pd_qualifier'
            type: 'string'
          }
          {
            name: 'state'
            type: 'string'
          }
          {
            name: 'org_id'
            type: 'string'
          }
          {
            name: 'dir'
            type: 'string'
          }
          {
            name: 'flow_count'
            type: 'string'
          }
          {
            name: 'dst_port'
            type: 'string'
          }
          {
            name: 'proto'
            type: 'string'
          }
          {
            name: 'class'
            type: 'string'
          }
          {
            name: 'dst_ip'
            type: 'string'
          }
          {
            name: 'src_ip'
            type: 'string'
          }
          {
            name: 'un'
            type: 'string'
          }
          {
            name: 'pn'
            type: 'string'
          }
          {
            name: 'tdms'
            type: 'string'
          }
          {
            name: 'ddms'
            type: 'string'
          }
          {
            name: 'dst_tbo'
            type: 'string'
          }
          {
            name: 'dst_tbi'
            type: 'string'
          }
          {
            name: 'dst_dbo'
            type: 'string'
          }
          {
            name: 'dst_dbi'
            type: 'string'
          }
          {
            name: 'pce_fqdn'
            type: 'string'
          }
          {
            name: 'version'
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
          name: 'Sentinel-Illumio_Flow_Events_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Illumio_Flow_Events_CL']
        destinations: ['Sentinel-Illumio_Flow_Events_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), code = toint(code), interval_sec = toint(interval_sec), dst_labels = todynamic(dst_labels), src_labels = todynamic(src_labels), network = tostring(network), dst_href = tostring(dst_href), dst_hostname = tostring(dst_hostname), src_href = tostring(src_href), src_hostname = tostring(src_hostname), pd = toint(pd), pd_qualifier = toint(pd_qualifier), state = tostring(state), org_id = toint(org_id), dir = tostring(dir), flow_count = toint(flow_count), dst_port = toint(dst_port), proto = toint(proto), class = tostring(class), dst_ip = tostring(dst_ip), src_ip = tostring(src_ip), un = tostring(un), pn = tostring(pn), tdms = toint(tdms), ddms = toint(ddms), dst_tbo = toint(dst_tbo), dst_tbi = toint(dst_tbi), dst_dbo = toint(dst_dbo), dst_dbi = toint(dst_dbi), pce_fqdn = tostring(pce_fqdn), version = toint(version)'
        outputStream: 'Custom-Illumio_Flow_Events_CL'
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
