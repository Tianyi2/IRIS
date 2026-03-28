targetScope = 'resourceGroup'

param firewallName string
param location string
param skuTier string
param skuName string
param subnetId string
param publicIpId string

resource firewall 'Microsoft.Network/azureFirewalls@2024-07-01' = {
  name: firewallName
  location: location
  properties: {
    sku: {
      name: skuName
      tier: skuTier
    }
    ipConfigurations: [
      {
        name: 'azureFirewallIpConfig'
        properties: {
          subnet: {
            id: subnetId
          }
          publicIPAddress: {
            id: publicIpId
          }
        }
      }
    ]
    threatIntelMode: 'Alert'
  }
}
