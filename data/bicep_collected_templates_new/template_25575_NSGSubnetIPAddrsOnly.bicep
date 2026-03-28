
param environment string
param nsgLocation string
param nsgPriority int
param subNetAllowedIpAddrs array

// Allow only the specified subnet addresses and deny all other Vnets
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: 'nsg-subnet_ip_allow-${environment}'
  location: nsgLocation
   
  properties: {
    securityRules: [
      {
        name: 'subnetIpAddrAllow'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: nsgPriority
          protocol: '*'
          description: 'Allow inbound access only from listed subnet ip addresses'
          sourceAddressPrefixes: subNetAllowedIpAddrs
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
      {
        name: 'AllowAzureLoadBalancerInBound'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: nsgPriority + 10
          protocol: '*'
          description: 'Allow Azure network load balancer access'
          sourceAddressPrefix: 'AzureLoadBalancer'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
      {
        name: 'OtherVnetInboundDeny'
        properties: {
          access: 'Deny'
          direction: 'Inbound'
          priority: nsgPriority + 20
          protocol: '*'
          description: 'Deny all other subnet access'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
        }
      }
    ]
  }
}

output nsgId string = nsg.id
output nsNameFullname string = nsg.name

