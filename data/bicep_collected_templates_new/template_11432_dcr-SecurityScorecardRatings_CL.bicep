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
// Data Collection Rule for SecurityScorecardRatings_CL
// ============================================================================
// Generated: 2025-09-19 14:20:31
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-SecurityScorecardRatings_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SecurityScorecardRatings_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SecurityScorecardRatings_CL': {
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
            name: 'portfolioId_g'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'industry_s'
            type: 'string'
          }
          {
            name: 'scoreChange_d'
            type: 'string'
          }
          {
            name: 'scoreToday_d'
            type: 'string'
          }
          {
            name: 'scoreYesterday_d'
            type: 'string'
          }
          {
            name: 'dateToday_t'
            type: 'string'
          }
          {
            name: 'dateYesterday_t'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'src_s'
            type: 'string'
          }
          {
            name: 'body_s'
            type: 'string'
          }
          {
            name: 'portfolioId_s'
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
            name: 'portfolioName_s'
            type: 'string'
          }
          {
            name: 'portfolioId_g_s'
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
          name: 'Sentinel-SecurityScorecardRatings_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SecurityScorecardRatings_CL']
        destinations: ['Sentinel-SecurityScorecardRatings_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), portfolioId_g = tostring(portfolioId_g), severity_s = tostring(severity_s), industry_s = tostring(industry_s), scoreChange_d = toreal(scoreChange_d), scoreToday_d = toreal(scoreToday_d), scoreYesterday_d = toreal(scoreYesterday_d), dateToday_t = todatetime(dateToday_t), dateYesterday_t = todatetime(dateYesterday_t), subject_s = tostring(subject_s), src_s = tostring(src_s), body_s = tostring(body_s), portfolioId_s = tostring(portfolioId_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), portfolioName_s = tostring(portfolioName_s), portfolioId_g_s = tostring(portfolioId_g_s)'
        outputStream: 'Custom-SecurityScorecardRatings_CL'
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
