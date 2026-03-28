// Bicep template for Log Analytics custom table: CyberArkEPM_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 85, Deployed columns: 83 (Type column filtered)
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

resource cyberarkepmclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CyberArkEPM_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CyberArkEPM_CL'
      description: 'Custom table CyberArkEPM_CL - imported from JSON schema'
      displayName: 'CyberArkEPM_CL'
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
          name: 'productName_s'
          type: 'string'
        }
        {
          name: 'fileDescription_s'
          type: 'string'
        }
        {
          name: 'filePath_s'
          type: 'string'
        }
        {
          name: 'company_s'
          type: 'string'
        }
        {
          name: 'packageName_s'
          type: 'string'
        }
        {
          name: 'threatProtectionAction_s'
          type: 'string'
        }
        {
          name: 'originalFileName_s'
          type: 'string'
        }
        {
          name: 'productVersion_s'
          type: 'string'
        }
        {
          name: 'fileName_s'
          type: 'string'
        }
        {
          name: 'sourceName_s'
          type: 'string'
        }
        {
          name: 'sourceType_s'
          type: 'string'
        }
        {
          name: 'policyName_s'
          type: 'string'
        }
        {
          name: 'event_type_s'
          type: 'string'
        }
        {
          name: 'lastAgentId_g'
          type: 'string'
        }
        {
          name: 'defenceActionId_d'
          type: 'real'
        }
        {
          name: 'deceptionType_d'
          type: 'real'
        }
        {
          name: 'userName_s'
          type: 'string'
        }
        {
          name: 'fileVersion_s'
          type: 'string'
        }
        {
          name: 'modificationTime_t'
          type: 'dateTime'
        }
        {
          name: 'userIsAdmin_b'
          type: 'boolean'
        }
        {
          name: 'sourceProcessSigner_s'
          type: 'string'
        }
        {
          name: 'sourceProcessPublisher_s'
          type: 'string'
        }
        {
          name: 'sourceProcessHash_s'
          type: 'string'
        }
        {
          name: 'sourceProcessUsername_s'
          type: 'string'
        }
        {
          name: 'sourceProcessCommandLine_s'
          type: 'string'
        }
        {
          name: 'accessTargetName_s'
          type: 'string'
        }
        {
          name: 'justification_s'
          type: 'string'
        }
        {
          name: 'logonStatusId_d'
          type: 'real'
        }
        {
          name: 'logonAttemptTypeId_d'
          type: 'real'
        }
        {
          name: 'winEventRecordId_d'
          type: 'real'
        }
        {
          name: 'winEventType_d'
          type: 'real'
        }
        {
          name: 'owner_s'
          type: 'string'
        }
        {
          name: 'displayName_s'
          type: 'string'
        }
        {
          name: 'processCommandLine_s'
          type: 'string'
        }
        {
          name: 'accessTargetType_s'
          type: 'string'
        }
        {
          name: 'accessAction_s'
          type: 'string'
        }
        {
          name: 'agentEventCount_d'
          type: 'real'
        }
        {
          name: 'aggregatedBy_s'
          type: 'string'
        }
        {
          name: 'skipped_b'
          type: 'boolean'
        }
        {
          name: 'skippedCount_d'
          type: 'real'
        }
        {
          name: 'fileLocation_s'
          type: 'string'
        }
        {
          name: 'hash_s'
          type: 'string'
        }
        {
          name: 'lastEventDisplayName_s'
          type: 'string'
        }
        {
          name: 'fileQualifier_s'
          type: 'string'
        }
        {
          name: 'bundleId_s'
          type: 'string'
        }
        {
          name: 'bundleVersion_s'
          type: 'string'
        }
        {
          name: 'bundleName_s'
          type: 'string'
        }
        {
          name: 'applicationSubType_s'
          type: 'string'
        }
        {
          name: 'justificationEmail_s'
          type: 'string'
        }
        {
          name: 'fileAccessPermission_s'
          type: 'string'
        }
        {
          name: 'adminTaskId_s'
          type: 'string'
        }
        {
          name: 'policyId_d'
          type: 'real'
        }
        {
          name: 'set_name_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'publisher_s'
          type: 'string'
        }
        {
          name: 'evidences_s'
          type: 'string'
        }
        {
          name: 'totalEvents_d'
          type: 'real'
        }
        {
          name: 'eventType_s'
          type: 'string'
        }
        {
          name: 'agentId_g'
          type: 'string'
        }
        {
          name: 'appPackageDisplayName_s'
          type: 'string'
        }
        {
          name: 'url_s'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'mimeType_s'
          type: 'string'
        }
        {
          name: 'CLSID_s'
          type: 'string'
        }
        {
          name: 'fileSize_d'
          type: 'real'
        }
        {
          name: 'firstEventUserName_s'
          type: 'string'
        }
        {
          name: 'firstEventDate_t'
          type: 'dateTime'
        }
        {
          name: 'affectedUsers_d'
          type: 'real'
        }
        {
          name: 'affectedComputers_d'
          type: 'real'
        }
        {
          name: 'lastEventFileName_s'
          type: 'string'
        }
        {
          name: 'threatDetectionAction_s'
          type: 'string'
        }
        {
          name: 'lastEventJustification_s'
          type: 'string'
        }
        {
          name: 'lastEventUserName_s'
          type: 'string'
        }
        {
          name: 'lastEventDate_t'
          type: 'dateTime'
        }
        {
          name: 'lastEventSourceName_s'
          type: 'string'
        }
        {
          name: 'lastEventSourceType_s'
          type: 'string'
        }
        {
          name: 'applicationType_s'
          type: 'string'
        }
        {
          name: 'processCommandLine_g'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = cyberarkepmclTable.name
output tableId string = cyberarkepmclTable.id
output provisioningState string = cyberarkepmclTable.properties.provisioningState
