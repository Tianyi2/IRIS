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
// Data Collection Rule for Rubrik_Anomaly_Data_CL
// ============================================================================
// Generated: 2025-09-19 14:20:30
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 20, DCR columns: 18 (Type column always filtered)
// Output stream: Custom-Rubrik_Anomaly_Data_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Rubrik_Anomaly_Data_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Rubrik_Anomaly_Data_CL': {
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
            name: 'custom_details_objectName_s'
            type: 'string'
          }
          {
            name: 'custom_details_type_s'
            type: 'string'
          }
          {
            name: 'class_s'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'source_s'
            type: 'string'
          }
          {
            name: 'summary_s'
            type: 'string'
          }
          {
            name: 'custom_details_objectType_s'
            type: 'string'
          }
          {
            name: 'custom_details_clusterId_g'
            type: 'string'
          }
          {
            name: 'custom_details_objectId_g'
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
            name: 'custom_details_id_g'
            type: 'string'
          }
          {
            name: 'custom_details_status_s'
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
          name: 'Sentinel-Rubrik_Anomaly_Data_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Rubrik_Anomaly_Data_CL']
        destinations: ['Sentinel-Rubrik_Anomaly_Data_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), custom_details_objectName_s = tostring(custom_details_objectName_s), custom_details_type_s = tostring(custom_details_type_s), class_s = tostring(class_s), severity_s = tostring(severity_s), source_s = tostring(source_s), summary_s = tostring(summary_s), custom_details_objectType_s = tostring(custom_details_objectType_s), custom_details_clusterId_g = tostring(custom_details_clusterId_g), custom_details_objectId_g = tostring(custom_details_objectId_g), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), custom_details_id_g = tostring(custom_details_id_g), custom_details_status_s = tostring(custom_details_status_s)'
        outputStream: 'Custom-Rubrik_Anomaly_Data_CL'
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
