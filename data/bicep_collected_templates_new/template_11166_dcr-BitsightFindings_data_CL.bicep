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
// Data Collection Rule for BitsightFindings_data_CL
// ============================================================================
// Generated: 2025-09-19 14:19:57
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 29 (Type column always filtered)
// Output stream: Custom-BitsightFindings_data_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-BitsightFindings_data_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-BitsightFindings_data_CL': {
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
            name: 'RemediationHistoryLastRefreshStatusDate'
            type: 'string'
          }
          {
            name: 'RemediationHistoryLastRequestedRefreshDate'
            type: 'string'
          }
          {
            name: 'RemainingDecay'
            type: 'string'
          }
          {
            name: 'CompanyName'
            type: 'string'
          }
          {
            name: 'AttributedCompanies'
            type: 'string'
          }
          {
            name: 'AssetOverrides'
            type: 'string'
          }
          {
            name: 'Tags'
            type: 'string'
          }
          {
            name: 'SeverityCategory'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
          }
          {
            name: 'RolledupObservationId'
            type: 'string'
          }
          {
            name: 'RiskVectorLabel'
            type: 'string'
          }
          {
            name: 'RiskVector'
            type: 'string'
          }
          {
            name: 'RiskCategory'
            type: 'string'
          }
          {
            name: 'RelatedFindings'
            type: 'string'
          }
          {
            name: 'LastSeen'
            type: 'string'
          }
          {
            name: 'FirstSeen'
            type: 'string'
          }
          {
            name: 'EvidenceKey'
            type: 'string'
          }
          {
            name: 'Details'
            type: 'string'
          }
          {
            name: 'Assets'
            type: 'string'
          }
          {
            name: 'AffectsRating'
            type: 'string'
          }
          {
            name: 'TemporaryId'
            type: 'string'
          }
          {
            name: 'Duration'
            type: 'string'
          }
          {
            name: 'PcapID'
            type: 'string'
          }
          {
            name: 'Comments'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'RemediationHistoryLastRefreshStatusLabel'
            type: 'string'
          }
          {
            name: 'RemediationHistoryLastRefreshReasonCode'
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
          name: 'Sentinel-BitsightFindings_data_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-BitsightFindings_data_CL']
        destinations: ['Sentinel-BitsightFindings_data_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = todatetime(EventVendor), RemediationHistoryLastRefreshStatusDate = tostring(RemediationHistoryLastRefreshStatusDate), RemediationHistoryLastRequestedRefreshDate = tostring(RemediationHistoryLastRequestedRefreshDate), RemainingDecay = toreal(RemainingDecay), CompanyName = tostring(CompanyName), AttributedCompanies = tostring(AttributedCompanies), AssetOverrides = tostring(AssetOverrides), Tags = tostring(Tags), SeverityCategory = tostring(SeverityCategory), Severity = toint(Severity), RolledupObservationId = tostring(RolledupObservationId), RiskVectorLabel = tostring(RiskVectorLabel), RiskVector = tostring(RiskVector), RiskCategory = tostring(RiskCategory), RelatedFindings = tostring(RelatedFindings), LastSeen = tostring(LastSeen), FirstSeen = tostring(FirstSeen), EvidenceKey = tostring(EvidenceKey), Details = tostring(Details), Assets = tostring(Assets), AffectsRating = tobool(AffectsRating), TemporaryId = tostring(TemporaryId), Duration = tostring(Duration), PcapID = tostring(PcapID), Comments = tostring(Comments), EventProduct = tobool(EventProduct), RemediationHistoryLastRefreshStatusLabel = tostring(RemediationHistoryLastRefreshStatusLabel), RemediationHistoryLastRefreshReasonCode = tostring(RemediationHistoryLastRefreshReasonCode)'
        outputStream: 'Custom-BitsightFindings_data_CL'
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
