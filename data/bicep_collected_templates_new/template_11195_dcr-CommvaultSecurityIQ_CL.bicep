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
// Data Collection Rule for CommvaultSecurityIQ_CL
// ============================================================================
// Generated: 2025-09-19 14:20:01
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 23, DCR columns: 22 (Type column always filtered)
// Output stream: Custom-CommvaultSecurityIQ_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CommvaultSecurityIQ_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CommvaultSecurityIQ_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'anomaly_sub_type_s'
            type: 'string'
          }
          {
            name: 'RawData'
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
            name: 'username_s'
            type: 'string'
          }
          {
            name: 'user_id_d'
            type: 'string'
          }
          {
            name: 'subclient_id_d'
            type: 'string'
          }
          {
            name: 'severity_s'
            type: 'string'
          }
          {
            name: 'SourceSystem'
            type: 'string'
          }
          {
            name: 'scanned_folder_list_s'
            type: 'string'
          }
          {
            name: 'job_start_time_s'
            type: 'string'
          }
          {
            name: 'job_id_s'
            type: 'string'
          }
          {
            name: 'job_end_time_s'
            type: 'string'
          }
          {
            name: 'files_list_s'
            type: 'string'
          }
          {
            name: 'external_link_s'
            type: 'string'
          }
          {
            name: 'description_s'
            type: 'string'
          }
          {
            name: 'deleted_files_count_s'
            type: 'string'
          }
          {
            name: 'created_files_count_s'
            type: 'string'
          }
          {
            name: 'originating_client_s'
            type: 'string'
          }
          {
            name: 'TenantId'
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
          name: 'Sentinel-CommvaultSecurityIQ_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CommvaultSecurityIQ_CL']
        destinations: ['Sentinel-CommvaultSecurityIQ_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), anomaly_sub_type_s = tostring(anomaly_sub_type_s), RawData = tostring(RawData), MG = toguid(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), username_s = tostring(username_s), user_id_d = toreal(user_id_d), subclient_id_d = toreal(subclient_id_d), severity_s = tostring(severity_s), SourceSystem = tostring(SourceSystem), scanned_folder_list_s = tostring(scanned_folder_list_s), job_start_time_s = tostring(job_start_time_s), job_id_s = tostring(job_id_s), job_end_time_s = tostring(job_end_time_s), files_list_s = tostring(files_list_s), external_link_s = tostring(external_link_s), description_s = tostring(description_s), deleted_files_count_s = tostring(deleted_files_count_s), created_files_count_s = tostring(created_files_count_s), originating_client_s = tostring(originating_client_s), TenantId = toguid(TenantId)'
        outputStream: 'Custom-CommvaultSecurityIQ_CL'
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
