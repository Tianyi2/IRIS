// Bicep template for Log Analytics custom table: TaniumDiscoverUnmanagedAssets_CL
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 40, Deployed columns: 39 (Type column filtered)
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

resource taniumdiscoverunmanagedassetsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'TaniumDiscoverUnmanagedAssets_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'TaniumDiscoverUnmanagedAssets_CL'
      description: 'Custom table TaniumDiscoverUnmanagedAssets_CL - imported from JSON schema'
      displayName: 'TaniumDiscoverUnmanagedAssets_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'Arp_d'
          type: 'real'
        }
        {
          name: 'NatIpAddress_s'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'Nmap_d'
          type: 'real'
        }
        {
          name: 'OsGeneration_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'TaniumComputerId_d'
          type: 'real'
        }
        {
          name: 'Unmanageable_d'
          type: 'real'
        }
        {
          name: 'UpdatedAt_s'
          type: 'string'
        }
        {
          name: 'Managed_d'
          type: 'real'
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
          type: 'real'
        }
        {
          name: 'CentralizedNmap_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
          dataTypeHint: 3
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
}

output tableName string = taniumdiscoverunmanagedassetsclTable.name
output tableId string = taniumdiscoverunmanagedassetsclTable.id
output provisioningState string = taniumdiscoverunmanagedassetsclTable.properties.provisioningState
