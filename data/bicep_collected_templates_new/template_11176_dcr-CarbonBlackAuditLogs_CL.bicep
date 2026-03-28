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
// Data Collection Rule for CarbonBlackAuditLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:19:58
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 27, DCR columns: 24 (Type column always filtered)
// Output stream: Custom-CarbonBlackAuditLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CarbonBlackAuditLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CarbonBlackAuditLogs_CL': {
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
            name: 'eventTime_d'
            type: 'string'
          }
          {
            name: 'eventId_g'
            type: 'string'
          }
          {
            name: 'requestUrl_s'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'verbose_b'
            type: 'string'
          }
          {
            name: 'flagged_b'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'requestUrl'
            type: 'string'
          }
          {
            name: 'description'
            type: 'string'
          }
          {
            name: 'orgName_s'
            type: 'string'
          }
          {
            name: 'clientIp'
            type: 'string'
          }
          {
            name: 'orgName'
            type: 'string'
          }
          {
            name: 'loginName_s'
            type: 'string'
          }
          {
            name: 'eventId'
            type: 'string'
          }
          {
            name: 'eventTime'
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
            name: 'flagged'
            type: 'string'
          }
          {
            name: 'clientIp_s'
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
          name: 'Sentinel-CarbonBlackAuditLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CarbonBlackAuditLogs_CL']
        destinations: ['Sentinel-CarbonBlackAuditLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), eventTime_d = toreal(eventTime_d), eventId_g = tostring(eventId_g), requestUrl_s = tostring(requestUrl_s), description_s = tostring(description_s), verbose_b = tobool(verbose_b), flagged_b = tobool(flagged_b), TenantId = toguid(TenantId), requestUrl = tostring(requestUrl), description = tostring(description), orgName_s = tostring(orgName_s), clientIp = tostring(clientIp), orgName = tostring(orgName), loginName_s = tostring(loginName_s), eventId = tostring(eventId), eventTime = toreal(eventTime), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), flagged = tobool(flagged), clientIp_s = tostring(clientIp_s)'
        outputStream: 'Custom-CarbonBlackAuditLogs_CL'
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
