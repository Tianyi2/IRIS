param environment string
param nsgLocation string
param nsgPriority int
param allowedIpAddrs array

// Allow only the specified public IP addresses
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-09-01' = {
  name: 'nsg-pub_ip_allow-${environment}'
  location: nsgLocation
  properties: {
    securityRules: [
      {
        name: 'pubIpAddrAllow'
        properties: {
          access: 'Allow'
          direction: 'Inbound'
          priority: nsgPriority
          protocol: '*'
          description: 'Allow public access only from listed ip addresses'
          sourceAddressPrefixes: allowedIpAddrs
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

