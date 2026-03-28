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
// Data Collection Rule for Lookout_CL
// ============================================================================
// Generated: 2025-09-19 14:20:23
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 35, DCR columns: 35 (Type column always filtered)
// Output stream: Custom-Lookout_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Lookout_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Lookout_CL': {
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
            name: 'target_osVersion_s'
            type: 'string'
          }
          {
            name: 'target_platform_s'
            type: 'string'
          }
          {
            name: 'target_emailAddress_s'
            type: 'string'
          }
          {
            name: 'target_id_g'
            type: 'string'
          }
          {
            name: 'target_type_s'
            type: 'string'
          }
          {
            name: 'details_pcpDeviceResponse_s'
            type: 'string'
          }
          {
            name: 'details_pcpReportingReason_s'
            type: 'string'
          }
          {
            name: 'details_assessments_s'
            type: 'dynamic'
          }
          {
            name: 'details_classifications_s'
            type: 'dynamic'
          }
          {
            name: 'details_severity_s'
            type: 'string'
          }
          {
            name: 'details_action_s'
            type: 'string'
          }
          {
            name: 'details_id_g'
            type: 'string'
          }
          {
            name: 'details_type_s'
            type: 'string'
          }
          {
            name: 'actor_id_g'
            type: 'string'
          }
          {
            name: 'actor_type_s'
            type: 'string'
          }
          {
            name: 'changeType_s'
            type: 'string'
          }
          {
            name: 'eventTime_t'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'details_activationStatus_s'
            type: 'string'
          }
          {
            name: 'details_securityStatus_s'
            type: 'string'
          }
          {
            name: 'details_protectionStatus_s'
            type: 'string'
          }
          {
            name: 'updatedDetails_s'
            type: 'dynamic'
          }
          {
            name: 'details_description_s'
            type: 'string'
          }
          {
            name: 'target_manufacturer_s'
            type: 'string'
          }
          {
            name: 'details_applicationName_s'
            type: 'string'
          }
          {
            name: 'details_path_s'
            type: 'string'
          }
          {
            name: 'details_fileName_s'
            type: 'string'
          }
          {
            name: 'details_packageSha_s'
            type: 'string'
          }
          {
            name: 'details_attributeChanges_s'
            type: 'dynamic'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'id_s'
            type: 'string'
          }
          {
            name: 'details_packageName_s'
            type: 'string'
          }
          {
            name: 'target_model_s'
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
          name: 'Sentinel-Lookout_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Lookout_CL']
        destinations: ['Sentinel-Lookout_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), target_osVersion_s = tostring(target_osVersion_s), target_platform_s = tostring(target_platform_s), target_emailAddress_s = tostring(target_emailAddress_s), target_id_g = tostring(target_id_g), target_type_s = tostring(target_type_s), details_pcpDeviceResponse_s = tostring(details_pcpDeviceResponse_s), details_pcpReportingReason_s = tostring(details_pcpReportingReason_s), details_assessments_s = todynamic(details_assessments_s), details_classifications_s = todynamic(details_classifications_s), details_severity_s = tostring(details_severity_s), details_action_s = tostring(details_action_s), details_id_g = tostring(details_id_g), details_type_s = tostring(details_type_s), actor_id_g = tostring(actor_id_g), actor_type_s = tostring(actor_type_s), changeType_s = tostring(changeType_s), eventTime_t = todatetime(eventTime_t), SourceSystem = tostring(SourceSystem), details_activationStatus_s = tostring(details_activationStatus_s), details_securityStatus_s = tostring(details_securityStatus_s), details_protectionStatus_s = tostring(details_protectionStatus_s), updatedDetails_s = todynamic(updatedDetails_s), details_description_s = tostring(details_description_s), target_manufacturer_s = tostring(target_manufacturer_s), details_applicationName_s = tostring(details_applicationName_s), details_path_s = tostring(details_path_s), details_fileName_s = tostring(details_fileName_s), details_packageSha_s = tostring(details_packageSha_s), details_attributeChanges_s = todynamic(details_attributeChanges_s), type_s = tostring(type_s), id_s = tostring(id_s), details_packageName_s = tostring(details_packageName_s), target_model_s = tostring(target_model_s)'
        outputStream: 'Custom-Lookout_CL'
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
