// Bicep template for Log Analytics custom table: Netclean_Incidents_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 46, Deployed columns: 44 (Type column filtered)
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

resource netcleanincidentsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Netclean_Incidents_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Netclean_Incidents_CL'
      description: 'Custom table Netclean_Incidents_CL - imported from JSON schema'
      displayName: 'Netclean_Incidents_CL'
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
          name: 'size_s'
          type: 'string'
        }
        {
          name: 'creationTime_t'
          type: 'dateTime'
        }
        {
          name: 'lastAccessTime_t'
          type: 'dateTime'
        }
        {
          name: 'lastWriteTime_t'
          type: 'dateTime'
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
          dataTypeHint: 0
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
          type: 'guid'
          dataTypeHint: 1
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
          type: 'dateTime'
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
}

output tableName string = netcleanincidentsclTable.name
output tableId string = netcleanincidentsclTable.id
output provisioningState string = netcleanincidentsclTable.properties.provisioningState
