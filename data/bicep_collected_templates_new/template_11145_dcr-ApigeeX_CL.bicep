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
// Data Collection Rule for ApigeeX_CL
// ============================================================================
// Generated: 2025-09-19 14:19:52
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 59, DCR columns: 57 (Type column always filtered)
// Output stream: Custom-ApigeeX_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ApigeeX_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ApigeeX_CL': {
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
            name: 'payload_authenticationInfo_principalEmail'
            type: 'string'
          }
          {
            name: 'payload_requestMetadata_callerIp'
            type: 'string'
          }
          {
            name: 'payload_requestMetadata_callerSuppliedUserAgent'
            type: 'string'
          }
          {
            name: 'payload_serviceName'
            type: 'string'
          }
          {
            name: 'payload_methodName'
            type: 'string'
          }
          {
            name: 'payload_authorizationInfo'
            type: 'string'
          }
          {
            name: 'payload_resourceName'
            type: 'string'
          }
          {
            name: 'payload_request_instanceUid'
            type: 'string'
          }
          {
            name: 'payload_request_instance'
            type: 'string'
          }
          {
            name: 'payload_request__type'
            type: 'string'
          }
          {
            name: 'payload_request_resources'
            type: 'string'
          }
          {
            name: 'payload__type'
            type: 'string'
          }
          {
            name: 'payload_request_environmenteploymentType'
            type: 'string'
          }
          {
            name: 'payload_request_environmentisplayName'
            type: 'string'
          }
          {
            name: 'payload_response_type'
            type: 'string'
          }
          {
            name: 'payload_responseisplayName'
            type: 'string'
          }
          {
            name: 'payload_responseeploymentType'
            type: 'string'
          }
          {
            name: 'payloadtatus_code'
            type: 'string'
          }
          {
            name: 'payloadtatus_message'
            type: 'string'
          }
          {
            name: 'payload_requestMetadata_requestAttributesime'
            type: 'string'
          }
          {
            name: 'insert_id'
            type: 'string'
          }
          {
            name: 'resourceype'
            type: 'string'
          }
          {
            name: 'resource_labelservice'
            type: 'string'
          }
          {
            name: 'payload_type'
            type: 'string'
          }
          {
            name: 'payload_request_environmentescription'
            type: 'string'
          }
          {
            name: 'resource_labels_project_id'
            type: 'string'
          }
          {
            name: 'resource_labels_service'
            type: 'string'
          }
          {
            name: 'resource_labels_method'
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
            name: 'payload_request_name'
            type: 'string'
          }
          {
            name: 'payload_request_environment_apiProxyType'
            type: 'string'
          }
          {
            name: 'payload_request_environment_deploymentType'
            type: 'string'
          }
          {
            name: 'payload_request_environment_description'
            type: 'string'
          }
          {
            name: 'payload_request_environment_displayName'
            type: 'string'
          }
          {
            name: 'payload_request_environment_name'
            type: 'string'
          }
          {
            name: 'payload_response__type'
            type: 'string'
          }
          {
            name: 'payload_response_name'
            type: 'string'
          }
          {
            name: 'payload_response_displayName'
            type: 'string'
          }
          {
            name: 'payload_response_deploymentType'
            type: 'string'
          }
          {
            name: 'payload_response_apiProxyType'
            type: 'string'
          }
          {
            name: 'payload_status_code'
            type: 'string'
          }
          {
            name: 'payload_status_message'
            type: 'string'
          }
          {
            name: 'payload_request_reportTime'
            type: 'string'
          }
          {
            name: 'payload_requestMetadata_requestAttributes_time'
            type: 'string'
          }
          {
            name: 'log_name'
            type: 'string'
          }
          {
            name: 'insert_id_'
            type: 'string'
          }
          {
            name: 'severity'
            type: 'string'
          }
          {
            name: 'timestamp'
            type: 'string'
          }
          {
            name: 'resource_type'
            type: 'string'
          }
          {
            name: 'payloaderviceName'
            type: 'string'
          }
          {
            name: 'payload_request_type'
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
          name: 'Sentinel-ApigeeX_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ApigeeX_CL']
        destinations: ['Sentinel-ApigeeX_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), payload_authenticationInfo_principalEmail = tostring(payload_authenticationInfo_principalEmail), payload_requestMetadata_callerIp = tostring(payload_requestMetadata_callerIp), payload_requestMetadata_callerSuppliedUserAgent = tostring(payload_requestMetadata_callerSuppliedUserAgent), payload_serviceName = tostring(payload_serviceName), payload_methodName = tostring(payload_methodName), payload_authorizationInfo = tostring(payload_authorizationInfo), payload_resourceName = tostring(payload_resourceName), payload_request_instanceUid = tostring(payload_request_instanceUid), payload_request_instance = tostring(payload_request_instance), payload_request__type = tostring(payload_request__type), payload_request_resources = tostring(payload_request_resources), payload__type = tostring(payload__type), payload_request_environmenteploymentType = tostring(payload_request_environmenteploymentType), payload_request_environmentisplayName = tostring(payload_request_environmentisplayName), payload_response_type = tostring(payload_response_type), payload_responseisplayName = tostring(payload_responseisplayName), payload_responseeploymentType = tostring(payload_responseeploymentType), payloadtatus_code = tostring(payloadtatus_code), payloadtatus_message = tostring(payloadtatus_message), payload_requestMetadata_requestAttributesime = todatetime(payload_requestMetadata_requestAttributesime), insert_id = tostring(insert_id), resourceype = tostring(resourceype), resource_labelservice = tostring(resource_labelservice), payload_type = tostring(payload_type), payload_request_environmentescription = tostring(payload_request_environmentescription), resource_labels_project_id = tostring(resource_labels_project_id), resource_labels_service = tostring(resource_labels_service), resource_labels_method = tostring(resource_labels_method), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), payload_request_name = tostring(payload_request_name), payload_request_environment_apiProxyType = tostring(payload_request_environment_apiProxyType), payload_request_environment_deploymentType = tostring(payload_request_environment_deploymentType), payload_request_environment_description = tostring(payload_request_environment_description), payload_request_environment_displayName = tostring(payload_request_environment_displayName), payload_request_environment_name = tostring(payload_request_environment_name), payload_response__type = tostring(payload_response__type), payload_response_name = tostring(payload_response_name), payload_response_displayName = tostring(payload_response_displayName), payload_response_deploymentType = tostring(payload_response_deploymentType), payload_response_apiProxyType = tostring(payload_response_apiProxyType), payload_status_code = tostring(payload_status_code), payload_status_message = tostring(payload_status_message), payload_request_reportTime = tostring(payload_request_reportTime), payload_requestMetadata_requestAttributes_time = todatetime(payload_requestMetadata_requestAttributes_time), log_name = tostring(log_name), insert_id_ = tostring(insert_id_), severity = tostring(severity), timestamp = todatetime(timestamp), resource_type = tostring(resource_type), payloaderviceName = tostring(payloaderviceName), payload_request_type = tostring(payload_request_type)'
        outputStream: 'Custom-ApigeeX_CL'
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
