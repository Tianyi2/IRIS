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
// Data Collection Rule for TaniumDiscoverUnmanagedAssets_CL
// ============================================================================
// Generated: 2025-09-19 14:20:33
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 40, DCR columns: 39 (Type column always filtered)
// Output stream: Custom-TaniumDiscoverUnmanagedAssets_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-TaniumDiscoverUnmanagedAssets_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-TaniumDiscoverUnmanagedAssets_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'Arp_d'
            type: 'string'
          }
          {
            name: 'NatIpAddress_s'
            type: 'string'
          }
          {
            name: 'Nmap_d'
            type: 'string'
          }
          {
            name: 'OsGeneration_d'
            type: 'string'
          }
          {
            name: 'OsGeneration_s'
            type: 'string'
          }
          {
            name: 'Os_s'
            type: 'string'
          }
          {
            name: 'OwnerId_s'
            type: 'string'
          }
          {
            name: 'Ping_d'
            type: 'string'
          }
          {
            name: 'Ports_s'
            type: 'string'
          }
          {
            name: 'Profile_s'
            type: 'string'
          }
          {
            name: 'Provider_s'
            type: 'string'
          }
          {
            name: 'RawData'
            type: 'string'
          }
          {
            name: 'SatelliteNmap_d'
            type: 'string'
          }
          {
            name: 'TaniumComputerId_d'
            type: 'string'
          }
          {
            name: 'Unmanageable_d'
            type: 'string'
          }
          {
            name: 'UpdatedAt_s'
            type: 'string'
          }
          {
            name: 'Managed_d'
            type: 'string'
          }
          {
            name: 'MacOrganization_s'
            type: 'string'
          }
          {
            name: 'MacAddress_s'
            type: 'string'
          }
          {
            name: 'Locations_s'
            type: 'string'
          }
          {
            name: 'AwsApi_d'
            type: 'string'
          }
          {
            name: 'CentralizedNmap_d'
            type: 'string'
          }
          {
            name: 'CloudTags_s'
            type: 'string'
          }
          {
            name: 'Computer'
            type: 'string'
          }
          {
            name: 'Connected_d'
            type: 'string'
          }
          {
            name: 'CreatedAt_s'
            type: 'string'
          }
          {
            name: 'HostName_s'
            type: 'string'
          }
          {
            name: 'VirtualNetworkId_s'
            type: 'string'
          }
          {
            name: 'id_d'
            type: 'string'
          }
          {
            name: 'InstanceId_s'
            type: 'string'
          }
          {
            name: 'InstanceState_s'
            type: 'string'
          }
          {
            name: 'InstanceType_s'
            type: 'string'
          }
          {
            name: 'IPAddress'
            type: 'string'
          }
          {
            name: 'Labels_s'
            type: 'string'
          }
          {
            name: 'LastDiscoveredAt_s'
            type: 'string'
          }
          {
            name: 'LaunchTime_s'
            type: 'string'
          }
          {
            name: 'ImageId_s'
            type: 'string'
          }
          {
            name: 'Zone_s'
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
          name: 'Sentinel-TaniumDiscoverUnmanagedAssets_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-TaniumDiscoverUnmanagedAssets_CL']
        destinations: ['Sentinel-TaniumDiscoverUnmanagedAssets_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), Arp_d = toreal(Arp_d), NatIpAddress_s = tostring(NatIpAddress_s), Nmap_d = toreal(Nmap_d), OsGeneration_d = toreal(OsGeneration_d), OsGeneration_s = tostring(OsGeneration_s), Os_s = tostring(Os_s), OwnerId_s = tostring(OwnerId_s), Ping_d = toreal(Ping_d), Ports_s = tostring(Ports_s), Profile_s = tostring(Profile_s), Provider_s = tostring(Provider_s), RawData = tostring(RawData), SatelliteNmap_d = toreal(SatelliteNmap_d), TaniumComputerId_d = toreal(TaniumComputerId_d), Unmanageable_d = toreal(Unmanageable_d), UpdatedAt_s = tostring(UpdatedAt_s), Managed_d = toreal(Managed_d), MacOrganization_s = tostring(MacOrganization_s), MacAddress_s = tostring(MacAddress_s), Locations_s = tostring(Locations_s), AwsApi_d = toreal(AwsApi_d), CentralizedNmap_d = toreal(CentralizedNmap_d), CloudTags_s = tostring(CloudTags_s), Computer = tostring(Computer), Connected_d = toreal(Connected_d), CreatedAt_s = tostring(CreatedAt_s), HostName_s = tostring(HostName_s), VirtualNetworkId_s = tostring(VirtualNetworkId_s), id_d = toreal(id_d), InstanceId_s = tostring(InstanceId_s), InstanceState_s = tostring(InstanceState_s), InstanceType_s = tostring(InstanceType_s), IPAddress = tostring(IPAddress), Labels_s = tostring(Labels_s), LastDiscoveredAt_s = tostring(LastDiscoveredAt_s), LaunchTime_s = tostring(LaunchTime_s), ImageId_s = tostring(ImageId_s), Zone_s = tostring(Zone_s)'
        outputStream: 'Custom-TaniumDiscoverUnmanagedAssets_CL'
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
