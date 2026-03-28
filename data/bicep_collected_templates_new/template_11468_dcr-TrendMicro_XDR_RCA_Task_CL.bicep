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
// Data Collection Rule for TrendMicro_XDR_RCA_Task_CL
// ============================================================================
// Generated: 2025-09-19 14:20:35
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 26, DCR columns: 24 (Type column always filtered)
// Output stream: Custom-TrendMicro_XDR_RCA_Task_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TrendMicro_XDR_RCA_Task_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TrendMicro_XDR_RCA_Task_CL': {
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
            name: 'name_s'
            type: 'string'
          }
          {
            name: 'id_g'
            type: 'string'
          }
          {
            name: 'workbenchId_s'
            type: 'string'
          }
          {
            name: 'targets'
            type: 'string'
          }
          {
            name: 'completedTimestamp'
            type: 'string'
          }
          {
            name: 'lastUpdateTimestamp'
            type: 'string'
          }
          {
            name: 'createdTimestamp'
            type: 'string'
          }
          {
            name: 'criteria_conditions'
            type: 'string'
          }
          {
            name: 'criteria_operator'
            type: 'string'
          }
          {
            name: 'xdrCustomerID_g'
            type: 'string'
          }
          {
            name: 'status'
            type: 'string'
          }
          {
            name: 'workbenchId'
            type: 'string'
          }
          {
            name: 'name'
            type: 'string'
          }
          {
            name: 'id'
            type: 'string'
          }
          {
            name: 'xdrCustomerID'
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
            name: 'description'
            type: 'string'
          }
          {
            name: 'targets_s'
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
          name: 'Sentinel-TrendMicro_XDR_RCA_Task_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TrendMicro_XDR_RCA_Task_CL']
        destinations: ['Sentinel-TrendMicro_XDR_RCA_Task_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), name_s = tostring(name_s), id_g = tostring(id_g), workbenchId_s = tostring(workbenchId_s), targets = tostring(targets), completedTimestamp = toreal(completedTimestamp), lastUpdateTimestamp = toreal(lastUpdateTimestamp), createdTimestamp = toreal(createdTimestamp), criteria_conditions = tostring(criteria_conditions), criteria_operator = tostring(criteria_operator), xdrCustomerID_g = tostring(xdrCustomerID_g), status = tostring(status), workbenchId = tostring(workbenchId), name = tostring(name), id = tostring(id), xdrCustomerID = tostring(xdrCustomerID), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), description = tostring(description), targets_s = tostring(targets_s)'
        outputStream: 'Custom-TrendMicro_XDR_RCA_Task_CL'
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
