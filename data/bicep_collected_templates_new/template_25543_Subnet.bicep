param vnetName string
param subnetName string
param environment string
param addressPrefix string

var var_vnetName = '${vnetName}-${environment}'
var var_subNetName = '${vnetName}-${subnetName}'


// Get existing vnet
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: var_vnetName
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: var_subNetName
  parent: vnet
  properties: {
    addressPrefix: addressPrefix
  }
}

// Output the subnet Id so can be referenced by other resources
output subnetId string = subnet.id
