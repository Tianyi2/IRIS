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
// Data Collection Rule for ImpervaWAFCloud_CL
// ============================================================================
// Generated: 2025-09-19 14:20:21
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 38, DCR columns: 38 (Type column always filtered)
// Output stream: Custom-ImpervaWAFCloud_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-ImpervaWAFCloud_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-ImpervaWAFCloud_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'EventVendor_s'
            type: 'string'
          }
          {
            name: 'requestMethod_s'
            type: 'string'
          }
          {
            name: 'sip_s'
            type: 'string'
          }
          {
            name: 'siteid_s'
            type: 'string'
          }
          {
            name: 'sourceServiceName_s'
            type: 'string'
          }
          {
            name: 'spt_s'
            type: 'string'
          }
          {
            name: 'src_s'
            type: 'string'
          }
          {
            name: 'start_s'
            type: 'string'
          }
          {
            name: 'suid_s'
            type: 'string'
          }
          {
            name: 'ver_s'
            type: 'string'
          }
          {
            name: 'xff_s'
            type: 'string'
          }
          {
            name: 'CapSupport_s'
            type: 'string'
          }
          {
            name: 'clapp_s'
            type: 'string'
          }
          {
            name: 'clappsig_s'
            type: 'string'
          }
          {
            name: 'COSupport_s'
            type: 'string'
          }
          {
            name: 'latitude_s'
            type: 'string'
          }
          {
            name: 'requestClientApplication_s'
            type: 'string'
          }
          {
            name: 'longitude_s'
            type: 'string'
          }
          {
            name: 'request_s'
            type: 'string'
          }
          {
            name: 'postbody_s'
            type: 'string'
          }
          {
            name: 'EventProduct_s'
            type: 'string'
          }
          {
            name: 'EventType_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'act_s'
            type: 'string'
          }
          {
            name: 'app_s'
            type: 'string'
          }
          {
            name: 'ccode_s'
            type: 'string'
          }
          {
            name: 'cicode_s'
            type: 'string'
          }
          {
            name: 'cn1_s'
            type: 'string'
          }
          {
            name: 'cpt_s'
            type: 'string'
          }
          {
            name: 'Customer_s'
            type: 'string'
          }
          {
            name: 'deviceExternalId_s'
            type: 'string'
          }
          {
            name: 'deviceFacility_s'
            type: 'string'
          }
          {
            name: 'dproc_s'
            type: 'string'
          }
          {
            name: 'end_s'
            type: 'string'
          }
          {
            name: 'fileId_s'
            type: 'string'
          }
          {
            name: 'qstr_s'
            type: 'string'
          }
          {
            name: 'VID_g'
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
          name: 'Sentinel-ImpervaWAFCloud_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-ImpervaWAFCloud_CL']
        destinations: ['Sentinel-ImpervaWAFCloud_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), EventVendor_s = tostring(EventVendor_s), requestMethod_s = tostring(requestMethod_s), sip_s = tostring(sip_s), siteid_s = tostring(siteid_s), sourceServiceName_s = tostring(sourceServiceName_s), spt_s = tostring(spt_s), src_s = tostring(src_s), start_s = tostring(start_s), suid_s = tostring(suid_s), ver_s = tostring(ver_s), xff_s = tostring(xff_s), CapSupport_s = tostring(CapSupport_s), clapp_s = tostring(clapp_s), clappsig_s = tostring(clappsig_s), COSupport_s = tostring(COSupport_s), latitude_s = tostring(latitude_s), requestClientApplication_s = tostring(requestClientApplication_s), longitude_s = tostring(longitude_s), request_s = tostring(request_s), postbody_s = tostring(postbody_s), EventProduct_s = tostring(EventProduct_s), EventType_s = tostring(EventType_s), severity_s = tostring(severity_s), act_s = tostring(act_s), app_s = tostring(app_s), ccode_s = tostring(ccode_s), cicode_s = tostring(cicode_s), cn1_s = tostring(cn1_s), cpt_s = tostring(cpt_s), Customer_s = tostring(Customer_s), deviceExternalId_s = tostring(deviceExternalId_s), deviceFacility_s = tostring(deviceFacility_s), dproc_s = tostring(dproc_s), end_s = tostring(end_s), fileId_s = tostring(fileId_s), qstr_s = tostring(qstr_s), VID_g = tostring(VID_g)'
        outputStream: 'Custom-ImpervaWAFCloud_CL'
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
