// Bicep template for Log Analytics custom table: InfobloxInsightEvents_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 48, Deployed columns: 46 (Type column filtered)
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

resource infobloxinsighteventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'InfobloxInsightEvents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'InfobloxInsightEvents_CL'
      description: 'Custom table InfobloxInsightEvents_CL - imported from JSON schema'
      displayName: 'InfobloxInsightEvents_CL'
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
          name: 'response_s'
          type: 'string'
        }
        {
          name: 'class_s'
          type: 'string'
        }
        {
          name: 'threatFamily_s'
          type: 'string'
        }
        {
          name: 'threatIndicator_s'
          type: 'string'
        }
        {
          name: 'detected_s'
          type: 'string'
        }
        {
          name: 'property_s'
          type: 'string'
        }
        {
          name: 'user_s'
          type: 'string'
        }
        {
          name: 'threatLevel_s'
          type: 'string'
        }
        {
          name: 'properties_objectGuid_g'
          type: 'string'
        }
        {
          name: 'properties_friendlyName_g'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'name_g'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'kind_s'
          type: 'string'
        }
        {
          name: 'properties_malwareName_s'
          type: 'string'
        }
        {
          name: 'properties_category_s'
          type: 'string'
        }
        {
          name: 'properties_friendlyName_s'
          type: 'string'
        }
        {
          name: 'InfobloxInsightID_g'
          type: 'string'
        }
        {
          name: 'InfobloxInsightfulID_s'
          type: 'string'
        }
        {
          name: 'queryType_s'
          type: 'string'
        }
        {
          name: 'InfobloxInsightLogType_s'
          type: 'string'
        }
        {
          name: 'query_s'
          type: 'string'
        }
        {
          name: 'policy_s'
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
          name: 'responseCountry_s'
          type: 'string'
        }
        {
          name: 'responseRegion_s'
          type: 'string'
        }
        {
          name: 'deviceName_g'
          type: 'string'
        }
        {
          name: 'osVersion_s'
          type: 'string'
        }
        {
          name: 'confidenceLevel_s'
          type: 'string'
        }
        {
          name: 'deviceCountry_s'
          type: 'string'
        }
        {
          name: 'deviceName_s'
          type: 'string'
        }
        {
          name: 'deviceRegion_s'
          type: 'string'
        }
        {
          name: 'dhcpFingerprint_s'
          type: 'string'
        }
        {
          name: 'dnsView_s'
          type: 'string'
        }
        {
          name: 'feed_s'
          type: 'string'
        }
        {
          name: 'macAddress_s'
          type: 'string'
        }
        {
          name: 'source_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'deviceIp_s'
          type: 'string'
        }
        {
          name: 'InsightID_g'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = infobloxinsighteventsclTable.name
output tableId string = infobloxinsighteventsclTable.id
output provisioningState string = infobloxinsighteventsclTable.properties.provisioningState
