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
// Data Collection Rule for prancer_CL
// ============================================================================
// Generated: 2025-09-19 14:20:28
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 109, DCR columns: 107 (Type column always filtered)
// Output stream: Custom-prancer_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-prancer_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-prancer_CL': {
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
            name: 'data_alert_attack_s'
            type: 'string'
          }
          {
            name: 'data_alert_name_s'
            type: 'string'
          }
          {
            name: 'data_alert_alert_s'
            type: 'string'
          }
          {
            name: 'data_data_tags_OWASP_2017_A03_s'
            type: 'string'
          }
          {
            name: 'data_data_param_s'
            type: 'string'
          }
          {
            name: 'data_data_tags_OWASP_2021_A08_s'
            type: 'string'
          }
          {
            name: 'data_data_other_s'
            type: 'string'
          }
          {
            name: 'data_data_tags_OWASP_2021_A01_s'
            type: 'string'
          }
          {
            name: 'data_data_tags_OWASP_2017_A05_s'
            type: 'string'
          }
          {
            name: 'data_data_evidence_s'
            type: 'string'
          }
          {
            name: 'data_alert_messageId_s'
            type: 'string'
          }
          {
            name: 'data_data_cweid_s'
            type: 'string'
          }
          {
            name: 'data_data_sourceid_s'
            type: 'string'
          }
          {
            name: 'data_data_wascid_s'
            type: 'string'
          }
          {
            name: 'data_data_configId_s'
            type: 'string'
          }
          {
            name: 'data_data_solution_s'
            type: 'string'
          }
          {
            name: 'data_data_url_s'
            type: 'string'
          }
          {
            name: 'data_data_tags_OWASP_2021_A05_s'
            type: 'string'
          }
          {
            name: 'data_data_tags_OWASP_2017_A06_s'
            type: 'string'
          }
          {
            name: 'data_data_resultId_s'
            type: 'string'
          }
          {
            name: 'data_data_reference_s'
            type: 'string'
          }
          {
            name: 'data_data_risk_s'
            type: 'string'
          }
          {
            name: 'data_data_pluginId_s'
            type: 'string'
          }
          {
            name: 'data_alert_description_s'
            type: 'string'
          }
          {
            name: 'data_alert_risk_s'
            type: 'string'
          }
          {
            name: 'data_alert_evidence_s'
            type: 'string'
          }
          {
            name: 'data_alert_tags_OWASP_2021_A01_s'
            type: 'string'
          }
          {
            name: 'data_alert_tags_OWASP_2017_A05_s'
            type: 'string'
          }
          {
            name: 'data_data_tags_s'
            type: 'string'
          }
          {
            name: 'data_data_rtt_s'
            type: 'string'
          }
          {
            name: 'data_data_type_s'
            type: 'string'
          }
          {
            name: 'data_data_timestamp_s'
            type: 'string'
          }
          {
            name: 'data_data_responseBody_s'
            type: 'string'
          }
          {
            name: 'data_data_responseHeader_s'
            type: 'string'
          }
          {
            name: 'data_data_requestHeader_s'
            type: 'string'
          }
          {
            name: 'data_data_requestBody_s'
            type: 'string'
          }
          {
            name: 'data_data_cookieParams_s'
            type: 'string'
          }
          {
            name: 'data_data_id_s'
            type: 'string'
          }
          {
            name: 'data_alert_cweid_s'
            type: 'string'
          }
          {
            name: 'data_alert_pluginId_s'
            type: 'string'
          }
          {
            name: 'data_alert_sourceid_s'
            type: 'string'
          }
          {
            name: 'data_alert_wascid_s'
            type: 'string'
          }
          {
            name: 'data_alert_configId_s'
            type: 'string'
          }
          {
            name: 'data_alert_param_s'
            type: 'string'
          }
          {
            name: 'data_alert_solution_s'
            type: 'string'
          }
          {
            name: 'data_alert_url_s'
            type: 'string'
          }
          {
            name: 'data_alert_tags_OWASP_2021_A08_s'
            type: 'string'
          }
          {
            name: 'data_alert_resultId_s'
            type: 'string'
          }
          {
            name: 'data_alert_reference_s'
            type: 'string'
          }
          {
            name: 'data_data_description_s'
            type: 'string'
          }
          {
            name: 'data_data_messageId_s'
            type: 'string'
          }
          {
            name: 'data_data_attack_s'
            type: 'string'
          }
          {
            name: 'data_data_name_s'
            type: 'string'
          }
          {
            name: 'data_alert_cvss_cvss_score_d'
            type: 'string'
          }
          {
            name: 'data_alert_cvss_cweid_s'
            type: 'string'
          }
          {
            name: 'data_data_resourceID_s'
            type: 'string'
          }
          {
            name: 'data_data_authenticationMethod_s'
            type: 'string'
          }
          {
            name: 'data_data_compliance_s'
            type: 'string'
          }
          {
            name: 'data_data_target_s'
            type: 'string'
          }
          {
            name: 'data_data_applicationType_s'
            type: 'string'
          }
          {
            name: 'data_data_riskProfit_s'
            type: 'string'
          }
          {
            name: 'data_data_riskLevel_s'
            type: 'string'
          }
          {
            name: 'data_data_applicationName_s'
            type: 'string'
          }
          {
            name: 'data_data_cloudType_s'
            type: 'string'
          }
          {
            name: 'data_alert_references_s'
            type: 'string'
          }
          {
            name: 'scanType_s'
            type: 'string'
          }
          {
            name: 'data_alert_cvss_mitreId_s'
            type: 'string'
          }
          {
            name: 'data_alert_cvss_name_s'
            type: 'string'
          }
          {
            name: 'companyName_s'
            type: 'string'
          }
          {
            name: 'collection_s'
            type: 'string'
          }
          {
            name: 'data_alert_mitreId_s'
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
            name: 'data_alert_cvss_message_s'
            type: 'string'
          }
          {
            name: 'data_alert_other_s'
            type: 'string'
          }
          {
            name: 'data_alert_cvss_severity_s'
            type: 'string'
          }
          {
            name: 'data_data_result_s'
            type: 'string'
          }
          {
            name: 'data_data_alert_s'
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
            name: 'cat_s'
            type: 'string'
          }
          {
            name: 'act_s'
            type: 'string'
          }
          {
            name: 'deviceVersion_s'
            type: 'string'
          }
          {
            name: 'deviceProduct_s'
            type: 'string'
          }
          {
            name: 'deviceVendor_s'
            type: 'string'
          }
          {
            name: 'CEF_s'
            type: 'string'
          }
          {
            name: 'data_alert_tags_s'
            type: 'string'
          }
          {
            name: 'data_data_snapshotId_s'
            type: 'string'
          }
          {
            name: 'data_data_title_s'
            type: 'string'
          }
          {
            name: 'data_data_status_s'
            type: 'string'
          }
          {
            name: 'data_data_severity_s'
            type: 'string'
          }
          {
            name: 'data_data_rule_s'
            type: 'string'
          }
          {
            name: 'data_data_masterTestId_s'
            type: 'string'
          }
          {
            name: 'data_data_masterSnapshotId_s'
            type: 'string'
          }
          {
            name: 'data_data_result_id_s'
            type: 'string'
          }
          {
            name: 'data_data_autoRemediate_b'
            type: 'string'
          }
          {
            name: 'data_data_snapshots_s'
            type: 'string'
          }
          {
            name: 'data_data_remediation_function_s'
            type: 'string'
          }
          {
            name: 'data_data_remediation_description_s'
            type: 'string'
          }
          {
            name: 'data_data_message_s'
            type: 'string'
          }
          {
            name: 'data_data_eval_s'
            type: 'string'
          }
          {
            name: 'data_alert_tags_OWASP_2017_A03_s'
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
          name: 'Sentinel-prancer_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-prancer_CL']
        destinations: ['Sentinel-prancer_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), data_alert_attack_s = tostring(data_alert_attack_s), data_alert_name_s = tostring(data_alert_name_s), data_alert_alert_s = tostring(data_alert_alert_s), data_data_tags_OWASP_2017_A03_s = tostring(data_data_tags_OWASP_2017_A03_s), data_data_param_s = tostring(data_data_param_s), data_data_tags_OWASP_2021_A08_s = tostring(data_data_tags_OWASP_2021_A08_s), data_data_other_s = tostring(data_data_other_s), data_data_tags_OWASP_2021_A01_s = tostring(data_data_tags_OWASP_2021_A01_s), data_data_tags_OWASP_2017_A05_s = tostring(data_data_tags_OWASP_2017_A05_s), data_data_evidence_s = tostring(data_data_evidence_s), data_alert_messageId_s = tostring(data_alert_messageId_s), data_data_cweid_s = tostring(data_data_cweid_s), data_data_sourceid_s = tostring(data_data_sourceid_s), data_data_wascid_s = tostring(data_data_wascid_s), data_data_configId_s = tostring(data_data_configId_s), data_data_solution_s = tostring(data_data_solution_s), data_data_url_s = tostring(data_data_url_s), data_data_tags_OWASP_2021_A05_s = tostring(data_data_tags_OWASP_2021_A05_s), data_data_tags_OWASP_2017_A06_s = tostring(data_data_tags_OWASP_2017_A06_s), data_data_resultId_s = tostring(data_data_resultId_s), data_data_reference_s = tostring(data_data_reference_s), data_data_risk_s = tostring(data_data_risk_s), data_data_pluginId_s = tostring(data_data_pluginId_s), data_alert_description_s = tostring(data_alert_description_s), data_alert_risk_s = tostring(data_alert_risk_s), data_alert_evidence_s = tostring(data_alert_evidence_s), data_alert_tags_OWASP_2021_A01_s = tostring(data_alert_tags_OWASP_2021_A01_s), data_alert_tags_OWASP_2017_A05_s = tostring(data_alert_tags_OWASP_2017_A05_s), data_data_tags_s = tostring(data_data_tags_s), data_data_rtt_s = tostring(data_data_rtt_s), data_data_type_s = tostring(data_data_type_s), data_data_timestamp_s = tostring(data_data_timestamp_s), data_data_responseBody_s = tostring(data_data_responseBody_s), data_data_responseHeader_s = tostring(data_data_responseHeader_s), data_data_requestHeader_s = tostring(data_data_requestHeader_s), data_data_requestBody_s = tostring(data_data_requestBody_s), data_data_cookieParams_s = tostring(data_data_cookieParams_s), data_data_id_s = tostring(data_data_id_s), data_alert_cweid_s = tostring(data_alert_cweid_s), data_alert_pluginId_s = tostring(data_alert_pluginId_s), data_alert_sourceid_s = tostring(data_alert_sourceid_s), data_alert_wascid_s = tostring(data_alert_wascid_s), data_alert_configId_s = tostring(data_alert_configId_s), data_alert_param_s = tostring(data_alert_param_s), data_alert_solution_s = tostring(data_alert_solution_s), data_alert_url_s = tostring(data_alert_url_s), data_alert_tags_OWASP_2021_A08_s = tostring(data_alert_tags_OWASP_2021_A08_s), data_alert_resultId_s = tostring(data_alert_resultId_s), data_alert_reference_s = tostring(data_alert_reference_s), data_data_description_s = tostring(data_data_description_s), data_data_messageId_s = tostring(data_data_messageId_s), data_data_attack_s = tostring(data_data_attack_s), data_data_name_s = tostring(data_data_name_s), data_alert_cvss_cvss_score_d = toreal(data_alert_cvss_cvss_score_d), data_alert_cvss_cweid_s = tostring(data_alert_cvss_cweid_s), data_data_resourceID_s = tostring(data_data_resourceID_s), data_data_authenticationMethod_s = tostring(data_data_authenticationMethod_s), data_data_compliance_s = tostring(data_data_compliance_s), data_data_target_s = tostring(data_data_target_s), data_data_applicationType_s = tostring(data_data_applicationType_s), data_data_riskProfit_s = tostring(data_data_riskProfit_s), data_data_riskLevel_s = tostring(data_data_riskLevel_s), data_data_applicationName_s = tostring(data_data_applicationName_s), data_data_cloudType_s = tostring(data_data_cloudType_s), data_alert_references_s = tostring(data_alert_references_s), scanType_s = tostring(scanType_s), data_alert_cvss_mitreId_s = tostring(data_alert_cvss_mitreId_s), data_alert_cvss_name_s = tostring(data_alert_cvss_name_s), companyName_s = tostring(companyName_s), collection_s = tostring(collection_s), data_alert_mitreId_s = tostring(data_alert_mitreId_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), data_alert_cvss_message_s = tostring(data_alert_cvss_message_s), data_alert_other_s = tostring(data_alert_other_s), data_alert_cvss_severity_s = tostring(data_alert_cvss_severity_s), data_data_result_s = tostring(data_data_result_s), data_data_alert_s = tostring(data_data_alert_s), severity_s = tostring(severity_s), name_s = tostring(name_s), cat_s = tostring(cat_s), act_s = tostring(act_s), deviceVersion_s = tostring(deviceVersion_s), deviceProduct_s = tostring(deviceProduct_s), deviceVendor_s = tostring(deviceVendor_s), CEF_s = tostring(CEF_s), data_alert_tags_s = tostring(data_alert_tags_s), data_data_snapshotId_s = tostring(data_data_snapshotId_s), data_data_title_s = tostring(data_data_title_s), data_data_status_s = tostring(data_data_status_s), data_data_severity_s = tostring(data_data_severity_s), data_data_rule_s = tostring(data_data_rule_s), data_data_masterTestId_s = tostring(data_data_masterTestId_s), data_data_masterSnapshotId_s = tostring(data_data_masterSnapshotId_s), data_data_result_id_s = tostring(data_data_result_id_s), data_data_autoRemediate_b = tobool(data_data_autoRemediate_b), data_data_snapshots_s = tostring(data_data_snapshots_s), data_data_remediation_function_s = tostring(data_data_remediation_function_s), data_data_remediation_description_s = tostring(data_data_remediation_description_s), data_data_message_s = tostring(data_data_message_s), data_data_eval_s = tostring(data_data_eval_s), data_alert_tags_OWASP_2017_A03_s = tostring(data_alert_tags_OWASP_2017_A03_s)'
        outputStream: 'Custom-prancer_CL'
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
