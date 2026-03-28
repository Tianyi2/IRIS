@description('Name of the Azure Container Registry')
param acrName string

@description('Location for the registry')
param location string

@description('Tags to apply to the registry')
param tags object = {}

@description('SKU for the registry')
@allowed(['Basic', 'Standard', 'Premium'])
param acrSku string = 'Premium'

@description('Private Endpoint Subnet ID')
param privateEndpointSubnetId string

@description('Private Endpoint name')
param acrPrivateEndpointName string

@description('Private DNS Zone name for ACR')
param acrDnsZoneName string = 'privatelink.azurecr.io'

@description('Private DNS Zone Resource Group')
param dnsZoneRG string

@description('DNS Subscription ID')
param dnsSubscriptionId string

@description('Admin user enabled for the registry')
param adminUserEnabled bool = false

@description('Public network access to registry')
@allowed(['Enabled', 'Disabled'])
param publicNetworkAccess string = 'Disabled'

// Reference the private DNS zone
resource acrPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' existing = {
  name: acrDnsZoneName
  scope: resourceGroup(dnsSubscriptionId, dnsZoneRG)
}

// Create the Azure Container Registry
resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: acrName
  location: location
  tags: union(tags, { 'azd-service-name': 'acr' })
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: adminUserEnabled
    publicNetworkAccess: publicNetworkAccess
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        type: 'Notary'
        status: 'disabled'
      }
      retentionPolicy: {
        days: 30
        status: 'enabled'
      }
    }
  }
}

// Create private endpoint for ACR
resource acrPrivateEndpoint 'Microsoft.Network/privateEndpoints@2022-09-01' = {
  name: acrPrivateEndpointName
  location: location
  tags: union(tags, { 'azd-service-name': acrPrivateEndpointName })
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: acrPrivateEndpointName
        properties: {
          privateLinkServiceId: acr.id
          groupIds: ['registry']
        }
      }
    ]
  }
}

// Link private endpoint to private DNS zone
resource acrPrivateEndpointDnsGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2022-09-01' = {
  parent: acrPrivateEndpoint
  name: 'privateDnsZoneGroup'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'default'
        properties: {
          privateDnsZoneId: acrPrivateDnsZone.id
        }
      }
    ]
  }
}

output acrId string = acr.id
output acrName string = acr.name
output acrLoginServer string = acr.properties.loginServer
