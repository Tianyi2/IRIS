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
// Data Collection Rule for ForcepointDLPEvents_CL
// ============================================================================
// Generated: 2025-09-19 14:20:19
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 29, DCR columns: 27 (Type column always filtered)
// Output stream: Custom-ForcepointDLPEvents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ForcepointDLPEvents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ForcepointDLPEvents_CL': {
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
            name: 'ForcepointDLPSourceIP'
            type: 'string'
          }
          {
            name: 'Title'
            type: 'string'
          }
          {
            name: 'SourceDomain'
            type: 'string'
          }
          {
            name: 'DestinationIpV4'
            type: 'string'
          }
          {
            name: 'DestinationCommonName'
            type: 'string'
          }
          {
            name: 'Text'
            type: 'string'
          }
          {
            name: 'SourceIpV4_s'
            type: 'string'
          }
          {
            name: 'ExternalId'
            type: 'string'
          }
          {
            name: 'DestinationHostname'
            type: 'string'
          }
          {
            name: 'UpdatedAt'
            type: 'string'
          }
          {
            name: 'Severity_s'
            type: 'string'
          }
          {
            name: 'RuleName_1_s'
            type: 'string'
          }
          {
            name: 'Id'
            type: 'string'
          }
          {
            name: 'GeneratorId'
            type: 'string'
          }
          {
            name: 'PolicyCategoryId'
            type: 'string'
          }
          {
            name: 'Protocol'
            type: 'string'
          }
          {
            name: 'CreatedAt_t'
            type: 'string'
          }
          {
            name: 'DestinationDomain'
            type: 'string'
          }
          {
            name: 'RawData'
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
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'UpdatedBy'
            type: 'string'
          }
          {
            name: 'Description'
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
          name: 'Sentinel-ForcepointDLPEvents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ForcepointDLPEvents_CL']
        destinations: ['Sentinel-ForcepointDLPEvents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), ForcepointDLPSourceIP = tostring(ForcepointDLPSourceIP), Title = tostring(Title), SourceDomain = tostring(SourceDomain), DestinationIpV4 = toreal(DestinationIpV4), DestinationCommonName = toreal(DestinationCommonName), Text = toreal(Text), SourceIpV4_s = tostring(SourceIpV4_s), ExternalId = tostring(ExternalId), DestinationHostname = tostring(DestinationHostname), UpdatedAt = tostring(UpdatedAt), Severity_s = tostring(Severity_s), RuleName_1_s = tostring(RuleName_1_s), Id = tostring(Id), GeneratorId = tostring(GeneratorId), PolicyCategoryId = tostring(PolicyCategoryId), Protocol = tostring(Protocol), CreatedAt_t = todatetime(CreatedAt_t), DestinationDomain = tostring(DestinationDomain), RawData = tostring(RawData), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), Computer = tostring(Computer), SourceSystem = tostring(SourceSystem), UpdatedBy = tostring(UpdatedBy), Description = toreal(Description)'
        outputStream: 'Custom-ForcepointDLPEvents_CL'
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
