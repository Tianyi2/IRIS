// Bicep template for Log Analytics custom table: InfoSecAnalytics_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 53, Deployed columns: 49 (Type column filtered)
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

resource infosecanalyticsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'InfoSecAnalytics_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'InfoSecAnalytics_CL'
      description: 'Custom table InfoSecAnalytics_CL - imported from JSON schema'
      displayName: 'InfoSecAnalytics_CL'
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
          name: 'uri_fileextension_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'basic_constraints_subject_type_s'
          type: 'string'
        }
        {
          name: 'certificateserialnumber_s'
          type: 'string'
        }
        {
          name: 'certificatesha256fingerprint_s'
          type: 'string'
        }
        {
          name: 'severity_type_s'
          type: 'string'
        }
        {
          name: 'truststatus_s'
          type: 'string'
        }
        {
          name: 'agentlastip_s'
          type: 'string'
        }
        {
          name: 'resultsuri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'severity_ISG_PostQuantum_Security_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'certificatenotbefore_t'
          type: 'string'
        }
        {
          name: 'rank_s'
          type: 'string'
        }
        {
          name: 'agentid_s'
          type: 'string'
        }
        {
          name: 'standard_name_s'
          type: 'string'
        }
        {
          name: 'crypto_scanid_d'
          type: 'real'
        }
        {
          name: 'uri_filename_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'uri_filepath_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'agenthostname_s'
          type: 'string'
        }
        {
          name: 'starttime_t'
          type: 'string'
        }
        {
          name: 'object_fingerprint_s'
          type: 'string'
        }
        {
          name: 'endtime_t'
          type: 'string'
        }
        {
          name: 'standard_cse_classification_s'
          type: 'string'
        }
        {
          name: 'severity_description_s'
          type: 'string'
        }
        {
          name: 'resultsscheme_s'
          type: 'string'
        }
        {
          name: 'certificatepublickeysize_d'
          type: 'real'
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
          name: 'certificateextensions_s'
          type: 'real'
        }
        {
          name: 'certificateextkeyusage_s'
          type: 'string'
        }
        {
          name: 'certificatesha1fingerprint_s'
          type: 'string'
        }
        {
          name: 'certificatepublickeyalgorithm_s'
          type: 'string'
        }
        {
          name: 'certificatesignaturealgorithm_s'
          type: 'string'
        }
        {
          name: 'certificatekeyusage_s'
          type: 'string'
        }
        {
          name: 'uri_filetype_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'severity_score_s'
          type: 'string'
        }
        {
          name: 'certificatevaliditydays_d'
          type: 'real'
        }
        {
          name: 'basic_constraints_path_length_s'
          type: 'string'
        }
        {
          name: 'certificate_issuer_type_s'
          type: 'string'
        }
        {
          name: 'certificateselfsigned_s'
          type: 'string'
        }
        {
          name: 'cnformat_s'
          type: 'string'
        }
        {
          name: 'certificateparsingerror_s'
          type: 'string'
        }
        {
          name: 'certificate_usage_s'
          type: 'string'
        }
        {
          name: 'certs_scanid_d'
          type: 'real'
        }
        {
          name: 'library_severity_description_s'
          type: 'string'
        }
        {
          name: 'keyid_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = infosecanalyticsclTable.name
output tableId string = infosecanalyticsclTable.id
output provisioningState string = infosecanalyticsclTable.properties.provisioningState
