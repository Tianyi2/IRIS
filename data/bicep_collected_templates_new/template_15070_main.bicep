// Bicep template for deploying Jarvis Meeting Assistant to Azure
// This template creates:
// - Windows VM for app-hosted media bot
// - Azure Speech Service
// - Application Insights
// - Virtual Network with NSG rules

@description('Location for all resources')
param location string = resourceGroup().location

@description('Admin username for the VM')
param adminUsername string

@description('Admin password for the VM')
@secure()
param adminPassword string

@description('Size of the VM')
param vmSize string = 'Standard_D4s_v3'

@description('Bot App ID from Azure AD registration')
param botAppId string

@description('Bot App Secret')
@secure()
param botAppSecret string

@description('Azure Speech Service SKU')
param speechServiceSku string = 'S0'

var vmName = 'jarvis-bot-vm'
var nicName = '${vmName}-nic'
var vnetName = 'jarvis-vnet'
var subnetName = 'bot-subnet'
var nsgName = 'jarvis-nsg'
var publicIPName = '${vmName}-pip'
var speechServiceName = 'jarvis-speech-${uniqueString(resourceGroup().id)}'
var appInsightsName = 'jarvis-insights'

// Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
 '10.0.0.0/16'
   ]
}
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
        networkSecurityGroup: {
      id: nsg.id
          }
        }
      }
    ]
  }
}

// Network Security Group
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'AllowHTTPS'
     properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
        direction: 'Inbound'
    sourceAddressPrefix: '*'
          sourcePortRange: '*'
     destinationAddressPrefix: '*'
          destinationPortRange: '443'
        }
      }
      {
        name: 'AllowRDP'
     properties: {
 priority: 1001
   protocol: 'Tcp'
      access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '3389'
        }
      }
      {
        name: 'AllowMediaPorts'
        properties: {
          priority: 1002
          protocol: 'Udp'
          access: 'Allow'
     direction: 'Inbound'
   sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
    destinationPortRange: '50000-51000'
        }
      }
    ]
}
}

// Public IP
resource publicIP 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: publicIPName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    dnsSettings: {
      domainNameLabel: toLower('jarvis-bot-${uniqueString(resourceGroup().id)}')
    }
  }
}

// Network Interface
resource nic 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
    name: 'ipconfig1'
      properties: {
          subnet: {
    id: vnet.properties.subnets[0].id
        }
        privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIP.id
  }
 }
      }
    ]
  }
}

// Windows Server VM
resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
  computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
   provisionVMAgent: true
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
  managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
   {
       id: nic.id
  }
      ]
    }
  }
}

// Azure Speech Service
resource speechService 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: speechServiceName
  location: location
  sku: {
    name: speechServiceSku
  }
  kind: 'SpeechServices'
  properties: {
    publicNetworkAccess: 'Enabled'
    customSubDomainName: speechServiceName
  }
}

// Application Insights
resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web'
  properties: {
Application_Type: 'web'
    Request_Source: 'rest'
  }
}

// Outputs
output vmPublicIP string = publicIP.properties.ipAddress
output vmFQDN string = publicIP.properties.dnsSettings.fqdn
output speechServiceKey string = speechService.listKeys().key1
output speechServiceRegion string = location
output appInsightsInstrumentationKey string = appInsights.properties.InstrumentationKey
output appInsightsConnectionString string = appInsights.properties.ConnectionString
