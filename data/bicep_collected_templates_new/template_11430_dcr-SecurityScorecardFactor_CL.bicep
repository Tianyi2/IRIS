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
// Data Collection Rule for SecurityScorecardFactor_CL
// ============================================================================
// Generated: 2025-09-19 14:20:31
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 21 (Type column always filtered)
// Output stream: Custom-SecurityScorecardFactor_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SecurityScorecardFactor_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SecurityScorecardFactor_CL': {
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
            name: 'factorDescription_s'
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
            name: 'dateToday_s'
            type: 'string'
          }
          {
            name: 'dateYesterday_s'
            type: 'string'
          }
          {
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'Factor_Name_s'
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
          name: 'Sentinel-SecurityScorecardFactor_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SecurityScorecardFactor_CL']
        destinations: ['Sentinel-SecurityScorecardFactor_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), factorDescription_s = tostring(factorDescription_s), scoreChange_d = toreal(scoreChange_d), scoreToday_d = toreal(scoreToday_d), scoreYesterday_d = toreal(scoreYesterday_d), dateToday_s = tostring(dateToday_s), dateYesterday_s = tostring(dateYesterday_s), subject_s = tostring(subject_s), Factor_Name_s = tostring(Factor_Name_s), Factor_s = tostring(Factor_s), body_s = tostring(body_s), portfolioName_s = tostring(portfolioName_s), portfolioId_s = tostring(portfolioId_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), industry_s = tostring(industry_s), severity_s = tostring(severity_s)'
        outputStream: 'Custom-SecurityScorecardFactor_CL'
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
