// Bicep template for Log Analytics custom table: ApigeeX_CL
// Generated on 2025-09-19 14:13:48 UTC
// Source: JSON schema export
// Original columns: 59, Deployed columns: 57 (Type column filtered)
// Underscore columns filtered out
// dataTypeHint values: 0=Uri, 1=Guid, 2=ArmPath, 3=IP

@description('Log Analytics Workspace name')
param workspaceName string

@description('Table plan - Analytics or Basic')
@allowed(['Analytics', 'Basic'])
param tablePlan string = 'Analytics'

@description('Data retention period in days')
@minValue(4)
@maxValue(730)
param retentionInDays int = 30

@description('Total retention period in days')
@minValue(4)
@maxValue(4383)
param totalRetentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' existing = {
  name: workspaceName
}

resource apigeexclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ApigeeX_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ApigeeX_CL'
      description: 'Custom table ApigeeX_CL - imported from JSON schema'
      displayName: 'ApigeeX_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'payload_authenticationInfo_principalEmail'
          type: 'string'
        }
        {
          name: 'payload_requestMetadata_callerIp'
          type: 'string'
          dataTypeHint: 3
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
          dataTypeHint: 2
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
          type: 'dateTime'
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
          type: 'dateTime'
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
          type: 'dateTime'
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
}

output tableName string = apigeexclTable.name
output tableId string = apigeexclTable.id
output provisioningState string = apigeexclTable.properties.provisioningState
