targetScope = 'resourceGroup'

param subnetName string
param addressPrefix string
param vnetName string

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-07-01' = {
  name: '${vnetName}/${subnetName}'
  properties: {
    addressPrefix: addressPrefix
  }
}
