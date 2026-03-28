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
// Data Collection Rule for MailGuard365_Threats_CL
// ============================================================================
// Generated: 2025-09-19 14:20:24
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 32, DCR columns: 31 (Type column always filtered)
// Output stream: Custom-MailGuard365_Threats_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-MailGuard365_Threats_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-MailGuard365_Threats_CL': {
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
            name: 'Email_s'
            type: 'string'
          }
          {
            name: 'IsInBlackList_b'
            type: 'string'
          }
          {
            name: 'IsInWhiteList_b'
            type: 'string'
          }
          {
            name: 'MicrosoftAntiSpam_s'
            type: 'string'
          }
          {
            name: 'ForefrontAntiSpam_s'
            type: 'string'
          }
          {
            name: 'ReceivedDateTime_d'
            type: 'string'
          }
          {
            name: 'Action_s'
            type: 'string'
          }
          {
            name: 'MessageSize_d'
            type: 'string'
          }
          {
            name: 'MessageDate_t'
            type: 'string'
          }
          {
            name: 'OriginCountry_s'
            type: 'string'
          }
          {
            name: 'Subject_s'
            type: 'string'
          }
          {
            name: 'CcHeader_s'
            type: 'string'
          }
          {
            name: 'ToHeader_s'
            type: 'string'
          }
          {
            name: 'SenderHeader_s'
            type: 'string'
          }
          {
            name: 'ReceivedHeaders_s'
            type: 'string'
          }
          {
            name: 'Recipients_s'
            type: 'string'
          }
          {
            name: 'Sender_Domain_s'
            type: 'string'
          }
          {
            name: 'Sender_Email_s'
            type: 'string'
          }
          {
            name: 'Attachments_s'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'Virus_b'
            type: 'string'
          }
          {
            name: 'Score_d'
            type: 'string'
          }
          {
            name: 'CustomerTenantId_g'
            type: 'string'
          }
          {
            name: 'UserId_g'
            type: 'string'
          }
          {
            name: 'HeaderMessageId_s'
            type: 'string'
          }
          {
            name: 'MessageId_s'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'HasAttachment_b'
            type: 'string'
          }
          {
            name: 'HasImage_b'
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
          name: 'Sentinel-MailGuard365_Threats_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-MailGuard365_Threats_CL']
        destinations: ['Sentinel-MailGuard365_Threats_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), Email_s = tostring(Email_s), IsInBlackList_b = tobool(IsInBlackList_b), IsInWhiteList_b = tobool(IsInWhiteList_b), MicrosoftAntiSpam_s = tostring(MicrosoftAntiSpam_s), ForefrontAntiSpam_s = tostring(ForefrontAntiSpam_s), ReceivedDateTime_d = toreal(ReceivedDateTime_d), Action_s = tostring(Action_s), MessageSize_d = toreal(MessageSize_d), MessageDate_t = todatetime(MessageDate_t), OriginCountry_s = tostring(OriginCountry_s), Subject_s = tostring(Subject_s), CcHeader_s = tostring(CcHeader_s), ToHeader_s = toguid(ToHeader_s), SenderHeader_s = tostring(SenderHeader_s), ReceivedHeaders_s = tostring(ReceivedHeaders_s), Recipients_s = tostring(Recipients_s), Sender_Domain_s = todatetime(Sender_Domain_s), Sender_Email_s = toreal(Sender_Email_s), Attachments_s = tostring(Attachments_s), Category = tostring(Category), Virus_b = tobool(Virus_b), Score_d = toreal(Score_d), CustomerTenantId_g = tostring(CustomerTenantId_g), UserId_g = tostring(UserId_g), HeaderMessageId_s = tostring(HeaderMessageId_s), MessageId_s = tostring(MessageId_s), SourceSystem = tostring(SourceSystem), HasAttachment_b = tobool(HasAttachment_b), HasImage_b = tobool(HasImage_b)'
        outputStream: 'Custom-MailGuard365_Threats_CL'
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
