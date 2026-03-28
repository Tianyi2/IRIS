// Bicep template for Log Analytics custom table: DomainToolsDomainEnrichment_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 70, Deployed columns: 68 (Type column filtered)
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

resource domaintoolsdomainenrichmentclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'DomainToolsDomainEnrichment_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'DomainToolsDomainEnrichment_CL'
      description: 'Custom table DomainToolsDomainEnrichment_CL - imported from JSON schema'
      displayName: 'DomainToolsDomainEnrichment_CL'
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
          name: 'IP_ASN_s'
          type: 'string'
        }
        {
          name: 'IP_Country_s'
          type: 'string'
        }
        {
          name: 'IP_ISP_s'
          type: 'string'
        }
        {
          name: 'MX_Host_s'
          type: 'string'
        }
        {
          name: 'MX_Domain_s'
          type: 'string'
        }
        {
          name: 'MX_IP_s'
          type: 'string'
        }
        {
          name: 'Nameserver_Host_s'
          type: 'string'
        }
        {
          name: 'Nameserver_Domain_s'
          type: 'string'
        }
        {
          name: 'Nameserver_IP_s'
          type: 'string'
        }
        {
          name: 'Popularity_Rank_d'
          type: 'real'
        }
        {
          name: 'Redirect_Domain_s'
          type: 'string'
        }
        {
          name: 'Registrant_Name_s'
          type: 'string'
        }
        {
          name: 'Registrant_Org_s'
          type: 'string'
        }
        {
          name: 'Registrar_s'
          type: 'string'
        }
        {
          name: 'IP_Address_s'
          type: 'string'
        }
        {
          name: 'SSL_Alt_Names_s'
          type: 'string'
        }
        {
          name: 'SSL_Email_s'
          type: 'string'
        }
        {
          name: 'SSL_Hash_s'
          type: 'string'
        }
        {
          name: 'SSL_Issuer_Common_Name_s'
          type: 'string'
        }
        {
          name: 'SSL_Not_After_s'
          type: 'string'
        }
        {
          name: 'SSL_Not_Before_s'
          type: 'string'
        }
        {
          name: 'SSL_Subject_s'
          type: 'string'
        }
        {
          name: 'SSL_Subject_Common_Name_s'
          type: 'string'
        }
        {
          name: 'SSL_Organization_s'
          type: 'string'
        }
        {
          name: 'Server_Type_s'
          type: 'string'
        }
        {
          name: 'Status_b'
          type: 'boolean'
        }
        {
          name: 'TLD_s'
          type: 'string'
        }
        {
          name: 'Tags_s'
          type: 'string'
        }
        {
          name: 'Website_Title_s'
          type: 'string'
        }
        {
          name: 'Risk_Score_d'
          type: 'real'
        }
        {
          name: 'SSL_Duration_s'
          type: 'string'
        }
        {
          name: 'Popularity_Rank_s'
          type: 'string'
        }
        {
          name: 'Statcounter_Security_Codes_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'Matomo_Codes_s'
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
          name: 'Google_Analytics_d'
          type: 'real'
        }
        {
          name: 'Adsense_s'
          type: 'string'
        }
        {
          name: 'Contact_Country_Code_s'
          type: 'string'
        }
        {
          name: 'Contact_Name_s'
          type: 'string'
        }
        {
          name: 'Contact_Phone_s'
          type: 'string'
        }
        {
          name: 'Contact_Street_s'
          type: 'string'
        }
        {
          name: 'Risk_Score_s'
          type: 'string'
        }
        {
          name: 'Create_Date_s'
          type: 'string'
        }
        {
          name: 'Domain_s'
          type: 'string'
        }
        {
          name: 'Statcounter_Project_Codes_s'
          type: 'string'
        }
        {
          name: 'Admin_Contact_Email_s'
          type: 'string'
        }
        {
          name: 'SOA_Email_s'
          type: 'string'
        }
        {
          name: 'Registrant_Contact_Email_s'
          type: 'string'
        }
        {
          name: 'Technical_Contact_Email_s'
          type: 'string'
        }
        {
          name: 'Whois_Email_s'
          type: 'string'
        }
        {
          name: 'Email_Domain_s'
          type: 'string'
        }
        {
          name: 'Expiration_Date_s'
          type: 'string'
        }
        {
          name: 'First_Seen_t'
          type: 'dateTime'
        }
        {
          name: 'Google_Analytics_s'
          type: 'string'
        }
        {
          name: 'Google_Analytics_4_s'
          type: 'string'
        }
        {
          name: 'GTM_Codes_s'
          type: 'string'
        }
        {
          name: 'Facebook_Codes_s'
          type: 'string'
        }
        {
          name: 'Hotjar_Codes_s'
          type: 'string'
        }
        {
          name: 'Baidu_Codes_s'
          type: 'string'
        }
        {
          name: 'Yandex_Codes_s'
          type: 'string'
        }
        {
          name: 'Billing_Contact_Email_s'
          type: 'string'
        }
        {
          name: 'UTC'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = domaintoolsdomainenrichmentclTable.name
output tableId string = domaintoolsdomainenrichmentclTable.id
output provisioningState string = domaintoolsdomainenrichmentclTable.properties.provisioningState
