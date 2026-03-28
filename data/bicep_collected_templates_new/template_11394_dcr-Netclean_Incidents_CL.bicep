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
// Data Collection Rule for Netclean_Incidents_CL
// ============================================================================
// Generated: 2025-09-19 14:20:26
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 46, DCR columns: 44 (Type column always filtered)
// Output stream: Custom-Netclean_Incidents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Netclean_Incidents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Netclean_Incidents_CL': {
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
            name: 'size_s'
            type: 'string'
          }
          {
            name: 'creationTime_t'
            type: 'string'
          }
          {
            name: 'lastAccessTime_t'
            type: 'string'
          }
          {
            name: 'lastWriteTime_t'
            type: 'string'
          }
          {
            name: 'sha1_s'
            type: 'string'
          }
          {
            name: 'nearbyFiles_sha1_s'
            type: 'string'
          }
          {
            name: 'externalIP_s'
            type: 'string'
          }
          {
            name: 'domain_s'
            type: 'string'
          }
          {
            name: 'loggedOnUsers_s'
            type: 'string'
          }
          {
            name: 'hasCollectedNearbyFiles_s'
            type: 'string'
          }
          {
            name: 'm365WebUrl_s'
            type: 'string'
          }
          {
            name: 'm365CreatedBymail_s'
            type: 'string'
          }
          {
            name: 'm365LastModifiedByMail_s'
            type: 'string'
          }
          {
            name: 'm365LibraryId_s'
            type: 'string'
          }
          {
            name: 'm365LibraryDisplayName_s'
            type: 'string'
          }
          {
            name: 'm365Librarytype_s'
            type: 'string'
          }
          {
            name: 'm365siteid_s'
            type: 'string'
          }
          {
            name: 'm365sitedisplayName_s'
            type: 'string'
          }
          {
            name: 'filePath_s'
            type: 'string'
          }
          {
            name: 'm365sitename_s'
            type: 'string'
          }
          {
            name: 'Agentidentifier_g'
            type: 'string'
          }
          {
            name: 'domainname_s'
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
            name: 'Hostname_s'
            type: 'string'
          }
          {
            name: 'agentType_s'
            type: 'string'
          }
          {
            name: 'Identifier_g'
            type: 'string'
          }
          {
            name: 'Agentversion_s'
            type: 'string'
          }
          {
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'foundTime_t'
            type: 'string'
          }
          {
            name: 'detectionMethod_s'
            type: 'string'
          }
          {
            name: 'agentInformatonIdentifier_s'
            type: 'string'
          }
          {
            name: 'osVersion_s'
            type: 'string'
          }
          {
            name: 'machineName_s'
            type: 'string'
          }
          {
            name: 'microsoftCultureId_s'
            type: 'string'
          }
          {
            name: 'timeZoneId_s'
            type: 'string'
          }
          {
            name: 'microsoftGeoId_s'
            type: 'string'
          }
          {
            name: 'version_s'
            type: 'string'
          }
          {
            name: 'countOfAllNearByFiles_s'
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
          name: 'Sentinel-Netclean_Incidents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Netclean_Incidents_CL']
        destinations: ['Sentinel-Netclean_Incidents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), size_s = tostring(size_s), creationTime_t = todatetime(creationTime_t), lastAccessTime_t = todatetime(lastAccessTime_t), lastWriteTime_t = todatetime(lastWriteTime_t), sha1_s = tostring(sha1_s), nearbyFiles_sha1_s = tostring(nearbyFiles_sha1_s), externalIP_s = tostring(externalIP_s), domain_s = tostring(domain_s), loggedOnUsers_s = tostring(loggedOnUsers_s), hasCollectedNearbyFiles_s = tostring(hasCollectedNearbyFiles_s), m365WebUrl_s = tostring(m365WebUrl_s), m365CreatedBymail_s = tostring(m365CreatedBymail_s), m365LastModifiedByMail_s = tostring(m365LastModifiedByMail_s), m365LibraryId_s = tostring(m365LibraryId_s), m365LibraryDisplayName_s = tostring(m365LibraryDisplayName_s), m365Librarytype_s = tostring(m365Librarytype_s), m365siteid_s = tostring(m365siteid_s), m365sitedisplayName_s = tostring(m365sitedisplayName_s), filePath_s = tostring(filePath_s), m365sitename_s = tostring(m365sitename_s), Agentidentifier_g = tostring(Agentidentifier_g), domainname_s = tostring(domainname_s), SourceSystem = tostring(SourceSystem), MG = toguid(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), Hostname_s = tostring(Hostname_s), agentType_s = tostring(agentType_s), Identifier_g = tostring(Identifier_g), Agentversion_s = tostring(Agentversion_s), type_s = tostring(type_s), foundTime_t = todatetime(foundTime_t), detectionMethod_s = tostring(detectionMethod_s), agentInformatonIdentifier_s = tostring(agentInformatonIdentifier_s), osVersion_s = tostring(osVersion_s), machineName_s = tostring(machineName_s), microsoftCultureId_s = tostring(microsoftCultureId_s), timeZoneId_s = tostring(timeZoneId_s), microsoftGeoId_s = tostring(microsoftGeoId_s), version_s = tostring(version_s), countOfAllNearByFiles_s = tostring(countOfAllNearByFiles_s)'
        outputStream: 'Custom-Netclean_Incidents_CL'
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
