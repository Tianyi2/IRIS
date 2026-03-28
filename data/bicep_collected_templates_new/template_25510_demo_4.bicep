
param par_location string = resourceGroup().location
param par_vnets array

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = [for vnet in par_vnets: {
  
  name: vnet.name
  location: par_location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet.addressPrefix
      ]
    }


    subnets: [for subnet in vnet.subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.subnetPrefix
      }
    }]
  }

}]


