// Bicep template for Log Analytics custom table: CortexXDR_Incidents_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 43, Deployed columns: 41 (Type column filtered)
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

resource cortexxdrincidentsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CortexXDR_Incidents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CortexXDR_Incidents_CL'
      description: 'Custom table CortexXDR_Incidents_CL - imported from JSON schema'
      displayName: 'CortexXDR_Incidents_CL'
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
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'alert_count_d'
          type: 'real'
        }
        {
          name: 'low_severity_alert_count_d'
          type: 'real'
        }
        {
          name: 'med_severity_alert_count_d'
          type: 'real'
        }
        {
          name: 'high_severity_alert_count_d'
          type: 'real'
        }
        {
          name: 'user_count_d'
          type: 'real'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'host_count_d'
          type: 'real'
        }
        {
          name: 'starred_b'
          type: 'boolean'
        }
        {
          name: 'hosts_s'
          type: 'string'
        }
        {
          name: 'users_s'
          type: 'string'
        }
        {
          name: 'incident_sources_s'
          type: 'string'
        }
        {
          name: 'wildfire_hits_d'
          type: 'real'
        }
        {
          name: 'alerts_grouping_status_s'
          type: 'string'
        }
        {
          name: 'mitre_tactics_ids_and_names_s'
          type: 'string'
        }
        {
          name: 'xdr_url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'modification_time_d'
          type: 'real'
        }
        {
          name: 'creation_time_d'
          type: 'real'
        }
        {
          name: 'incident_id_s'
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
          name: 'aggregated_score_d'
          type: 'real'
        }
        {
          name: 'original_tags_s'
          type: 'string'
        }
        {
          name: 'manual_description_s'
          type: 'string'
        }
        {
          name: 'predicted_score_d'
          type: 'real'
        }
        {
          name: 'tags_s'
          type: 'string'
        }
        {
          name: 'manual_severity_s'
          type: 'string'
        }
        {
          name: 'critical_severity_alert_count_d'
          type: 'real'
        }
        {
          name: 'assigned_user_mail_s'
          type: 'string'
        }
        {
          name: 'assigned_user_pretty_name_s'
          type: 'string'
        }
        {
          name: 'notes_s'
          type: 'string'
        }
        {
          name: 'resolve_comment_s'
          type: 'string'
        }
        {
          name: 'resolved_timestamp_d'
          type: 'real'
        }
        {
          name: 'mitre_techniques_ids_and_names_s'
          type: 'string'
        }
        {
          name: 'alert_categories_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = cortexxdrincidentsclTable.name
output tableId string = cortexxdrincidentsclTable.id
output provisioningState string = cortexxdrincidentsclTable.properties.provisioningState
