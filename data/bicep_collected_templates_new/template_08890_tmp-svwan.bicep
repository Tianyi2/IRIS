param virtualWanName string
param virtualWanLocation string
param virtualWanSku string = 'Standard'
param virtualHubName string
param virtualHubAddressPrefix string
param deployAzureFirewall bool = true
param azureFirewallName string
param azureFirewallPublicIpName string
param azureFirewallPublicIpSku string = 'Standard'

resource virtualWan 'Microsoft.Network/virtualWans@2021-02-01' = {
  name: virtualWanName
  location: virtualWanLocation
}

resource virtualHub 'Microsoft.Network/virtualHubs@2021-02-01' = {
  name: virtualHubName
  location: virtualWanLocation
  dependsOn: [
    virtualWan
  ]
  properties: {
    addressPrefix: virtualHubAddressPrefix
    virtualRouterAsn: 65010
    vpnGateway: {
      type: 'RouteBased'
      sku: {
        name: 'VpnGw1'
      }
    }
    securityPartnerProvider: {
      // virtualHub: {
      //   id: virtualHub.id
      // }
      securityProviderName: 'Azure Firewall'
    }
  }
}

resource azureFirewall 'Microsoft.Network/azureFirewalls@2020-11-01' = if (deployAzureFirewall) {
  name: azureFirewallName
  location: virtualWanLocation
  dependsOn: [
    virtualHub
  ]
  properties: {
    ipConfigurations: [
      {
        name: 'AzureFirewallIpConfig'
        subnet: {
          id: virtualHub.properties.subnets[0].id
        }
        publicIpAddress: {
          id: resourceId('Microsoft.Network/publicIpAddresses', azureFirewallPublicIpName)
        }
      }
    ]
  }
}

resource azureFirewallPublicIp 'Microsoft.Network/publicIpAddresses@2021-02-01' = if (deployAzureFirewall) {
  name: azureFirewallPublicIpName
  location: virtualWanLocation
  sku: {
    name: azureFirewallPublicIpSku
  }
  properties: {
    publicIpAllocationMethod: 'Static'
  }
}
