// Bicep template for Log Analytics custom table: prancer_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 109, Deployed columns: 107 (Type column filtered)
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

resource prancerclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'prancer_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'prancer_CL'
      description: 'Custom table prancer_CL - imported from JSON schema'
      displayName: 'prancer_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
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
          dataTypeHint: 0
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
          dataTypeHint: 0
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
          type: 'real'
        }
        {
          name: 'data_alert_cvss_cweid_s'
          type: 'string'
        }
        {
          name: 'data_data_resourceID_s'
          type: 'string'
          dataTypeHint: 2
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
          type: 'boolean'
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
}

output tableName string = prancerclTable.name
output tableId string = prancerclTable.id
output provisioningState string = prancerclTable.properties.provisioningState
