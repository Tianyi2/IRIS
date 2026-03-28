param vnetName string
param subnetName string
param addressPrefix string
param networkSecurtyGroupId string = ''

var var_subNetName = '${vnetName}-${subnetName}'


// Get existing vnet
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: vnetName
}

// Add network security group
resource subnetNsg 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' =  if ( length(networkSecurtyGroupId) != 0 ) {
  name: var_subNetName
  parent: vnet
  properties: {
    addressPrefix: addressPrefix
    networkSecurityGroup :{
       id: networkSecurtyGroupId
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' =  if ( length(networkSecurtyGroupId) == 0 ) {
  name: var_subNetName
  parent: vnet
  properties: {
    addressPrefix: addressPrefix
  }
}


// Output the subnet Id so can be referenced by other resources
output subnetId string = subnetNsg != null ? subnetNsg.id : subnet.id
output subnetAddressPrefix string = subnetNsg != null ? subnetNsg.properties.addressPrefix : subnet.properties.addressPrefix
