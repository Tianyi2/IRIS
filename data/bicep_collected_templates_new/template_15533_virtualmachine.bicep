targetScope = 'resourceGroup'

@description('Location for resources.')
param location string = resourceGroup().location
@description('Name of virtual machine.')
param virtualMachineName string = 'vmdesdemo'
@description('Size for virtual machine.')
param virtualMachineSize string = 'Standard_D2s_v3'
@secure()
@minLength(1)
@maxLength(20)
@description('Virtual machine administrator user name. Minimum length 1, maximum length 20')
param adminUsername string
@secure()
@minLength(12)
@maxLength(123)
@description('Virtual machine administrator password. Minimum length 12, maximum length 123')
param adminPassword string
@description('Publisher of virtual machine image.')
param imagePublisher string = 'MicrosoftWindowsServer'
@description('Offer for virtual machine image.')
param imageOffer string = 'WindowsServer'
@description('SKU of virtual machine image.')
param imageSku string = '2019-Datacenter'
@description('Version of virtual machine image.')
param imageVersion string = 'latest'
@description('Name of operating system managed disk.')
param osDiskName string = 'mdk-desdemo-os'
@description('Storage type of managed disk.')
param osDiskType string = 'StandardSSD_LRS'
@description('Name of network interface.')
param networkInterfaceName string = 'nic-desdemo'
@description('Name of virtual network.')
param virtualNetworkName string = 'vnet-desdemo'
@description('Array of adddresses for virtual network.')
param virtualNetworkAddresses array = [
  '10.0.0.0/16'
]
@description('Array of DNS server addresses for virtual network. Leave blank to use Azure default.')
param virtualNetworkDnsServers array = []
@description('Name of virtual network subnet.')
param subnetName string = 'snet-desdemo'
@description('Address for virtual network subnet.')
param subnetAddress string = '10.0.0.0/24'
@description('Name of existing disk encryption set. Must be in same resource group and region as virtual machine.')
param diskEncryptionSetName string = 'des-demo'

resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2021-08-01' existing = {
  name: diskEncryptionSetName
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: virtualNetworkAddresses
    }
    dhcpOptions: {
      dnsServers: virtualNetworkDnsServers
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddress
        }
      }
    ]
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: networkInterfaceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${virtualNetwork.id}/subnets/${subnetName}'
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: virtualMachineName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    osProfile: {
      computerName: virtualMachineName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {}
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
    storageProfile: {
      imageReference: {
        publisher: imagePublisher
        offer: imageOffer
        sku: imageSku
        version: imageVersion
      }
      osDisk: {
        createOption: 'FromImage'
        name: osDiskName
        deleteOption: 'Delete'
        managedDisk: {
          storageAccountType: osDiskType
          diskEncryptionSet: {
            id: diskEncryptionSet.id
          }
        }
      }
    }
  }
}
