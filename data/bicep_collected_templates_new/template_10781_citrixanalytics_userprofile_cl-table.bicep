// Bicep template for Log Analytics custom table: CitrixAnalytics_userProfile_CL
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 21, Deployed columns: 21 (Type column filtered)
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

resource citrixanalyticsuserprofileclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CitrixAnalytics_userProfile_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CitrixAnalytics_userProfile_CL'
      description: 'Custom table CitrixAnalytics_userProfile_CL - imported from JSON schema'
      displayName: 'CitrixAnalytics_userProfile_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'app_s'
          type: 'string'
        }
        {
          name: 'uploaded_file_cnt_d'
          type: 'real'
        }
        {
          name: 'uploaded_bytes_d'
          type: 'real'
        }
        {
          name: 'tenant_id_s'
          type: 'string'
        }
        {
          name: 'shared_file_cnt_d'
          type: 'real'
        }
        {
          name: 'session_domain_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'entity_type_s'
          type: 'string'
        }
        {
          name: 'entity_id_s'
          type: 'string'
        }
        {
          name: 'downloaded_file_cnt_d'
          type: 'real'
        }
        {
          name: 'downloaded_bytes_d'
          type: 'real'
        }
        {
          name: 'device_s'
          type: 'string'
        }
        {
          name: 'deleted_file_cnt_d'
          type: 'real'
        }
        {
          name: 'data_usage_bytes_d'
          type: 'real'
        }
        {
          name: 'cur_riskscore_d'
          type: 'real'
        }
        {
          name: 'country_s'
          type: 'string'
        }
        {
          name: 'cnt_d'
          type: 'real'
        }
        {
          name: 'city_s'
          type: 'string'
        }
        {
          name: 'user_samaccountname_s'
          type: 'string'
        }
        {
          name: 'version_d'
          type: 'real'
        }
      ]
    }
  }
}

output tableName string = citrixanalyticsuserprofileclTable.name
output tableId string = citrixanalyticsuserprofileclTable.id
output provisioningState string = citrixanalyticsuserprofileclTable.properties.provisioningState
