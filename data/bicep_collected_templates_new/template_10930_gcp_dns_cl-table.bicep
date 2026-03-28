// Bicep template for Log Analytics custom table: GCP_DNS_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 45, Deployed columns: 43 (Type column filtered)
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

resource gcpdnsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'GCP_DNS_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'GCP_DNS_CL'
      description: 'Custom table GCP_DNS_CL - imported from JSON schema'
      displayName: 'GCP_DNS_CL'
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
          name: 'resource_labels_project_id_s'
          type: 'string'
        }
        {
          name: 'resource_labels_target_type_s'
          type: 'string'
        }
        {
          name: 'resource_labels_source_type_s'
          type: 'string'
        }
        {
          name: 'resource_labels_target_name_s'
          type: 'string'
        }
        {
          name: 'resource_labels_location_s'
          type: 'string'
        }
        {
          name: 'payload_vmProjectId_s'
          type: 'string'
        }
        {
          name: 'payload_protocol_s'
          type: 'string'
        }
        {
          name: 'payload_queryType_s'
          type: 'string'
        }
        {
          name: 'payload_rdata_s'
          type: 'string'
        }
        {
          name: 'payload_vmInstanceId_d'
          type: 'real'
        }
        {
          name: 'payload_vmInstanceIdString_s'
          type: 'string'
        }
        {
          name: 'payload_vmInstanceName_s'
          type: 'string'
        }
        {
          name: 'payload_responseCode_s'
          type: 'string'
        }
        {
          name: 'payload_authAnswer_b'
          type: 'boolean'
        }
        {
          name: 'payload_queryName_s'
          type: 'string'
        }
        {
          name: 'payload_vmZoneName_s'
          type: 'string'
        }
        {
          name: 'payload_sourceNetwork_s'
          type: 'string'
        }
        {
          name: 'resource_type_s'
          type: 'string'
        }
        {
          name: 'timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'insert_id_s'
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
          name: 'resource_labels_zone_name_s'
          type: 'string'
        }
        {
          name: 'payload__type_s'
          type: 'string'
        }
        {
          name: 'payload_authenticationInfo_principalEmail_s'
          type: 'string'
        }
        {
          name: 'payload_serverLatency_d'
          type: 'real'
        }
        {
          name: 'payload_requestMetadata_requestAttributes_time_t'
          type: 'dateTime'
        }
        {
          name: 'payload_methodName_s'
          type: 'string'
        }
        {
          name: 'payload_authorizationInfo_s'
          type: 'string'
        }
        {
          name: 'payload_resourceName_s'
          type: 'string'
          dataTypeHint: 2
        }
        {
          name: 'payload_request__type_s'
          type: 'string'
        }
        {
          name: 'payload_request_project_s'
          type: 'string'
        }
        {
          name: 'resource_labels_policy_name_s'
          type: 'string'
        }
        {
          name: 'payload_request_managedZone_s'
          type: 'string'
        }
        {
          name: 'log_name_s'
          type: 'string'
        }
        {
          name: 'payload_serviceName_s'
          type: 'string'
        }
        {
          name: 'payload_sourceIP_s'
          type: 'string'
          dataTypeHint: 3
        }
      ]
    }
  }
}

output tableName string = gcpdnsclTable.name
output tableId string = gcpdnsclTable.id
output provisioningState string = gcpdnsclTable.properties.provisioningState
