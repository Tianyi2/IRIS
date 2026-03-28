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
// Data Collection Rule for SophosEPEvents_CL
// ============================================================================
// Generated: 2025-09-19 14:20:32
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 29, DCR columns: 29 (Type column always filtered)
// Output stream: Custom-SophosEPEvents_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-SophosEPEvents_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-SophosEPEvents_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventVendor'
            type: 'string'
          }
          {
            name: 'DstUserSid'
            type: 'string'
          }
          {
            name: 'DvcAction'
            type: 'string'
          }
          {
            name: 'ThreatName'
            type: 'string'
          }
          {
            name: 'SrcIpAddr'
            type: 'string'
          }
          {
            name: 'source_info'
            type: 'dynamic'
          }
          {
            name: 'Source'
            type: 'string'
          }
          {
            name: 'EventSeverity'
            type: 'string'
          }
          {
            name: 'EventSubType'
            type: 'string'
          }
          {
            name: 'EventMessage'
            type: 'string'
          }
          {
            name: 'DvcHostname'
            type: 'string'
          }
          {
            name: 'ips_threat_data'
            type: 'dynamic'
          }
          {
            name: 'EventOriginalUid'
            type: 'string'
          }
          {
            name: 'ThreatCategory'
            type: 'string'
          }
          {
            name: 'SrcDvcType'
            type: 'string'
          }
          {
            name: 'EndpointId'
            type: 'string'
          }
          {
            name: 'details'
            type: 'dynamic'
          }
          {
            name: 'CustomerId'
            type: 'string'
          }
          {
            name: 'Created'
            type: 'string'
          }
          {
            name: 'CoreRemedyTotalItems'
            type: 'string'
          }
          {
            name: 'CoreRemedyItems'
            type: 'string'
          }
          {
            name: 'AppSha256'
            type: 'string'
          }
          {
            name: 'appCerts'
            type: 'dynamic'
          }
          {
            name: 'amsi_threat_data'
            type: 'dynamic'
          }
          {
            name: 'EventType'
            type: 'string'
          }
          {
            name: 'EventProduct'
            type: 'string'
          }
          {
            name: 'EventEndTime'
            type: 'string'
          }
          {
            name: 'whitelist_properties'
            type: 'dynamic'
          }
        ]
      }
    }
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-SophosEPEvents_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-SophosEPEvents_CL']
        destinations: ['Sentinel-SophosEPEvents_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor = tostring(EventVendor), DstUserSid = tostring(DstUserSid), DvcAction = tostring(DvcAction), ThreatName = tostring(ThreatName), SrcIpAddr = tostring(SrcIpAddr), source_info = todynamic(source_info), Source = tostring(Source), EventSeverity = tostring(EventSeverity), EventSubType = tostring(EventSubType), EventMessage = tostring(EventMessage), DvcHostname = tostring(DvcHostname), ips_threat_data = todynamic(ips_threat_data), EventOriginalUid = tostring(EventOriginalUid), ThreatCategory = tostring(ThreatCategory), SrcDvcType = tostring(SrcDvcType), EndpointId = tostring(EndpointId), details = todynamic(details), CustomerId = tostring(CustomerId), Created = todatetime(Created), CoreRemedyTotalItems = toint(CoreRemedyTotalItems), CoreRemedyItems = tostring(CoreRemedyItems), AppSha256 = tostring(AppSha256), appCerts = todynamic(appCerts), amsi_threat_data = todynamic(amsi_threat_data), EventType = tostring(EventType), EventProduct = tostring(EventProduct), EventEndTime = todatetime(EventEndTime), whitelist_properties = todynamic(whitelist_properties)'
        outputStream: 'Custom-SophosEPEvents_CL'
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
