// Bicep template for Log Analytics custom table: darktrace_model_alerts_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 79, Deployed columns: 79 (Type column filtered)
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

resource darktracemodelalertsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'darktrace_model_alerts_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'darktrace_model_alerts_CL'
      description: 'Custom table darktrace_model_alerts_CL - imported from JSON schema'
      displayName: 'darktrace_model_alerts_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'dtProduct_s'
          type: 'string'
        }
        {
          name: 'activityId_s'
          type: 'string'
        }
        {
          name: 'identifier_s'
          type: 'string'
        }
        {
          name: 'deviceId_d'
          type: 'real'
        }
        {
          name: 'antigena_b'
          type: 'boolean'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'blocked_b'
          type: 'boolean'
        }
        {
          name: 'mac_s'
          type: 'string'
        }
        {
          name: 'cSensorID_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'uuid_s'
          type: 'string'
        }
        {
          name: 'timestamp_t'
          type: 'string'
        }
        {
          name: 'subject_s'
          type: 'string'
        }
        {
          name: 'recipients_s'
          type: 'string'
        }
        {
          name: 'link_hosts_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'from_s'
          type: 'string'
        }
        {
          name: 'direction_s'
          type: 'string'
        }
        {
          name: 'groupingId_s'
          type: 'string'
        }
        {
          name: 'groupByActivity_b'
          type: 'boolean'
        }
        {
          name: 'summaryFirstSentence_s'
          type: 'string'
        }
        {
          name: 'newEvent_b'
          type: 'boolean'
        }
        {
          name: 'details_s'
          type: 'string'
        }
        {
          name: 'typeLabel_s'
          type: 'string'
        }
        {
          name: 'uuid_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'last_updated_status_d'
          type: 'real'
        }
        {
          name: 'last_updated_d'
          type: 'real'
        }
        {
          name: 'alert_name_s'
          type: 'string'
        }
        {
          name: 'priority_level_s'
          type: 'string'
        }
        {
          name: 'attachment_sha1s_s'
          type: 'string'
        }
        {
          name: 'priority_d'
          type: 'real'
        }
        {
          name: 'ip_address_s'
          type: 'string'
        }
        {
          name: 'child_id_d'
          type: 'real'
        }
        {
          name: 'Severity'
          type: 'real'
        }
        {
          name: 'tags_s'
          type: 'string'
        }
        {
          name: 'sid_d'
          type: 'real'
        }
        {
          name: 'groupPreviousGroups_s'
          type: 'string'
        }
        {
          name: 'currentGroup_s'
          type: 'string'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'anomaly_score_d'
          type: 'real'
        }
        {
          name: 'actions_s'
          type: 'string'
        }
        {
          name: 'cSensorID_s'
          type: 'string'
        }
        {
          name: 'endTime_s'
          type: 'string'
        }
        {
          name: 'startTime_s'
          type: 'string'
        }
        {
          name: 'mitreTechniques_s'
          type: 'string'
        }
        {
          name: 'destMac_s'
          type: 'string'
        }
        {
          name: 'destHost_s'
          type: 'string'
        }
        {
          name: 'destPort_s'
          type: 'string'
        }
        {
          name: 'destIP_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'title_s'
          type: 'string'
        }
        {
          name: 'sourcePort_s'
          type: 'string'
        }
        {
          name: 'sourceHost_s'
          type: 'string'
        }
        {
          name: 'SourceIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'threatID_d'
          type: 'real'
        }
        {
          name: 'pid_d'
          type: 'real'
        }
        {
          name: 'modelName_s'
          type: 'string'
        }
        {
          name: 'breachTime_s'
          type: 'string'
        }
        {
          name: 'score_d'
          type: 'real'
        }
        {
          name: 'sourceMac_s'
          type: 'string'
        }
        {
          name: 'longitude_d'
          type: 'real'
        }
        {
          name: 'externalId_g'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'Category'
          type: 'string'
        }
        {
          name: 'compliance_b'
          type: 'boolean'
        }
        {
          name: 'cSensor_b'
          type: 'boolean'
        }
        {
          name: 'Message'
          type: 'string'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'deviceIP_s'
          type: 'string'
        }
        {
          name: 'time_s'
          type: 'string'
        }
        {
          name: 'hostname_s'
          type: 'string'
        }
        {
          name: 'priority_s'
          type: 'string'
        }
        {
          name: 'friendlyName_s'
          type: 'string'
        }
        {
          name: 'bestDeviceName_s'
          type: 'string'
        }
        {
          name: 'groupCategory_s'
          type: 'string'
        }
        {
          name: 'groupScore_d'
          type: 'string'
        }
        {
          name: 'summary_s'
          type: 'string'
        }
        {
          name: 'triggeredComponents_s'
          type: 'string'
        }
        {
          name: 'breachUrl_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'priority_code_d'
          type: 'real'
        }
        {
          name: 'latitude_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = darktracemodelalertsclTable.name
output tableId string = darktracemodelalertsclTable.id
output provisioningState string = darktracemodelalertsclTable.properties.provisioningState
