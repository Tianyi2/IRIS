// Bicep template for Log Analytics custom table: BitglassLogs_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 75, Deployed columns: 75 (Type column filtered)
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

resource bitglasslogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BitglassLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BitglassLogs_CL'
      description: 'Custom table BitglassLogs_CL - imported from JSON schema'
      displayName: 'BitglassLogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'docextension_s'
          type: 'string'
        }
        {
          name: 'arguments_s'
          type: 'string'
        }
        {
          name: 'setransactionid_g'
          type: 'string'
        }
        {
          name: 'requestdomain_s'
          type: 'string'
        }
        {
          name: 'long_s'
          type: 'string'
        }
        {
          name: 'webreputation_s'
          type: 'string'
        }
        {
          name: 'IPAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'indexedtime_s'
          type: 'string'
        }
        {
          name: 'destinationip_s'
          type: 'string'
        }
        {
          name: 'city_s'
          type: 'string'
        }
        {
          name: 'size_s'
          type: 'string'
        }
        {
          name: 'bgcategories_s'
          type: 'string'
        }
        {
          name: 'usergroup_s'
          type: 'string'
        }
        {
          name: 'requestmethod_s'
          type: 'string'
        }
        {
          name: 'customlocation_s'
          type: 'string'
        }
        {
          name: 'deviceguid_g'
          type: 'string'
        }
        {
          name: 'email_s'
          type: 'string'
        }
        {
          name: 'bgcloudscore_s'
          type: 'string'
        }
        {
          name: 'firstname_s'
          type: 'string'
        }
        {
          name: 'useragent_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'time_s'
          type: 'string'
        }
        {
          name: 'customcategories_s'
          type: 'string'
        }
        {
          name: 'uri_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'region_s'
          type: 'string'
        }
        {
          name: 'country_s'
          type: 'string'
        }
        {
          name: 'referrer_s'
          type: 'string'
        }
        {
          name: 'countrycode_s'
          type: 'string'
        }
        {
          name: 'webcategories_s'
          type: 'string'
        }
        {
          name: 'uploadedbytes_s'
          type: 'string'
        }
        {
          name: 'lat_s'
          type: 'string'
        }
        {
          name: 'regioncode_s'
          type: 'string'
        }
        {
          name: 'devicehostname_s'
          type: 'string'
        }
        {
          name: 'lastname_s'
          type: 'string'
        }
        {
          name: 'protocol_s'
          type: 'string'
        }
        {
          name: 'syslogheader_s'
          type: 'string'
        }
        {
          name: 'details_s'
          type: 'string'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'patterns_s'
          type: 'string'
        }
        {
          name: 'fileid_g'
          type: 'string'
        }
        {
          name: 'folder_s'
          type: 'string'
        }
        {
          name: 'status_s'
          type: 'string'
        }
        {
          name: 'owner_s'
          type: 'string'
        }
        {
          name: 'deviceguid_s'
          type: 'string'
        }
        {
          name: 'responsecode_s'
          type: 'string'
        }
        {
          name: 'responsecode_d'
          type: 'real'
        }
        {
          name: 'keyword_s'
          type: 'string'
        }
        {
          name: 'docmd5_s'
          type: 'string'
        }
        {
          name: 'threatindicator_s'
          type: 'string'
        }
        {
          name: 'policyid_s'
          type: 'string'
        }
        {
          name: 'docsha1_s'
          type: 'string'
        }
        {
          name: 'docsha256_s'
          type: 'string'
        }
        {
          name: 'doctype_s'
          type: 'string'
        }
        {
          name: 'filelink_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'webcategoryclass_s'
          type: 'string'
        }
        {
          name: 'sharedwith_s'
          type: 'string'
        }
        {
          name: 'user_s'
          type: 'string'
        }
        {
          name: 'pagetitle_s'
          type: 'string'
        }
        {
          name: 'dlppattern_s'
          type: 'string'
        }
        {
          name: 'filename_s'
          type: 'string'
        }
        {
          name: 'emailsenttime_s'
          type: 'string'
        }
        {
          name: 'emailbcc_s'
          type: 'string'
        }
        {
          name: 'emailcc_s'
          type: 'string'
        }
        {
          name: 'emailsubject_s'
          type: 'string'
        }
        {
          name: 'emailto_s'
          type: 'string'
        }
        {
          name: 'emailfrom_s'
          type: 'string'
        }
        {
          name: 'transactionid_s'
          type: 'string'
        }
        {
          name: 'request_s'
          type: 'string'
        }
        {
          name: 'activity_s'
          type: 'string'
        }
        {
          name: 'location_s'
          type: 'string'
        }
        {
          name: 'application_s'
          type: 'string'
        }
        {
          name: 'device_s'
          type: 'string'
        }
        {
          name: 'fileid_s'
          type: 'string'
        }
        {
          name: 'log_type_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bitglasslogsclTable.name
output tableId string = bitglasslogsclTable.id
output provisioningState string = bitglasslogsclTable.properties.provisioningState
