// Bicep template for Log Analytics custom table: Snowflake_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 75, Deployed columns: 73 (Type column filtered)
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

resource snowflakeclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Snowflake_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Snowflake_CL'
      description: 'Custom table Snowflake_CL - imported from JSON schema'
      displayName: 'Snowflake_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'BYTES_DELETED_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'ROLE_NAME_s'
          type: 'string'
        }
        {
          name: 'QUEUED_PROVISIONING_TIME_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'QUERY_ID_g'
          type: 'string'
        }
        {
          name: 'PERCENTAGE_SCANNED_FROM_CACHE_d'
          type: 'real'
        }
        {
          name: 'QUEUED_OVERLOAD_TIME_d'
          type: 'real'
        }
        {
          name: 'PARTITIONS_TOTAL_d'
          type: 'real'
        }
        {
          name: 'ROWS_DELETED_d'
          type: 'real'
        }
        {
          name: 'ROWS_PRODUCED_d'
          type: 'real'
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
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'ROWS_INSERTED_d'
          type: 'real'
        }
        {
          name: 'START_TIME_t'
          type: 'dateTime'
        }
        {
          name: 'source_table_s'
          type: 'string'
        }
        {
          name: 'SESSION_ID_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'CREDITS_USED_CLOUD_SERVICES_d'
          type: 'real'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'COMPILATION_TIME_d'
          type: 'real'
        }
        {
          name: 'CLUSTER_NUMBER_d'
          type: 'real'
        }
        {
          name: 'END_TIME_t'
          type: 'dateTime'
        }
        {
          name: 'CLIENT_IP_s'
          type: 'string'
        }
        {
          name: 'BYTES_WRITTEN_d'
          type: 'real'
        }
        {
          name: 'BYTES_SPILLED_TO_REMOTE_STORAGE_d'
          type: 'real'
        }
        {
          name: 'BYTES_SPILLED_TO_LOCAL_STORAGE_d'
          type: 'real'
        }
        {
          name: 'BYTES_SENT_OVER_THE_NETWORK_d'
          type: 'real'
        }
        {
          name: 'BYTES_SCANNED_d'
          type: 'real'
        }
        {
          name: 'BYTES_READ_FROM_RESULT_d'
          type: 'real'
        }
        {
          name: 'BYTES_WRITTEN_TO_RESULT_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'LIST_EXTERNAL_FILES_TIME_t'
          type: 'dateTime'
        }
        {
          name: 'IS_SUCCESS_s'
          type: 'string'
        }
        {
          name: 'IS_CLIENT_GENERATED_STATEMENT_b'
          type: 'boolean'
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
          type: 'dateTime'
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
}

output tableName string = snowflakeclTable.name
output tableId string = snowflakeclTable.id
output provisioningState string = snowflakeclTable.properties.provisioningState
