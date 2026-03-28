targetScope = 'resourceGroup'

param appGwName string
param location string
param skuName string = 'WAF_v2'
param skuTier string = 'WAF_v2'
param subnetId string
param publicIpId string
param wafEnabled bool = true
param wafMode string = 'Prevention' // or Detection
param minCapacity int = 1
param maxCapacity int = 2

resource appGw 'Microsoft.Network/applicationGateways@2024-07-01' = {
  name: appGwName
  location: location
  properties: {
    sku: {
      name: skuName
      tier: skuTier
    }

    autoscaleConfiguration: {
      minCapacity: minCapacity
      maxCapacity: maxCapacity
    }

    gatewayIPConfigurations: [
      {
        name: 'appGwIpConfig'
        properties: {
          subnet: {
            id: subnetId
          }
        }
      }
    ]

    frontendIPConfigurations: [
      {
        name: 'appGwFrontendIp'
        properties: {
          publicIPAddress: {
            id: publicIpId
          }
        }
      }
    ]

    frontendPorts: [
      {
        name: 'appGwFrontendPort'
        properties: {
          port: 80
        }
      }
    ]

    backendAddressPools: [
      {
        name: 'dummyPool'
        properties: {
          backendAddresses: [
            {
              fqdn: 'example.com'
            }
          ]
        }
      }
    ]

    backendHttpSettingsCollection: [
      {
        name: 'httpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]

    httpListeners: [
      {
        name: 'httpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', appGwName, 'appGwFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', appGwName, 'appGwFrontendPort')
          }
          protocol: 'Http'
        }
      }
    ]

    requestRoutingRules: [
      {
        name: 'defaultRule'
        properties: {
          ruleType: 'Basic'
          priority: 100
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGwName, 'httpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGwName, 'dummyPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', appGwName, 'httpSettings')
          }
        }
      }
    ]

    webApplicationFirewallConfiguration: wafEnabled ? {
      enabled: true
      firewallMode: wafMode
      ruleSetType: 'OWASP'
      ruleSetVersion: '3.2'
    } : null
  }
}
