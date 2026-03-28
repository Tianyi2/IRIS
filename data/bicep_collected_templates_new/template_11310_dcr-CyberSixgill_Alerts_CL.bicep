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
// Data Collection Rule for CyberSixgill_Alerts_CL
// ============================================================================
// Generated: 2025-09-19 14:20:16
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 30, DCR columns: 28 (Type column always filtered)
// Output stream: Custom-CyberSixgill_Alerts_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CyberSixgill_Alerts_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CyberSixgill_Alerts_CL': {
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
            name: 'threat_actor'
            type: 'string'
          }
          {
            name: 'assets'
            type: 'string'
          }
          {
            name: 'user_id'
            type: 'string'
          }
          {
            name: 'title_s'
            type: 'string'
          }
          {
            name: 'threats'
            type: 'string'
          }
          {
            name: 'threat_level'
            type: 'string'
          }
          {
            name: 'sub_alertsize'
            type: 'string'
          }
          {
            name: 'sub_alerts'
            type: 'string'
          }
          {
            name: 'status_name'
            type: 'string'
          }
          {
            name: 'Severity'
            type: 'string'
          }
          {
            name: 'read'
            type: 'string'
          }
          {
            name: 'threatource'
            type: 'string'
          }
          {
            name: 'langcode'
            type: 'string'
          }
          {
            name: 'id'
            type: 'string'
          }
          {
            name: 'date_s'
            type: 'string'
          }
          {
            name: 'content'
            type: 'string'
          }
          {
            name: 'Category'
            type: 'string'
          }
          {
            name: 'alert_type_id'
            type: 'string'
          }
          {
            name: 'alert_name'
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
            name: 'lang'
            type: 'string'
          }
          {
            name: 'portal_url'
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
          name: 'Sentinel-CyberSixgill_Alerts_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CyberSixgill_Alerts_CL']
        destinations: ['Sentinel-CyberSixgill_Alerts_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), threat_actor = tostring(threat_actor), assets = tostring(assets), user_id = tostring(user_id), title_s = tostring(title_s), threats = tostring(threats), threat_level = tostring(threat_level), sub_alertsize = toreal(sub_alertsize), sub_alerts = tostring(sub_alerts), status_name = tostring(status_name), Severity = toint(Severity), read = tobool(read), threatource = tostring(threatource), langcode = tostring(langcode), id = tostring(id), date_s = tostring(date_s), content = tostring(content), Category = tostring(Category), alert_type_id = tostring(alert_type_id), alert_name = tostring(alert_name), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), lang = tostring(lang), portal_url = tostring(portal_url)'
        outputStream: 'Custom-CyberSixgill_Alerts_CL'
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
