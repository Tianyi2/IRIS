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
// Data Collection Rule for VMware_CWS_Weblogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:36
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 48, DCR columns: 48 (Type column always filtered)
// Output stream: Custom-VMware_CWS_Weblogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-VMware_CWS_Weblogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-VMware_CWS_Weblogs_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'accessMode'
            type: 'string'
          }
          {
            name: 'policyName'
            type: 'string'
          }
          {
            name: 'protocol'
            type: 'string'
          }
          {
            name: 'region'
            type: 'string'
          }
          {
            name: 'requestMethod'
            type: 'string'
          }
          {
            name: 'requestType'
            type: 'string'
          }
          {
            name: 'responseCode'
            type: 'string'
          }
          {
            name: 'risks'
            type: 'dynamic'
          }
          {
            name: 'ruleMatched'
            type: 'string'
          }
          {
            name: 'saasEgressHeaders'
            type: 'dynamic'
          }
          {
            name: 'policyHeaders'
            type: 'string'
          }
          {
            name: 'sandboxInspectionResult'
            type: 'string'
          }
          {
            name: 'sandboxScore'
            type: 'string'
          }
          {
            name: 'sourceIp'
            type: 'string'
          }
          {
            name: 'srcCountry'
            type: 'string'
          }
          {
            name: 'threatTypes'
            type: 'dynamic'
          }
          {
            name: 'url'
            type: 'string'
          }
          {
            name: 'userAgent'
            type: 'string'
          }
          {
            name: 'userGroups'
            type: 'dynamic'
          }
          {
            name: 'userGroupsMatched'
            type: 'dynamic'
          }
          {
            name: 'userId'
            type: 'string'
          }
          {
            name: 'sandboxMaliciousActivitiesFound'
            type: 'string'
          }
          {
            name: 'virusList'
            type: 'string'
          }
          {
            name: 'mimeType'
            type: 'string'
          }
          {
            name: 'fileSize'
            type: 'string'
          }
          {
            name: 'action'
            type: 'string'
          }
          {
            name: 'browserType'
            type: 'dynamic'
          }
          {
            name: 'browserVersion'
            type: 'dynamic'
          }
          {
            name: 'casbAppName'
            type: 'dynamic'
          }
          {
            name: 'casbCatName'
            type: 'dynamic'
          }
          {
            name: 'casbFunName'
            type: 'dynamic'
          }
          {
            name: 'casbOrgName'
            type: 'dynamic'
          }
          {
            name: 'casbRiskScore'
            type: 'dynamic'
          }
          {
            name: 'categories'
            type: 'string'
          }
          {
            name: 'fileType'
            type: 'string'
          }
          {
            name: 'contentType'
            type: 'string'
          }
          {
            name: 'destinationIp'
            type: 'string'
          }
          {
            name: 'dnsResponse'
            type: 'string'
          }
          {
            name: 'domain'
            type: 'string'
          }
          {
            name: 'dstCountry'
            type: 'string'
          }
          {
            name: 'egressIp'
            type: 'string'
          }
          {
            name: 'fileHash'
            type: 'dynamic'
          }
          {
            name: 'fileHashScore'
            type: 'string'
          }
          {
            name: 'fileName'
            type: 'string'
          }
          {
            name: 'fileScanResult'
            type: 'dynamic'
          }
          {
            name: 'cws_timestamp'
            type: 'string'
          }
          {
            name: 'webRiskScore'
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
          name: 'Sentinel-VMware_CWS_Weblogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-VMware_CWS_Weblogs_CL']
        destinations: ['Sentinel-VMware_CWS_Weblogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), accessMode = tostring(accessMode), policyName = tostring(policyName), protocol = tostring(protocol), region = tostring(region), requestMethod = tostring(requestMethod), requestType = tostring(requestType), responseCode = tostring(responseCode), risks = todynamic(risks), ruleMatched = tostring(ruleMatched), saasEgressHeaders = todynamic(saasEgressHeaders), policyHeaders = tostring(policyHeaders), sandboxInspectionResult = tostring(sandboxInspectionResult), sandboxScore = tostring(sandboxScore), sourceIp = tostring(sourceIp), srcCountry = tostring(srcCountry), threatTypes = todynamic(threatTypes), url = tostring(url), userAgent = tostring(userAgent), userGroups = todynamic(userGroups), userGroupsMatched = todynamic(userGroupsMatched), userId = tostring(userId), sandboxMaliciousActivitiesFound = tostring(sandboxMaliciousActivitiesFound), virusList = tostring(virusList), mimeType = tostring(mimeType), fileSize = tostring(fileSize), action = tostring(action), browserType = todynamic(browserType), browserVersion = todynamic(browserVersion), casbAppName = todynamic(casbAppName), casbCatName = todynamic(casbCatName), casbFunName = todynamic(casbFunName), casbOrgName = todynamic(casbOrgName), casbRiskScore = todynamic(casbRiskScore), categories = tostring(categories), fileType = tostring(fileType), contentType = tostring(contentType), destinationIp = tostring(destinationIp), dnsResponse = tostring(dnsResponse), domain = tostring(domain), dstCountry = tostring(dstCountry), egressIp = tostring(egressIp), fileHash = todynamic(fileHash), fileHashScore = tostring(fileHashScore), fileName = tostring(fileName), fileScanResult = todynamic(fileScanResult), cws_timestamp = todatetime(cws_timestamp), webRiskScore = tostring(webRiskScore)'
        outputStream: 'Custom-VMware_CWS_Weblogs_CL'
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
