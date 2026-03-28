@description('Azure Firewall name.')
param name string

@description('Location of the Azure Firewall.')
param location string

@description('Name of existing VNet that contains AzureFirewallSubnet.')
param vnetName string

@description('Tags applied to the firewall and its public IP.')
param tags object = {}

resource fwPublicIP 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: '${name}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource fw 'Microsoft.Network/azureFirewalls@2023-04-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    ipConfigurations: [
      {
        name: 'ipconfig'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, 'AzureFirewallSubnet')
          }
          publicIPAddress: {
            id: fwPublicIP.id
          }
        }
      }
    ]
  }
}
