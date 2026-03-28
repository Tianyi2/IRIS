param location string
param bastionHostName string = 'bastion'
param vnetName string
param laName string

@allowed([
  'Basic'
  'Standard'
])
param bastionHostSku string = 'Standard'
param bastionHostScaleUnits int = 2
param enableIpConnect bool = true
param enableTunneling bool = true
//param enableKerberos bool = true
param disableCopyPaste bool = false
param enableShareableLink bool = true
param enableFileCopy bool = true
param publicIpAddressName string = 'bastion-pip'
param tags object = {}

var dnsName = '${bastionHostName}-${uniqueString(resourceGroup().id)}'

resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' existing = {
  name: vnetName
}

resource bastionSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' existing = {
  name: 'AzureBastionSubnet'
  parent: vnet
}

resource pip 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: publicIpAddressName
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource pipDiagnosticsettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: pip
  name: '${pip.name}-diagnosticSettings'
  properties: {
    workspaceId: la.id
    metrics: [
      {
        timeGrain: 'PT1M'
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
    ]
    logs: [
      {
        categoryGroup: 'audit'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
      {
        categoryGroup: 'allLogs'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
    ]
  }
}

// https://docs.microsoft.com/en-us/azure/templates/microsoft.network/bastionhosts?tabs=bicep
resource bastion 'Microsoft.Network/bastionHosts@2021-05-01' = {
  name: bastionHostName
  location: location
  tags: tags
  sku: {
    name: bastionHostSku
  }
  properties: {
    enableIpConnect: enableIpConnect
    enableTunneling: enableTunneling
//    enableKerberos: enableKerberos
    enableShareableLink: enableShareableLink
    disableCopyPaste: disableCopyPaste
    dnsName:dnsName
    enableFileCopy:enableFileCopy
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: bastionSubnet.id
          }
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
    scaleUnits: bastionHostScaleUnits
  }
}

resource la 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' existing = {
  name:laName
}

resource diagnosticsettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: bastion
  name: '${bastion.name}-diagnosticSettings'
  properties: {
    workspaceId: la.id
    metrics: [
      {
        timeGrain: 'PT1M'
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
    ]
    logs:[
      {
        categoryGroup: 'AllLogs'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
    ]
  }
}
