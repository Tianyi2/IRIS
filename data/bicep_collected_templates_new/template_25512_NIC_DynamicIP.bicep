param vmName string
param subNetId string
param location string
param environment string

var var_nicName = '${vmName}Nic-${environment}'
var var_publicIp = '${vmName}PublicIp-${environment}'

resource publicIP 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: var_publicIp
  location:location
  properties: {
      publicIPAllocationMethod: 'Dynamic'
  }
}
resource networkInterface 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: var_nicName
  location:location
  properties: {
      ipConfigurations: [{
          name: 'ipconfig1'
          properties: {
              privateIPAllocationMethod: 'Dynamic'
              subnet: {
                  id: subNetId
              }
              publicIPAddress: {
                  id: publicIP.id
              }
          }
      }]
  }
}

output networkInterfaceId string = networkInterface.id

