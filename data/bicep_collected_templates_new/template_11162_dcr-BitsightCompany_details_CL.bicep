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
// Data Collection Rule for BitsightCompany_details_CL
// ============================================================================
// Generated: 2025-09-19 14:19:56
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 50, DCR columns: 48 (Type column always filtered)
// Output stream: Custom-BitsightCompany_details_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BitsightCompany_details_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BitsightCompany_details_CL': {
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
            name: 'Name'
            type: 'string'
          }
          {
            name: 'PeopleCount'
            type: 'string'
          }
          {
            name: 'PermissionCanAnnotate'
            type: 'string'
          }
          {
            name: 'PermissionCanDownloadCompanyReport'
            type: 'string'
          }
          {
            name: 'PermissionCanEnableVendorAccess'
            type: 'string'
          }
          {
            name: 'PermissionCanViewCompanyReports'
            type: 'string'
          }
          {
            name: 'PermissionCanViewForensics'
            type: 'string'
          }
          {
            name: 'PermissionCanViewInfrastructure'
            type: 'string'
          }
          {
            name: 'PermissionCanViewIpAttributions'
            type: 'string'
          }
          {
            name: 'IsUnsampledAllowed'
            type: 'string'
          }
          {
            name: 'PermissionCanViewServiceProviders'
            type: 'string'
          }
          {
            name: 'RatingIndustryMedian'
            type: 'string'
          }
          {
            name: 'Ratings'
            type: 'string'
          }
          {
            name: 'RelatedCompanies'
            type: 'string'
          }
          {
            name: 'SearchCount'
            type: 'string'
          }
          {
            name: 'ServiceProvider'
            type: 'string'
          }
          {
            name: 'Shortname'
            type: 'string'
          }
          {
            name: 'Sparkline'
            type: 'string'
          }
          {
            name: 'SubIndustry'
            type: 'string'
          }
          {
            name: 'SubIndustrySlug'
            type: 'string'
          }
          {
            name: 'PermissionsHasControl'
            type: 'string'
          }
          {
            name: 'SubscriptionType'
            type: 'string'
          }
          {
            name: 'IsPrimary'
            type: 'string'
          }
          {
            name: 'IsCsp'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'ComplianceClaimCertifications'
            type: 'string'
          }
          {
            name: 'ComplianceClaimTrustPage'
            type: 'string'
          }
          {
            name: 'PrimaryDomain'
            type: 'string'
          }
          {
            name: 'PrimaryCompanyName'
            type: 'string'
          }
          {
            name: 'AvailableUpgradeTypes'
            type: 'string'
          }
          {
            name: 'BulkEmailSenderStatus'
            type: 'string'
          }
          {
            name: 'CompanyFeatures'
            type: 'string'
          }
          {
            name: 'CustomerMonitoringCount'
            type: 'string'
          }
          {
            name: 'IsMycompMysubsBundle'
            type: 'string'
          }
          {
            name: 'Description'
            type: 'string'
          }
          {
            name: 'GUID'
            type: 'string'
          }
          {
            name: 'HasCompanyTree'
            type: 'string'
          }
          {
            name: 'HasPreferredContact'
            type: 'string'
          }
          {
            name: 'Hompage'
            type: 'string'
          }
          {
            name: 'InSpmPortfolio'
            type: 'string'
          }
          {
            name: 'Industry'
            type: 'string'
          }
          {
            name: 'IndustrySlug'
            type: 'string'
          }
          {
            name: 'Ipv4Count'
            type: 'string'
          }
          {
            name: 'IsBundle'
            type: 'string'
          }
          {
            name: 'DisplayURL'
            type: 'string'
          }
          {
            name: 'SubscriptionTypeKey'
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
          name: 'Sentinel-BitsightCompany_details_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BitsightCompany_details_CL']
        destinations: ['Sentinel-BitsightCompany_details_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), Name = tostring(Name), PeopleCount = toreal(PeopleCount), PermissionCanAnnotate = tobool(PermissionCanAnnotate), PermissionCanDownloadCompanyReport = tobool(PermissionCanDownloadCompanyReport), PermissionCanEnableVendorAccess = tobool(PermissionCanEnableVendorAccess), PermissionCanViewCompanyReports = tobool(PermissionCanViewCompanyReports), PermissionCanViewForensics = tobool(PermissionCanViewForensics), PermissionCanViewInfrastructure = tobool(PermissionCanViewInfrastructure), PermissionCanViewIpAttributions = tobool(PermissionCanViewIpAttributions), IsUnsampledAllowed = tobool(IsUnsampledAllowed), PermissionCanViewServiceProviders = tobool(PermissionCanViewServiceProviders), RatingIndustryMedian = tostring(RatingIndustryMedian), Ratings = tostring(Ratings), RelatedCompanies = tostring(RelatedCompanies), SearchCount = toreal(SearchCount), ServiceProvider = tobool(ServiceProvider), Shortname = tostring(Shortname), Sparkline = tostring(Sparkline), SubIndustry = tostring(SubIndustry), SubIndustrySlug = tostring(SubIndustrySlug), PermissionsHasControl = tobool(PermissionsHasControl), SubscriptionType = tostring(SubscriptionType), IsPrimary = tobool(IsPrimary), IsCsp = tobool(IsCsp), EventProduct = tostring(EventProduct), ComplianceClaimCertifications = tostring(ComplianceClaimCertifications), ComplianceClaimTrustPage = tostring(ComplianceClaimTrustPage), PrimaryDomain = tostring(PrimaryDomain), PrimaryCompanyName = tostring(PrimaryCompanyName), AvailableUpgradeTypes = tostring(AvailableUpgradeTypes), BulkEmailSenderStatus = tostring(BulkEmailSenderStatus), CompanyFeatures = tostring(CompanyFeatures), CustomerMonitoringCount = toreal(CustomerMonitoringCount), IsMycompMysubsBundle = tobool(IsMycompMysubsBundle), Description = tostring(Description), GUID = tostring(GUID), HasCompanyTree = tobool(HasCompanyTree), HasPreferredContact = tobool(HasPreferredContact), Hompage = tostring(Hompage), InSpmPortfolio = tobool(InSpmPortfolio), Industry = tostring(Industry), IndustrySlug = tostring(IndustrySlug), Ipv4Count = toreal(Ipv4Count), IsBundle = tobool(IsBundle), DisplayURL = tostring(DisplayURL), SubscriptionTypeKey = tostring(SubscriptionTypeKey)'
        outputStream: 'Custom-BitsightCompany_details_CL'
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
