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
// Data Collection Rule for ProofpointPOD_maillog_CL
// ============================================================================
// Generated: 2025-09-19 14:20:29
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 31, DCR columns: 31 (Type column always filtered)
// Output stream: Custom-ProofpointPOD_maillog_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ProofpointPOD_maillog_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ProofpointPOD_maillog_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'sm_pri_s'
            type: 'string'
          }
          {
            name: 'sm_delay_s'
            type: 'string'
          }
          {
            name: 'sm_to_s'
            type: 'string'
          }
          {
            name: 'sm_dsn_s'
            type: 'string'
          }
          {
            name: 'sm_stat_s'
            type: 'string'
          }
          {
            name: 'sm_mailer_s'
            type: 'string'
          }
          {
            name: 'event_type_s'
            type: 'string'
          }
          {
            name: 'metadata_origin_data_cid_s'
            type: 'string'
          }
          {
            name: 'metadata_origin_data_agent_s'
            type: 'string'
          }
          {
            name: 'data_s'
            type: 'string'
          }
          {
            name: 'ts_t'
            type: 'string'
          }
          {
            name: 'sm_qid_s'
            type: 'string'
          }
          {
            name: 'sm_class_s'
            type: 'string'
          }
          {
            name: 'sm_from_s'
            type: 'string'
          }
          {
            name: 'sm_proto_s'
            type: 'string'
          }
          {
            name: 'sm_daemon_s'
            type: 'string'
          }
          {
            name: 'sm_relay_s'
            type: 'string'
          }
          {
            name: 'sm_tls_verify_s'
            type: 'string'
          }
          {
            name: 'sm_auth_s'
            type: 'string'
          }
          {
            name: 'sm_sizeBytes_s'
            type: 'string'
          }
          {
            name: 'sm_nrcpts_s'
            type: 'string'
          }
          {
            name: 'sm_msgid_s'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'pps_agent_s'
            type: 'string'
          }
          {
            name: 'pps_cid_s'
            type: 'string'
          }
          {
            name: 'sm_msgid_g'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'sm_xdelay_s'
            type: 'string'
          }
          {
            name: 'sm_ctladdr_s'
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
          name: 'Sentinel-ProofpointPOD_maillog_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ProofpointPOD_maillog_CL']
        destinations: ['Sentinel-ProofpointPOD_maillog_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), sm_pri_s = tostring(sm_pri_s), sm_delay_s = tostring(sm_delay_s), sm_to_s = tostring(sm_to_s), sm_dsn_s = tostring(sm_dsn_s), sm_stat_s = tostring(sm_stat_s), sm_mailer_s = tostring(sm_mailer_s), event_type_s = tostring(event_type_s), metadata_origin_data_cid_s = tostring(metadata_origin_data_cid_s), metadata_origin_data_agent_s = tostring(metadata_origin_data_agent_s), data_s = tostring(data_s), ts_t = todatetime(ts_t), sm_qid_s = tostring(sm_qid_s), sm_class_s = tostring(sm_class_s), sm_from_s = tostring(sm_from_s), sm_proto_s = tostring(sm_proto_s), sm_daemon_s = tostring(sm_daemon_s), sm_relay_s = tostring(sm_relay_s), sm_tls_verify_s = tostring(sm_tls_verify_s), sm_auth_s = tostring(sm_auth_s), sm_sizeBytes_s = tostring(sm_sizeBytes_s), sm_nrcpts_s = tostring(sm_nrcpts_s), sm_msgid_s = tostring(sm_msgid_s), id_s = tostring(id_s), pps_agent_s = tostring(pps_agent_s), pps_cid_s = tostring(pps_cid_s), sm_msgid_g = tostring(sm_msgid_g), EventProduct = tostring(EventProduct), sm_xdelay_s = tostring(sm_xdelay_s), sm_ctladdr_s = tostring(sm_ctladdr_s)'
        outputStream: 'Custom-ProofpointPOD_maillog_CL'
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
