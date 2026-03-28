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
// Data Collection Rule for CiscoETD_CL
// ============================================================================
// Generated: 2025-09-19 14:19:59
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 41, DCR columns: 41 (Type column always filtered)
// Output stream: Custom-CiscoETD_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CiscoETD_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CiscoETD_CL': {
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
            name: 'subject_s'
            type: 'string'
          }
          {
            name: 'toAddresses_s'
            type: 'string'
          }
          {
            name: 'timestamp_t'
            type: 'string'
          }
          {
            name: 'urls_s'
            type: 'string'
          }
          {
            name: 'verdict_isManualVerdict_b'
            type: 'string'
          }
          {
            name: 'verdict_userId_s'
            type: 'string'
          }
          {
            name: 'verdict_isRetroVerdict_b'
            type: 'string'
          }
          {
            name: 'serverIP_s'
            type: 'string'
          }
          {
            name: 'verdict_techniques_s'
            type: 'string'
          }
          {
            name: 'verdict_originalVerdict_s'
            type: 'string'
          }
          {
            name: 'verdict_latestVerdict_s'
            type: 'string'
          }
          {
            name: 'verdict_category_s'
            type: 'string'
          }
          {
            name: 'verdict_publicApiClientId_s'
            type: 'string'
          }
          {
            name: 'verdict_businessRisk_s'
            type: 'string'
          }
          {
            name: 'secureEmailGateway_originalCIP_s'
            type: 'string'
          }
          {
            name: 'secureEmailGateway_headerName_s'
            type: 'string'
          }
          {
            name: 'verdict_timestamp_t'
            type: 'string'
          }
          {
            name: 'returnPath_s'
            type: 'string'
          }
          {
            name: 'internetMessageId_s'
            type: 'string'
          }
          {
            name: 'mailboxes_s'
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
            name: 'attachments_s'
            type: 'string'
          }
          {
            name: 'senderName_s'
            type: 'string'
          }
          {
            name: 'action_type_s'
            type: 'string'
          }
          {
            name: 'action_isAutoRemediated_b'
            type: 'string'
          }
          {
            name: 'action_folder_s'
            type: 'string'
          }
          {
            name: 'action_timestamp_t'
            type: 'string'
          }
          {
            name: 'action_publicApiClientId_s'
            type: 'string'
          }
          {
            name: 'fromAddress_s'
            type: 'string'
          }
          {
            name: 'clientIP_s'
            type: 'string'
          }
          {
            name: 'direction_s'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'envelopeTo_s'
            type: 'string'
          }
          {
            name: 'deliveredTo_s'
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
          name: 'Sentinel-CiscoETD_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CiscoETD_CL']
        destinations: ['Sentinel-CiscoETD_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), subject_s = tostring(subject_s), toAddresses_s = tostring(toAddresses_s), timestamp_t = todatetime(timestamp_t), urls_s = tostring(urls_s), verdict_isManualVerdict_b = tobool(verdict_isManualVerdict_b), verdict_userId_s = tostring(verdict_userId_s), verdict_isRetroVerdict_b = tobool(verdict_isRetroVerdict_b), serverIP_s = tostring(serverIP_s), verdict_techniques_s = tostring(verdict_techniques_s), verdict_originalVerdict_s = tostring(verdict_originalVerdict_s), verdict_latestVerdict_s = tostring(verdict_latestVerdict_s), verdict_category_s = tostring(verdict_category_s), verdict_publicApiClientId_s = tostring(verdict_publicApiClientId_s), verdict_businessRisk_s = tostring(verdict_businessRisk_s), secureEmailGateway_originalCIP_s = tostring(secureEmailGateway_originalCIP_s), secureEmailGateway_headerName_s = tostring(secureEmailGateway_headerName_s), verdict_timestamp_t = todatetime(verdict_timestamp_t), returnPath_s = tostring(returnPath_s), internetMessageId_s = tostring(internetMessageId_s), mailboxes_s = tostring(mailboxes_s), SourceSystem = tostring(SourceSystem), MG = toguid(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), attachments_s = tostring(attachments_s), senderName_s = tostring(senderName_s), action_type_s = tostring(action_type_s), action_isAutoRemediated_b = tobool(action_isAutoRemediated_b), action_folder_s = tostring(action_folder_s), action_timestamp_t = todatetime(action_timestamp_t), action_publicApiClientId_s = tostring(action_publicApiClientId_s), fromAddress_s = tostring(fromAddress_s), clientIP_s = tostring(clientIP_s), direction_s = tostring(direction_s), domain_s = tostring(domain_s), id_g = toguid(id_g), envelopeTo_s = tostring(envelopeTo_s), deliveredTo_s = tostring(deliveredTo_s)'
        outputStream: 'Custom-CiscoETD_CL'
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
