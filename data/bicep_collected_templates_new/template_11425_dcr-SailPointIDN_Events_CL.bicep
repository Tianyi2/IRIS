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
// Data Collection Rule for SailPointIDN_Events_CL
// ============================================================================
// Generated: 2025-09-19 14:20:30
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 66, DCR columns: 66 (Type column always filtered)
// Output stream: Custom-SailPointIDN_Events_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SailPointIDN_Events_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SailPointIDN_Events_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'action_s'
            type: 'string'
          }
          {
            name: 'attributes_provisioningResult_s'
            type: 'string'
          }
          {
            name: 'attributes_requestable_after_s'
            type: 'string'
          }
          {
            name: 'attributes_requestable_before_s'
            type: 'string'
          }
          {
            name: 'attributes_requestedAppId_s'
            type: 'string'
          }
          {
            name: 'attributes_requestedAppName_s'
            type: 'string'
          }
          {
            name: 'attributes_requestedAppRoleId_g'
            type: 'string'
          }
          {
            name: 'attributes_requestedObjectType_s'
            type: 'string'
          }
          {
            name: 'attributes_reviewerComment_s'
            type: 'string'
          }
          {
            name: 'attributes_sourceId_s'
            type: 'string'
          }
          {
            name: 'attributes_sourceName_s'
            type: 'string'
          }
          {
            name: 'attributes_synchronizeFrom_s'
            type: 'string'
          }
          {
            name: 'attributes_synchronizeTo_s'
            type: 'string'
          }
          {
            name: 'attributes_taskResultId_g'
            type: 'string'
          }
          {
            name: 'attributes_userId_s'
            type: 'string'
          }
          {
            name: 'created_t'
            type: 'string'
          }
          {
            name: 'details_g'
            type: 'string'
          }
          {
            name: 'details_s'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'objects_s'
            type: 'string'
          }
          {
            name: 'operation_s'
            type: 'string'
          }
          {
            name: 'org_s'
            type: 'string'
          }
          {
            name: 'pod_s'
            type: 'string'
          }
          {
            name: 'stack_s'
            type: 'string'
          }
          {
            name: 'status_s'
            type: 'string'
          }
          {
            name: 'synced_t'
            type: 'string'
          }
          {
            name: 'target_name_g'
            type: 'string'
          }
          {
            name: 'target_name_s'
            type: 'string'
          }
          {
            name: 'technicalName_s'
            type: 'string'
          }
          {
            name: 'attributes_previousValue_s'
            type: 'string'
          }
          {
            name: 'trackingNumber_g'
            type: 'string'
          }
          {
            name: 'attributes_preventativeSODResultsJSON_s'
            type: 'string'
          }
          {
            name: 'attributes_org_s'
            type: 'string'
          }
          {
            name: 'actor_name_g'
            type: 'string'
          }
          {
            name: 'actor_name_s'
            type: 'string'
          }
          {
            name: 'attributes_accessItemId_g'
            type: 'string'
          }
          {
            name: 'attributes_accessItemName_s'
            type: 'string'
          }
          {
            name: 'attributes_accessItemType_s'
            type: 'string'
          }
          {
            name: 'attributes_accessProfileIds_after_s'
            type: 'string'
          }
          {
            name: 'attributes_accessProfileIds_before_s'
            type: 'string'
          }
          {
            name: 'attributes_accountActivityId_g'
            type: 'string'
          }
          {
            name: 'attributes_accountName_s'
            type: 'string'
          }
          {
            name: 'attributes_appId_g'
            type: 'string'
          }
          {
            name: 'attributes_approvalSchemes_after_s'
            type: 'string'
          }
          {
            name: 'attributes_approvalSchemes_before_s'
            type: 'string'
          }
          {
            name: 'attributes_attributeName_s'
            type: 'string'
          }
          {
            name: 'attributes_attributeValue_s'
            type: 'string'
          }
          {
            name: 'attributes_cloudAppName_s'
            type: 'string'
          }
          {
            name: 'attributes_comments_s'
            type: 'string'
          }
          {
            name: 'attributes_comment_s'
            type: 'string'
          }
          {
            name: 'attributes_disabled_after_s'
            type: 'string'
          }
          {
            name: 'attributes_disabled_before_s'
            type: 'string'
          }
          {
            name: 'attributes_displayName_after_s'
            type: 'string'
          }
          {
            name: 'attributes_displayName_before_s'
            type: 'string'
          }
          {
            name: 'attributes_errors_s'
            type: 'string'
          }
          {
            name: 'attributes_flow_s'
            type: 'string'
          }
          {
            name: 'attributes_hostName_s'
            type: 'string'
          }
          {
            name: 'attributes_IdnAccessRequestAttributes_s'
            type: 'string'
          }
          {
            name: 'attributes_info_g'
            type: 'string'
          }
          {
            name: 'attributes_info_s'
            type: 'string'
          }
          {
            name: 'attributes_interface_s'
            type: 'string'
          }
          {
            name: 'attributes_operation_s'
            type: 'string'
          }
          {
            name: 'attributes_pod_s'
            type: 'string'
          }
          {
            name: 'type_s'
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
          name: 'Sentinel-SailPointIDN_Events_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SailPointIDN_Events_CL']
        destinations: ['Sentinel-SailPointIDN_Events_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), action_s = tostring(action_s), attributes_provisioningResult_s = tostring(attributes_provisioningResult_s), attributes_requestable_after_s = tostring(attributes_requestable_after_s), attributes_requestable_before_s = tostring(attributes_requestable_before_s), attributes_requestedAppId_s = tostring(attributes_requestedAppId_s), attributes_requestedAppName_s = tostring(attributes_requestedAppName_s), attributes_requestedAppRoleId_g = tostring(attributes_requestedAppRoleId_g), attributes_requestedObjectType_s = tostring(attributes_requestedObjectType_s), attributes_reviewerComment_s = tostring(attributes_reviewerComment_s), attributes_sourceId_s = tostring(attributes_sourceId_s), attributes_sourceName_s = tostring(attributes_sourceName_s), attributes_synchronizeFrom_s = tostring(attributes_synchronizeFrom_s), attributes_synchronizeTo_s = tostring(attributes_synchronizeTo_s), attributes_taskResultId_g = tostring(attributes_taskResultId_g), attributes_userId_s = tostring(attributes_userId_s), created_t = todatetime(created_t), details_g = tostring(details_g), details_s = tostring(details_s), id_g = tostring(id_g), name_s = tostring(name_s), objects_s = tostring(objects_s), operation_s = tostring(operation_s), org_s = tostring(org_s), pod_s = tostring(pod_s), stack_s = tostring(stack_s), status_s = tostring(status_s), synced_t = todatetime(synced_t), target_name_g = tostring(target_name_g), target_name_s = tostring(target_name_s), technicalName_s = tostring(technicalName_s), attributes_previousValue_s = tostring(attributes_previousValue_s), trackingNumber_g = tostring(trackingNumber_g), attributes_preventativeSODResultsJSON_s = tostring(attributes_preventativeSODResultsJSON_s), attributes_org_s = tostring(attributes_org_s), actor_name_g = tostring(actor_name_g), actor_name_s = tostring(actor_name_s), attributes_accessItemId_g = tostring(attributes_accessItemId_g), attributes_accessItemName_s = tostring(attributes_accessItemName_s), attributes_accessItemType_s = tostring(attributes_accessItemType_s), attributes_accessProfileIds_after_s = tostring(attributes_accessProfileIds_after_s), attributes_accessProfileIds_before_s = tostring(attributes_accessProfileIds_before_s), attributes_accountActivityId_g = tostring(attributes_accountActivityId_g), attributes_accountName_s = tostring(attributes_accountName_s), attributes_appId_g = tostring(attributes_appId_g), attributes_approvalSchemes_after_s = tostring(attributes_approvalSchemes_after_s), attributes_approvalSchemes_before_s = tostring(attributes_approvalSchemes_before_s), attributes_attributeName_s = tostring(attributes_attributeName_s), attributes_attributeValue_s = tostring(attributes_attributeValue_s), attributes_cloudAppName_s = tostring(attributes_cloudAppName_s), attributes_comments_s = tostring(attributes_comments_s), attributes_comment_s = tostring(attributes_comment_s), attributes_disabled_after_s = tostring(attributes_disabled_after_s), attributes_disabled_before_s = tostring(attributes_disabled_before_s), attributes_displayName_after_s = tostring(attributes_displayName_after_s), attributes_displayName_before_s = tostring(attributes_displayName_before_s), attributes_errors_s = tostring(attributes_errors_s), attributes_flow_s = tostring(attributes_flow_s), attributes_hostName_s = tostring(attributes_hostName_s), attributes_IdnAccessRequestAttributes_s = tostring(attributes_IdnAccessRequestAttributes_s), attributes_info_g = tostring(attributes_info_g), attributes_info_s = tostring(attributes_info_s), attributes_interface_s = tostring(attributes_interface_s), attributes_operation_s = tostring(attributes_operation_s), attributes_pod_s = tostring(attributes_pod_s), type_s = tostring(type_s)'
        outputStream: 'Custom-SailPointIDN_Events_CL'
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
