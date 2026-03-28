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
// Data Collection Rule for Corelight_v2_etc_viz_CL
// ============================================================================
// Generated: 2025-09-19 14:20:04
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 22, DCR columns: 19 (Type column always filtered)
// Output stream: Custom-Corelight_v2_etc_viz_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Corelight_v2_etc_viz_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Corelight_v2_etc_viz_CL': {
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
            name: 's2c_viz_pdu1_enc_b'
            type: 'string'
          }
          {
            name: 's2c_viz_enc_frac_d'
            type: 'string'
          }
          {
            name: 's2c_viz_enc_dev_d'
            type: 'string'
          }
          {
            name: 's2c_viz_size_d'
            type: 'string'
          }
          {
            name: 'c2s_viz_clr_ex_s'
            type: 'string'
          }
          {
            name: 'c2s_viz_clr_frac_d'
            type: 'string'
          }
          {
            name: 'c2s_viz_pdu1_enc_b'
            type: 'string'
          }
          {
            name: 'c2s_viz_enc_frac_d'
            type: 'string'
          }
          {
            name: 'c2s_viz_enc_dev_d'
            type: 'string'
          }
          {
            name: 'c2s_viz_size_d'
            type: 'string'
          }
          {
            name: 'viz_stat_s'
            type: 'string'
          }
          {
            name: 'service_s'
            type: 'string'
          }
          {
            name: 'server_p_d'
            type: 'string'
          }
          {
            name: 'server_a_s'
            type: 'string'
          }
          {
            name: 'uid_s'
            type: 'string'
          }
          {
            name: 's2c_viz_clr_frac_d'
            type: 'string'
          }
          {
            name: 's2c_viz_clr_ex_s'
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
          name: 'Sentinel-Corelight_v2_etc_viz_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Corelight_v2_etc_viz_CL']
        destinations: ['Sentinel-Corelight_v2_etc_viz_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), ts_t = todatetime(ts_t), s2c_viz_pdu1_enc_b = tobool(s2c_viz_pdu1_enc_b), s2c_viz_enc_frac_d = toreal(s2c_viz_enc_frac_d), s2c_viz_enc_dev_d = toreal(s2c_viz_enc_dev_d), s2c_viz_size_d = toreal(s2c_viz_size_d), c2s_viz_clr_ex_s = tostring(c2s_viz_clr_ex_s), c2s_viz_clr_frac_d = toreal(c2s_viz_clr_frac_d), c2s_viz_pdu1_enc_b = tobool(c2s_viz_pdu1_enc_b), c2s_viz_enc_frac_d = toreal(c2s_viz_enc_frac_d), c2s_viz_enc_dev_d = toreal(c2s_viz_enc_dev_d), c2s_viz_size_d = toreal(c2s_viz_size_d), viz_stat_s = tostring(viz_stat_s), service_s = tostring(service_s), server_p_d = toreal(server_p_d), server_a_s = tostring(server_a_s), uid_s = tostring(uid_s), s2c_viz_clr_frac_d = toreal(s2c_viz_clr_frac_d), s2c_viz_clr_ex_s = tostring(s2c_viz_clr_ex_s)'
        outputStream: 'Custom-Corelight_v2_etc_viz_CL'
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
