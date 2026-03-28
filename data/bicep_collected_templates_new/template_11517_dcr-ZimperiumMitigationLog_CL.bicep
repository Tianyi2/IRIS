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
// Data Collection Rule for ZimperiumMitigationLog_CL
// ============================================================================
// Generated: 2025-09-19 14:20:41
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 17, DCR columns: 15 (Type column always filtered)
// Output stream: Custom-ZimperiumMitigationLog_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ZimperiumMitigationLog_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ZimperiumMitigationLog_CL': {
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
            name: 'threat_uuid'
            type: 'string'
          }
          {
            name: 'event_id_s'
            type: 'string'
          }
          {
            name: 'zdevice_id'
            type: 'string'
          }
          {
            name: 'device_os_s'
            type: 'string'
          }
          {
            name: 'event_timestamp_s'
            type: 'string'
          }
          {
            name: 'account_id'
            type: 'string'
          }
          {
            name: 'detection_app_instance_id'
            type: 'string'
          }
          {
            name: 'mitigated'
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
          name: 'Sentinel-ZimperiumMitigationLog_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ZimperiumMitigationLog_CL']
        destinations: ['Sentinel-ZimperiumMitigationLog_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), threat_uuid = tostring(threat_uuid), event_id_s = tostring(event_id_s), zdevice_id = tostring(zdevice_id), device_os_s = tostring(device_os_s), event_timestamp_s = tostring(event_timestamp_s), account_id = tostring(account_id), detection_app_instance_id = tostring(detection_app_instance_id), mitigated = tobool(mitigated)'
        outputStream: 'Custom-ZimperiumMitigationLog_CL'
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
