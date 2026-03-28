// Bicep template for Log Analytics custom table: SailPointIDN_Events_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 66, Deployed columns: 66 (Type column filtered)
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

resource sailpointidneventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SailPointIDN_Events_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SailPointIDN_Events_CL'
      description: 'Custom table SailPointIDN_Events_CL - imported from JSON schema'
      displayName: 'SailPointIDN_Events_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
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
          type: 'dateTime'
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
          type: 'dateTime'
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
}

output tableName string = sailpointidneventsclTable.name
output tableId string = sailpointidneventsclTable.id
output provisioningState string = sailpointidneventsclTable.properties.provisioningState
