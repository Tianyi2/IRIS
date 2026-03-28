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
// Data Collection Rule for DomainToolsDomainEnrichment_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 70, DCR columns: 68 (Type column always filtered)
// Output stream: Custom-DomainToolsDomainEnrichment_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-DomainToolsDomainEnrichment_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-DomainToolsDomainEnrichment_CL': {
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-DomainToolsDomainEnrichment_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-DomainToolsDomainEnrichment_CL']
        destinations: ['Sentinel-DomainToolsDomainEnrichment_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), IP_ASN_s = tostring(IP_ASN_s), IP_Country_s = tostring(IP_Country_s), IP_ISP_s = tostring(IP_ISP_s), MX_Host_s = tostring(MX_Host_s), MX_Domain_s = tostring(MX_Domain_s), MX_IP_s = tostring(MX_IP_s), Nameserver_Host_s = tostring(Nameserver_Host_s), Nameserver_Domain_s = tostring(Nameserver_Domain_s), Nameserver_IP_s = tostring(Nameserver_IP_s), Popularity_Rank_d = toreal(Popularity_Rank_d), Redirect_Domain_s = tostring(Redirect_Domain_s), Registrant_Name_s = tostring(Registrant_Name_s), Registrant_Org_s = tostring(Registrant_Org_s), Registrar_s = tostring(Registrar_s), IP_Address_s = tostring(IP_Address_s), SSL_Alt_Names_s = tostring(SSL_Alt_Names_s), SSL_Email_s = tostring(SSL_Email_s), SSL_Hash_s = tostring(SSL_Hash_s), SSL_Issuer_Common_Name_s = tostring(SSL_Issuer_Common_Name_s), SSL_Not_After_s = tostring(SSL_Not_After_s), SSL_Not_Before_s = tostring(SSL_Not_Before_s), SSL_Subject_s = tostring(SSL_Subject_s), SSL_Subject_Common_Name_s = tostring(SSL_Subject_Common_Name_s), SSL_Organization_s = tostring(SSL_Organization_s), Server_Type_s = tostring(Server_Type_s), Status_b = tobool(Status_b), TLD_s = tostring(TLD_s), Tags_s = tostring(Tags_s), Website_Title_s = tostring(Website_Title_s), Risk_Score_d = toreal(Risk_Score_d), SSL_Duration_s = tostring(SSL_Duration_s), Popularity_Rank_s = tostring(Popularity_Rank_s), Statcounter_Security_Codes_s = tostring(Statcounter_Security_Codes_s), Matomo_Codes_s = tostring(Matomo_Codes_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), Google_Analytics_d = toreal(Google_Analytics_d), Adsense_s = tostring(Adsense_s), Contact_Country_Code_s = tostring(Contact_Country_Code_s), Contact_Name_s = tostring(Contact_Name_s), Contact_Phone_s = tostring(Contact_Phone_s), Contact_Street_s = tostring(Contact_Street_s), Risk_Score_s = tostring(Risk_Score_s), Create_Date_s = tostring(Create_Date_s), Domain_s = tostring(Domain_s), Statcounter_Project_Codes_s = tostring(Statcounter_Project_Codes_s), Admin_Contact_Email_s = tostring(Admin_Contact_Email_s), SOA_Email_s = tostring(SOA_Email_s), Registrant_Contact_Email_s = tostring(Registrant_Contact_Email_s), Technical_Contact_Email_s = tostring(Technical_Contact_Email_s), Whois_Email_s = tostring(Whois_Email_s), Email_Domain_s = tostring(Email_Domain_s), Expiration_Date_s = tostring(Expiration_Date_s), First_Seen_t = todatetime(First_Seen_t), Google_Analytics_s = tostring(Google_Analytics_s), Google_Analytics_4_s = tostring(Google_Analytics_4_s), GTM_Codes_s = tostring(GTM_Codes_s), Facebook_Codes_s = tostring(Facebook_Codes_s), Hotjar_Codes_s = tostring(Hotjar_Codes_s), Baidu_Codes_s = tostring(Baidu_Codes_s), Yandex_Codes_s = tostring(Yandex_Codes_s), Billing_Contact_Email_s = tostring(Billing_Contact_Email_s), UTC = tostring(UTC)'
        outputStream: 'Custom-DomainToolsDomainEnrichment_CL'
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
