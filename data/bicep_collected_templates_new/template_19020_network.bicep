@description('Please Provide Name for VNET')
param vnetname string

@description('Please Provide Name for VNET Gateway')
param virtualNetworkGateways_name string = '${vnetname}-vpn'

@description('VPN AAD Audience ID')
param vpnaudience string 

param location string = resourceGroup().location


resource defaultNSG 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: '${vnetname}-default-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'DenyExternalRDPSSH'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: 'Internet'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRanges: [
            '22'
            '3389'
          ]
          access: 'Deny'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetname
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'gatewaysubnet'
        properties: {
          addressPrefix: '10.0.254.0/24'
        }
      }
      {
        name: 'database'
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: 'aks'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
      {
        name: 'vm'
        properties: {
          addressPrefix: '10.0.3.0/24'
          networkSecurityGroup: {
            id: defaultNSG.id
          }
        }
      }
      {
        name: 'mgmt'
        properties: {
          addressPrefix: '10.0.0.0/24'
          networkSecurityGroup: {
            id: defaultNSG.id
          }
        }
      }
      {
        name: 'appservice'
        properties: {
          addressPrefix: '10.0.4.0/24'
          networkSecurityGroup: {
            id: defaultNSG.id
          }
        }
      }
      {
        name: 'functions'
        properties: {
          addressPrefix: '10.0.5.0/24'
          networkSecurityGroup: {
            id: defaultNSG.id
          }
        }
      }
      {
        name: 'batch'
        properties: {
          addressPrefix: '10.0.6.0/24'
          networkSecurityGroup: {
            id: defaultNSG.id
          }
        }
      }
    ]
  }
}


resource publicIp 'Microsoft.Network/publicIPAddresses@2022-01-01' = {
  name: '${virtualNetworkGateways_name}-pip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}



resource virtualNetworkGateways 'Microsoft.Network/virtualNetworkGateways@2023-05-01' = {
  name: virtualNetworkGateways_name
  location: location
  properties: {
    enablePrivateIpAddress: false
    ipConfigurations: [
      {
        name: '${virtualNetworkGateways_name}-ip-config'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id: '${virtualNetwork.id}/subnets/gatewaysubnet'
          }
        }
      }
    ]
    natRules: []
    virtualNetworkGatewayPolicyGroups: []
    enableBgpRouteTranslationForNat: false
    disableIPSecReplayProtection: false
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
    activeActive: false
    vpnClientConfiguration: {
      vpnClientAddressPool: {
        addressPrefixes: [
          '192.168.1.0/24'
        ]
      }
      vpnClientProtocols: [
        'OpenVPN'
      ]
      vpnAuthenticationTypes: [
        'AAD'
      ]
      vpnClientRootCertificates: []
      vpnClientRevokedCertificates: []
      vngClientConnectionConfigurations: []
      radiusServers: []
      vpnClientIpsecPolicies: []
      aadTenant:  '${environment().authentication.loginEndpoint}${tenant().tenantId}'  
      aadAudience: vpnaudience
      aadIssuer: 'https://sts.windows.net/${tenant().tenantId}/' 
    }
    vpnGatewayGeneration: 'Generation1'
    allowRemoteVnetTraffic: false
    allowVirtualWanTraffic: false
  }
}
