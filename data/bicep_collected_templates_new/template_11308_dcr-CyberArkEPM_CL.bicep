@description('The location of the resources')
param location string = 'Australia East'
@description('The name of the Data Collection Endpoint Id')
param dataCollectionEndpointId string
@description('The Log Analytics Workspace Id used for Sentinel')
param workspaceResourceId string
@description('The Target Sentinel workspace name')
param workspaceName string = 'sentinel-workspace'
@description('The Service Principal Object ID of the Entra App')
param servicePrincipalObjectId string

// ============================================================================
// Data Collection Rule for CyberArkEPM_CL
// ============================================================================
// Generated: 2025-09-19 14:20:15
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 85, DCR columns: 83 (Type column always filtered)
// Output stream: Custom-CyberArkEPM_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CyberArkEPM_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CyberArkEPM_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'deceptionType_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'userIsAdmin_b'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'logonAttemptTypeId_d'
            type: 'string'
          }
          {
            name: 'winEventRecordId_d'
            type: 'string'
          }
          {
            name: 'winEventType_d'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'aggregatedBy_s'
            type: 'string'
          }
          {
            name: 'skipped_b'
            type: 'string'
          }
          {
            name: 'skippedCount_d'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'firstEventUserName_s'
            type: 'string'
          }
          {
            name: 'firstEventDate_t'
            type: 'string'
          }
          {
            name: 'affectedUsers_d'
            type: 'string'
          }
          {
            name: 'affectedComputers_d'
            type: 'string'
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
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-CyberArkEPM_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CyberArkEPM_CL']
        destinations: ['Sentinel-CyberArkEPM_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), productName_s = tostring(productName_s), fileDescription_s = tostring(fileDescription_s), filePath_s = tostring(filePath_s), company_s = tostring(company_s), packageName_s = tostring(packageName_s), threatProtectionAction_s = tostring(threatProtectionAction_s), originalFileName_s = tostring(originalFileName_s), productVersion_s = tostring(productVersion_s), fileName_s = tostring(fileName_s), sourceName_s = tostring(sourceName_s), sourceType_s = tostring(sourceType_s), policyName_s = tostring(policyName_s), event_type_s = tostring(event_type_s), lastAgentId_g = tostring(lastAgentId_g), defenceActionId_d = toreal(defenceActionId_d), deceptionType_d = toreal(deceptionType_d), userName_s = tostring(userName_s), fileVersion_s = tostring(fileVersion_s), modificationTime_t = todatetime(modificationTime_t), userIsAdmin_b = tobool(userIsAdmin_b), sourceProcessSigner_s = tostring(sourceProcessSigner_s), sourceProcessPublisher_s = tostring(sourceProcessPublisher_s), sourceProcessHash_s = tostring(sourceProcessHash_s), sourceProcessUsername_s = tostring(sourceProcessUsername_s), sourceProcessCommandLine_s = tostring(sourceProcessCommandLine_s), accessTargetName_s = tostring(accessTargetName_s), justification_s = tostring(justification_s), logonStatusId_d = toreal(logonStatusId_d), logonAttemptTypeId_d = toreal(logonAttemptTypeId_d), winEventRecordId_d = toreal(winEventRecordId_d), winEventType_d = toreal(winEventType_d), owner_s = tostring(owner_s), displayName_s = tostring(displayName_s), processCommandLine_s = tostring(processCommandLine_s), accessTargetType_s = tostring(accessTargetType_s), accessAction_s = tostring(accessAction_s), agentEventCount_d = toreal(agentEventCount_d), aggregatedBy_s = tostring(aggregatedBy_s), skipped_b = tobool(skipped_b), skippedCount_d = toreal(skippedCount_d), fileLocation_s = tostring(fileLocation_s), hash_s = tostring(hash_s), lastEventDisplayName_s = tostring(lastEventDisplayName_s), fileQualifier_s = tostring(fileQualifier_s), bundleId_s = tostring(bundleId_s), bundleVersion_s = tostring(bundleVersion_s), bundleName_s = tostring(bundleName_s), applicationSubType_s = tostring(applicationSubType_s), justificationEmail_s = tostring(justificationEmail_s), fileAccessPermission_s = tostring(fileAccessPermission_s), adminTaskId_s = tostring(adminTaskId_s), policyId_d = toreal(policyId_d), set_name_s = tostring(set_name_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), publisher_s = tostring(publisher_s), evidences_s = tostring(evidences_s), totalEvents_d = toreal(totalEvents_d), eventType_s = tostring(eventType_s), agentId_g = tostring(agentId_g), appPackageDisplayName_s = tostring(appPackageDisplayName_s), url_s = tostring(url_s), mimeType_s = tostring(mimeType_s), CLSID_s = tostring(CLSID_s), fileSize_d = toreal(fileSize_d), firstEventUserName_s = tostring(firstEventUserName_s), firstEventDate_t = todatetime(firstEventDate_t), affectedUsers_d = toreal(affectedUsers_d), affectedComputers_d = toreal(affectedComputers_d), lastEventFileName_s = tostring(lastEventFileName_s), threatDetectionAction_s = tostring(threatDetectionAction_s), lastEventJustification_s = tostring(lastEventJustification_s), lastEventUserName_s = tostring(lastEventUserName_s), lastEventDate_t = todatetime(lastEventDate_t), lastEventSourceName_s = tostring(lastEventSourceName_s), lastEventSourceType_s = tostring(lastEventSourceType_s), applicationType_s = tostring(applicationType_s), processCommandLine_g = tostring(processCommandLine_g)'
        outputStream: 'Custom-CyberArkEPM_CL'
      }
    ]
  }
}

// Role Assignment to the DCR
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: dataCollectionRule
  name: guid(resourceGroup().id, roleDefinitionResourceId, dataCollectionRule.name)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

output immutableId string = dataCollectionRule.properties.immutableId
output dataCollectionRuleId string = dataCollectionRule.id
output dataCollectionRuleName string = dataCollectionRule.name
