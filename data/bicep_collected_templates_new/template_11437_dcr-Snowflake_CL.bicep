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
// Data Collection Rule for Snowflake_CL
// ============================================================================
// Generated: 2025-09-19 14:20:32
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 75, DCR columns: 73 (Type column always filtered)
// Output stream: Custom-Snowflake_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Snowflake_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Snowflake_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'BYTES_DELETED_d'
            type: 'string'
          }
          {
            name: 'REPORTED_CLIENT_VERSION_s'
            type: 'string'
          }
          {
            name: 'REPORTED_CLIENT_TYPE_s'
            type: 'string'
          }
          {
            name: 'RELEASE_VERSION_s'
            type: 'string'
          }
          {
            name: 'RELATED_EVENT_ID_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'QUEUED_REPAIR_TIME_d'
            type: 'string'
          }
          {
            name: 'ROLE_NAME_s'
            type: 'string'
          }
          {
            name: 'QUEUED_PROVISIONING_TIME_d'
            type: 'string'
          }
          {
            name: 'QUERY_TYPE_s'
            type: 'string'
          }
          {
            name: 'QUERY_TEXT_s'
            type: 'string'
          }
          {
            name: 'QUERY_TAG_s'
            type: 'string'
          }
          {
            name: 'QUERY_LOAD_PERCENT_d'
            type: 'string'
          }
          {
            name: 'QUERY_ID_g'
            type: 'string'
          }
          {
            name: 'PERCENTAGE_SCANNED_FROM_CACHE_d'
            type: 'string'
          }
          {
            name: 'QUEUED_OVERLOAD_TIME_d'
            type: 'string'
          }
          {
            name: 'PARTITIONS_TOTAL_d'
            type: 'string'
          }
          {
            name: 'ROWS_DELETED_d'
            type: 'string'
          }
          {
            name: 'ROWS_PRODUCED_d'
            type: 'string'
          }
          {
            name: 'WAREHOUSE_NAME_s'
            type: 'string'
          }
          {
            name: 'WAREHOUSE_ID_s'
            type: 'string'
          }
          {
            name: 'USER_NAME_s'
            type: 'string'
          }
          {
            name: 'TRANSACTION_BLOCKED_TIME_s'
            type: 'string'
          }
          {
            name: 'TOTAL_ELAPSED_TIME_s'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
          }
          {
            name: 'ROWS_INSERTED_d'
            type: 'string'
          }
          {
            name: 'START_TIME_t'
            type: 'string'
          }
          {
            name: 'source_table_s'
            type: 'string'
          }
          {
            name: 'SESSION_ID_d'
            type: 'string'
          }
          {
            name: 'SCHEMA_NAME_s'
            type: 'string'
          }
          {
            name: 'SCHEMA_ID_s'
            type: 'string'
          }
          {
            name: 'ROWS_UPDATED_s'
            type: 'string'
          }
          {
            name: 'ROWS_UNLOADED_s'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'PARTITIONS_SCANNED_s'
            type: 'string'
          }
          {
            name: 'OUTBOUND_DATA_TRANSFER_BYTES_d'
            type: 'string'
          }
          {
            name: 'MG'
            type: 'string'
          }
          {
            name: 'DATABASE_NAME_s'
            type: 'string'
          }
          {
            name: 'DATABASE_ID_d'
            type: 'string'
          }
          {
            name: 'CREDITS_USED_CLOUD_SERVICES_d'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'COMPILATION_TIME_d'
            type: 'string'
          }
          {
            name: 'CLUSTER_NUMBER_d'
            type: 'string'
          }
          {
            name: 'END_TIME_t'
            type: 'string'
          }
          {
            name: 'CLIENT_IP_s'
            type: 'string'
          }
          {
            name: 'BYTES_WRITTEN_d'
            type: 'string'
          }
          {
            name: 'BYTES_SPILLED_TO_REMOTE_STORAGE_d'
            type: 'string'
          }
          {
            name: 'BYTES_SPILLED_TO_LOCAL_STORAGE_d'
            type: 'string'
          }
          {
            name: 'BYTES_SENT_OVER_THE_NETWORK_d'
            type: 'string'
          }
          {
            name: 'BYTES_SCANNED_d'
            type: 'string'
          }
          {
            name: 'BYTES_READ_FROM_RESULT_d'
            type: 'string'
          }
          {
            name: 'BYTES_WRITTEN_TO_RESULT_d'
            type: 'string'
          }
          {
            name: 'ERROR_CODE_s'
            type: 'string'
          }
          {
            name: 'ERROR_MESSAGE_s'
            type: 'string'
          }
          {
            name: 'EVENT_ID_d'
            type: 'string'
          }
          {
            name: 'ManagementGroupName'
            type: 'string'
          }
          {
            name: 'LIST_EXTERNAL_FILES_TIME_t'
            type: 'string'
          }
          {
            name: 'IS_SUCCESS_s'
            type: 'string'
          }
          {
            name: 'IS_CLIENT_GENERATED_STATEMENT_b'
            type: 'string'
          }
          {
            name: 'INBOUND_DATA_TRANSFER_BYTES_s'
            type: 'string'
          }
          {
            name: 'FIRST_AUTHENTICATION_FACTOR_s'
            type: 'string'
          }
          {
            name: 'EXTERNAL_FUNCTION_TOTAL_SENT_ROWS_s'
            type: 'string'
          }
          {
            name: 'EXTERNAL_FUNCTION_TOTAL_SENT_BYTES_s'
            type: 'string'
          }
          {
            name: 'EXTERNAL_FUNCTION_TOTAL_RECEIVED_ROWS_s'
            type: 'string'
          }
          {
            name: 'EXTERNAL_FUNCTION_TOTAL_RECEIVED_BYTES_s'
            type: 'string'
          }
          {
            name: 'EXTERNAL_FUNCTION_TOTAL_INVOCATIONS_s'
            type: 'string'
          }
          {
            name: 'EXECUTION_TIME_s'
            type: 'string'
          }
          {
            name: 'EXECUTION_STATUS_s'
            type: 'string'
          }
          {
            name: 'EVENT_TYPE_s'
            type: 'string'
          }
          {
            name: 'EVENT_TIMESTAMP_t'
            type: 'string'
          }
          {
            name: 'WAREHOUSE_SIZE_s'
            type: 'string'
          }
          {
            name: 'WAREHOUSE_TYPE_s'
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
          name: 'Sentinel-Snowflake_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Snowflake_CL']
        destinations: ['Sentinel-Snowflake_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), BYTES_DELETED_d = toreal(BYTES_DELETED_d), REPORTED_CLIENT_VERSION_s = tostring(REPORTED_CLIENT_VERSION_s), REPORTED_CLIENT_TYPE_s = tostring(REPORTED_CLIENT_TYPE_s), RELEASE_VERSION_s = tostring(RELEASE_VERSION_s), RELATED_EVENT_ID_s = tostring(RELATED_EVENT_ID_s), RawData = tostring(RawData), QUEUED_REPAIR_TIME_d = toreal(QUEUED_REPAIR_TIME_d), ROLE_NAME_s = tostring(ROLE_NAME_s), QUEUED_PROVISIONING_TIME_d = toreal(QUEUED_PROVISIONING_TIME_d), QUERY_TYPE_s = tostring(QUERY_TYPE_s), QUERY_TEXT_s = tostring(QUERY_TEXT_s), QUERY_TAG_s = tostring(QUERY_TAG_s), QUERY_LOAD_PERCENT_d = toreal(QUERY_LOAD_PERCENT_d), QUERY_ID_g = tostring(QUERY_ID_g), PERCENTAGE_SCANNED_FROM_CACHE_d = toreal(PERCENTAGE_SCANNED_FROM_CACHE_d), QUEUED_OVERLOAD_TIME_d = toreal(QUEUED_OVERLOAD_TIME_d), PARTITIONS_TOTAL_d = toreal(PARTITIONS_TOTAL_d), ROWS_DELETED_d = toreal(ROWS_DELETED_d), ROWS_PRODUCED_d = toreal(ROWS_PRODUCED_d), WAREHOUSE_NAME_s = tostring(WAREHOUSE_NAME_s), WAREHOUSE_ID_s = tostring(WAREHOUSE_ID_s), USER_NAME_s = tostring(USER_NAME_s), TRANSACTION_BLOCKED_TIME_s = tostring(TRANSACTION_BLOCKED_TIME_s), TOTAL_ELAPSED_TIME_s = tostring(TOTAL_ELAPSED_TIME_s), TenantId = toguid(TenantId), ROWS_INSERTED_d = toreal(ROWS_INSERTED_d), START_TIME_t = todatetime(START_TIME_t), source_table_s = tostring(source_table_s), SESSION_ID_d = toreal(SESSION_ID_d), SCHEMA_NAME_s = tostring(SCHEMA_NAME_s), SCHEMA_ID_s = tostring(SCHEMA_ID_s), ROWS_UPDATED_s = tostring(ROWS_UPDATED_s), ROWS_UNLOADED_s = tostring(ROWS_UNLOADED_s), SourceSystem = tostring(SourceSystem), PARTITIONS_SCANNED_s = tostring(PARTITIONS_SCANNED_s), OUTBOUND_DATA_TRANSFER_BYTES_d = toreal(OUTBOUND_DATA_TRANSFER_BYTES_d), MG = tostring(MG), DATABASE_NAME_s = tostring(DATABASE_NAME_s), DATABASE_ID_d = toreal(DATABASE_ID_d), CREDITS_USED_CLOUD_SERVICES_d = toreal(CREDITS_USED_CLOUD_SERVICES_d), Computer = tostring(Computer), COMPILATION_TIME_d = toreal(COMPILATION_TIME_d), CLUSTER_NUMBER_d = toreal(CLUSTER_NUMBER_d), END_TIME_t = todatetime(END_TIME_t), CLIENT_IP_s = tostring(CLIENT_IP_s), BYTES_WRITTEN_d = toreal(BYTES_WRITTEN_d), BYTES_SPILLED_TO_REMOTE_STORAGE_d = toreal(BYTES_SPILLED_TO_REMOTE_STORAGE_d), BYTES_SPILLED_TO_LOCAL_STORAGE_d = toreal(BYTES_SPILLED_TO_LOCAL_STORAGE_d), BYTES_SENT_OVER_THE_NETWORK_d = toreal(BYTES_SENT_OVER_THE_NETWORK_d), BYTES_SCANNED_d = toreal(BYTES_SCANNED_d), BYTES_READ_FROM_RESULT_d = toreal(BYTES_READ_FROM_RESULT_d), BYTES_WRITTEN_TO_RESULT_d = toreal(BYTES_WRITTEN_TO_RESULT_d), ERROR_CODE_s = tostring(ERROR_CODE_s), ERROR_MESSAGE_s = tostring(ERROR_MESSAGE_s), EVENT_ID_d = toreal(EVENT_ID_d), ManagementGroupName = tostring(ManagementGroupName), LIST_EXTERNAL_FILES_TIME_t = todatetime(LIST_EXTERNAL_FILES_TIME_t), IS_SUCCESS_s = tostring(IS_SUCCESS_s), IS_CLIENT_GENERATED_STATEMENT_b = tobool(IS_CLIENT_GENERATED_STATEMENT_b), INBOUND_DATA_TRANSFER_BYTES_s = tostring(INBOUND_DATA_TRANSFER_BYTES_s), FIRST_AUTHENTICATION_FACTOR_s = tostring(FIRST_AUTHENTICATION_FACTOR_s), EXTERNAL_FUNCTION_TOTAL_SENT_ROWS_s = tostring(EXTERNAL_FUNCTION_TOTAL_SENT_ROWS_s), EXTERNAL_FUNCTION_TOTAL_SENT_BYTES_s = tostring(EXTERNAL_FUNCTION_TOTAL_SENT_BYTES_s), EXTERNAL_FUNCTION_TOTAL_RECEIVED_ROWS_s = tostring(EXTERNAL_FUNCTION_TOTAL_RECEIVED_ROWS_s), EXTERNAL_FUNCTION_TOTAL_RECEIVED_BYTES_s = tostring(EXTERNAL_FUNCTION_TOTAL_RECEIVED_BYTES_s), EXTERNAL_FUNCTION_TOTAL_INVOCATIONS_s = tostring(EXTERNAL_FUNCTION_TOTAL_INVOCATIONS_s), EXECUTION_TIME_s = tostring(EXECUTION_TIME_s), EXECUTION_STATUS_s = tostring(EXECUTION_STATUS_s), EVENT_TYPE_s = tostring(EVENT_TYPE_s), EVENT_TIMESTAMP_t = todatetime(EVENT_TIMESTAMP_t), WAREHOUSE_SIZE_s = tostring(WAREHOUSE_SIZE_s), WAREHOUSE_TYPE_s = tostring(WAREHOUSE_TYPE_s)'
        outputStream: 'Custom-Snowflake_CL'
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
