// =============================================================================
// Network Module - Virtual Network, NSG, Public IP
// =============================================================================

@description('Azure region')
param location string

@description('Resource prefix')
param prefix string

@description('Environment name')
param environmentName string

@description('Admin source IP for RDP access (format: x.x.x.x/32)')
param adminSourceIP string

@description('Custom domain name (optional)')
param customDomain string

@description('Resource tags')
param tags object

// =============================================================================
// VARIABLES
// =============================================================================

var vnetName = '${prefix}-vnet-${environmentName}'
var nsgName = '${prefix}-nsg-${environmentName}'
var publicIPName = '${prefix}-pip-${environmentName}'
var dnsLabel = '${prefix}-${environmentName}-${uniqueString(resourceGroup().id)}'

// =============================================================================
// NETWORK SECURITY GROUP
// =============================================================================

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: nsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowHTTPS'
        properties: {
          priority: 100
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
          description: 'Allow HTTPS from Internet (Bot Framework + Graph Calling)'
        }
      }
      {
        name: 'AllowHTTP'
        properties: {
          priority: 110
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: '*'
          description: 'Allow HTTP from Internet (redirect to HTTPS + Let\'s Encrypt challenges)'
        }
      }
      {
        name: 'AllowRDP'
        properties: {
          priority: 200
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: adminSourceIP
          destinationAddressPrefix: '*'
          description: 'Allow RDP from admin IP only'
        }
      }
      {
        name: 'DenyAllInbound'
        properties: {
          priority: 4000
          direction: 'Inbound'
          access: 'Deny'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          description: 'Deny all other inbound traffic'
        }
      }
    ]
  }
}

// =============================================================================
// PUBLIC IP ADDRESS
// =============================================================================

resource publicIP 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: publicIPName
  location: location
  tags: tags
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    dnsSettings: customDomain == '' ? {
      domainNameLabel: dnsLabel
    } : null
    idleTimeoutInMinutes: 4
  }
}

// =============================================================================
// VIRTUAL NETWORK
// =============================================================================

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'jarvis-vm-subnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: nsg.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'jarvis-pe-subnet'
        properties: {
          addressPrefix: '10.0.2.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
  }
}

// =============================================================================
// OUTPUTS
// =============================================================================

@description('Network Security Group ID')
output nsgId string = nsg.id

@description('Network Security Group Name')
output nsgName string = nsg.name

@description('Virtual Network ID')
output vnetId string = vnet.id

@description('Virtual Network Name')
output vnetName string = vnet.name

@description('VM Subnet ID')
output vmSubnetId string = vnet.properties.subnets[0].id

@description('Private Endpoint Subnet ID')
output peSubnetId string = vnet.properties.subnets[1].id

@description('Public IP ID')
output publicIPId string = publicIP.id

@description('Public IP Address')
output publicIPAddress string = publicIP.properties.ipAddress

@description('Public FQDN')
output publicFQDN string = customDomain != '' ? customDomain : publicIP.properties.dnsSettings.fqdn
