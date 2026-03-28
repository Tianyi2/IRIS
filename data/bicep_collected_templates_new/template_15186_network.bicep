@description('Location for all resources.')
param location string

resource vnet 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: 'vnet-workload'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet-pgsql-001'
        properties: {
          addressPrefix: '10.0.90.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          delegations: [
            {
              name: 'postgresFlex'
              properties: {
                serviceName: 'Microsoft.DBforPostgreSQL/flexibleServers'
              }
            }
          ]
          networkSecurityGroup: {
            id: pgsqlNSG.id
          }
        }
      }
      {
        name: 'subnet-vm-001'
        properties: {
          addressPrefix: '10.0.20.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          networkSecurityGroup: {
            id: vmNSG.id
          }
        }
      }
    ]
  }
}

resource vmNSG 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: 'nsg-vm'
  location: location
  properties: {
    securityRules: [
      {
        name: 'allow-ssh-ingress'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '22'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'allow-internet-egress'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Outbound'
          destinationPortRange: '*'
          protocol: '*'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource pgsqlNSG 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: 'nsg-pgsql'
  location: location
  properties: {
    securityRules: [
      {
        name: 'allow-ssh-ingress'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '5432'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

output vnetId string = vnet.id
output pgsqlSubnetId string = vnet.properties.subnets[0].id
output vmSubnetId string = vnet.properties.subnets[1].id
