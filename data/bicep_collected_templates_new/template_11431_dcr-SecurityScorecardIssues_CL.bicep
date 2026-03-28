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
// Data Collection Rule for SecurityScorecardIssues_CL
// ============================================================================
// Generated: 2025-09-19 14:20:31
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 25, DCR columns: 23 (Type column always filtered)
// Output stream: Custom-SecurityScorecardIssues_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SecurityScorecardIssues_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SecurityScorecardIssues_CL': {
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
            name: 'detail_url_s'
            type: 'string'
          }
          {
            name: 'severity_value_s'
            type: 'string'
          }
          {
            name: 'totalScoreImpact_d'
            type: 'string'
          }
          {
            name: 'issueName_s'
            type: 'string'
          }
          {
            name: 'groupStatus_s'
            type: 'string'
          }
          {
            name: 'findingsCount_d'
            type: 'string'
          }
          {
            name: 'issueType_s'
            type: 'string'
          }
          {
            name: 'date_t'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'eventID_s'
            type: 'string'
          }
          {
            name: 'Factor_s'
            type: 'string'
          }
          {
            name: 'body_s'
            type: 'string'
          }
          {
            name: 'portfolioName_s'
            type: 'string'
          }
          {
            name: 'portfolioId_g'
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
            name: 'industry_s'
            type: 'string'
          }
          {
            name: 'severity_s'
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
          name: 'Sentinel-SecurityScorecardIssues_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SecurityScorecardIssues_CL']
        destinations: ['Sentinel-SecurityScorecardIssues_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), detail_url_s = tostring(detail_url_s), severity_value_s = tostring(severity_value_s), totalScoreImpact_d = tostring(totalScoreImpact_d), issueName_s = tostring(issueName_s), groupStatus_s = tostring(groupStatus_s), findingsCount_d = tostring(findingsCount_d), issueType_s = tostring(issueType_s), date_t = tostring(date_t), subject_s = tostring(subject_s), eventID_s = tostring(eventID_s), Factor_s = tostring(Factor_s), body_s = tostring(body_s), portfolioName_s = tostring(portfolioName_s), portfolioId_g = tostring(portfolioId_g), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), industry_s = tostring(industry_s), severity_s = tostring(severity_s)'
        outputStream: 'Custom-SecurityScorecardIssues_CL'
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
