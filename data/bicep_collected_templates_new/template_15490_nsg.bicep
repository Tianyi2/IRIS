@description('Network Security Group name.')
param name string

@description('Location of the Network Security Group.')
param location string

@description('Name of the existing VNet.')
param vnetName string

@description('Name of the subnet to associate with the NSG.')
param subnetName string

@description('Address prefix of the subnet.')
param subnetPrefix string

@description('Tags applied to the NSG.')
param tags object = {}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: name
  location: location
  tags: tags
  properties: {
    securityRules: [
      // Add security rules here if needed
    ]
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: '${vnetName}/${subnetName}'
  properties: {
    addressPrefix: subnetPrefix
    privateEndpointNetworkPolicies: 'Disabled'
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}
