// Bicep template for Log Analytics custom table: Talon_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 44, Deployed columns: 42 (Type column filtered)
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

resource talonclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Talon_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Talon_CL'
      description: 'Custom table Talon_CL - imported from JSON schema'
      displayName: 'Talon_CL'
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
          name: 'eventCategory_s'
          type: 'string'
        }
        {
          name: 'eventType_s'
          type: 'string'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'action_s'
          type: 'string'
        }
        {
          name: 'userEmail_s'
          type: 'string'
        }
        {
          name: 'deviceHostname_s'
          type: 'string'
        }
        {
          name: 'IPAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'browserVersion_s'
          type: 'string'
        }
        {
          name: 'userAgent_s'
          type: 'string'
        }
        {
          name: 'osPlatform_s'
          type: 'string'
        }
        {
          name: 'osVersion_s'
          type: 'string'
        }
        {
          name: 'mitreTechniques_s'
          type: 'string'
        }
        {
          name: 'policyRule_s'
          type: 'string'
        }
        {
          name: 'eventDetails_protocol_s'
          type: 'string'
        }
        {
          name: 'eventDetails_method_s'
          type: 'string'
        }
        {
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'id_s'
          type: 'string'
        }
        {
          name: 'time_s'
          type: 'string'
        }
        {
          name: 'eventDetails_type_s'
          type: 'string'
        }
        {
          name: 'eventDetails_path_s'
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
          name: 'eventDetails_loginUsername_s'
          type: 'string'
        }
        {
          name: 'eventDetails_matchedURL_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'eventDetails_categories_s'
          type: 'string'
        }
        {
          name: 'eventDetails_reasons_s'
          type: 'string'
        }
        {
          name: 'eventDetails_failedAttempts_d'
          type: 'real'
        }
        {
          name: 'eventDetails_engine_s'
          type: 'string'
        }
        {
          name: 'eventDetails_activity_s'
          type: 'string'
        }
        {
          name: 'eventDetails_printerName_s'
          type: 'string'
        }
        {
          name: 'eventDetails_fromURL_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'eventDetails_installSource_s'
          type: 'string'
        }
        {
          name: 'eventDetails_id_s'
          type: 'string'
        }
        {
          name: 'eventDetails_version_s'
          type: 'string'
        }
        {
          name: 'eventDetails_name_s'
          type: 'string'
        }
        {
          name: 'description_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = talonclTable.name
output tableId string = talonclTable.id
output provisioningState string = talonclTable.properties.provisioningState
