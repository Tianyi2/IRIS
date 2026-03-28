param nicName string
param location string
param subnetId string
@allowed([
  'Dynamic'
  'Static'
])
param privateIPAllocationMethod string = 'Dynamic'
@description('Optional NSG to associate with this NIC.')
param networkSecurityGroupId string = ''
@description('Optional Public IP to associate with this NIC.')
param publicIpId string = ''

resource nic 'Microsoft.Network/networkInterfaces@2024-07-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: privateIPAllocationMethod
          publicIPAddress: empty(publicIpId) ? null : {
            id: publicIpId
          }
        }
      }
    ]
    networkSecurityGroup: empty(networkSecurityGroupId) ? null : {
      id: networkSecurityGroupId
    }
  }
}

output id string = nic.id
