param name string
param location string
param securityRules array

resource nsg 'Microsoft.Network/networkSecurityGroups@2024-07-01' = {
  name: name
  location: location
  properties: {
    securityRules: [
      for rule in securityRules: {
        name: rule.name
        properties: {
          priority: rule.priority
          direction: rule.direction
          access: rule.access
          protocol: rule.protocol
          sourceAddressPrefix: rule.sourceAddressPrefix
          destinationAddressPrefix: rule.destinationAddressPrefix
          destinationPortRange: rule.destinationPortRange
          sourcePortRange: rule.sourcePortRange
        }
      }
    ]
  }
}
