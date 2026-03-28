// Bicep template for Log Analytics custom table: Cisco_Umbrella_proxy_CL
// Generated on 2025-09-19 06:42:08 UTC
// Source: JSON schema export
// Original columns: 31, Deployed columns: 31 (Type column filtered)
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

resource ciscoumbrellaproxyclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Cisco_Umbrella_proxy_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Cisco_Umbrella_proxy_CL'
      description: 'Custom table Cisco_Umbrella_proxy_CL - imported from JSON schema'
      displayName: 'Cisco_Umbrella_proxy_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventType_s'
          type: 'string'
        }
        {
          name: 'Rule_ID_s'
          type: 'string'
        }
        {
          name: 'File_Name_s'
          type: 'string'
        }
        {
          name: 'Certificate_Errors_s'
          type: 'string'
        }
        {
          name: 'DLP_Status_S'
          type: 'string'
        }
        {
          name: 'Request_Method_s'
          type: 'string'
        }
        {
          name: 'Identity_Type_s'
          type: 'string'
        }
        {
          name: 'Identities_s'
          type: 'string'
        }
        {
          name: 'Blocked_Categories_s'
          type: 'string'
        }
        {
          name: 'Policy_Identity_Type_s'
          type: 'string'
        }
        {
          name: 'AMP_Score_s'
          type: 'string'
        }
        {
          name: 'AMP_Malware_Name_s'
          type: 'string'
        }
        {
          name: 'AMP_Disposition_s'
          type: 'string'
        }
        {
          name: 'AVDetections_s'
          type: 'string'
        }
        {
          name: 'Categories_s'
          type: 'string'
        }
        {
          name: 'SHA—SHA256_s'
          type: 'string'
        }
        {
          name: 'responseBodySize_d'
          type: 'real'
        }
        {
          name: 'responseSize_d'
          type: 'real'
        }
        {
          name: 'requestSize_d'
          type: 'real'
        }
        {
          name: 'statusCode_s'
          type: 'string'
        }
        {
          name: 'userAgent_s'
          type: 'string'
        }
        {
          name: 'Referer_s'
          type: 'string'
        }
        {
          name: 'Content_Type_s'
          type: 'string'
        }
        {
          name: 'Destination_IP_s'
          type: 'string'
        }
        {
          name: 'External_IP_s'
          type: 'string'
        }
        {
          name: 'Internal_IP_s'
          type: 'string'
        }
        {
          name: 'PolicyIdentity_s'
          type: 'string'
        }
        {
          name: 'Timestamp_t'
          type: 'dateTime'
        }
        {
          name: 'Ruleset_ID_s'
          type: 'string'
        }
        {
          name: 'Destination_List_IDs_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = ciscoumbrellaproxyclTable.name
output tableId string = ciscoumbrellaproxyclTable.id
output provisioningState string = ciscoumbrellaproxyclTable.properties.provisioningState
