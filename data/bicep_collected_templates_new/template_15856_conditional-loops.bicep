// Advanced Bicep with conditionals in loops
param vmConfigs array = [
  {
    name: 'vm-web-01'
    size: 'Standard_B2s'
    enabled: true
  }
  {
    name: 'vm-web-02'
    size: 'Standard_B2s'
    enabled: true
  }
  {
    name: 'vm-test-01'
    size: 'Standard_B1s'
    enabled: false
  }
]
param location string = 'eastus'
param adminUsername string = 'azureuser'

// Only deploy enabled VMs
resource vms 'Microsoft.Compute/virtualMachines@2021-03-01' = [
  for config in vmConfigs: if (config.enabled) {
    name: config.name
    location: location
    properties: {
      hardwareProfile: {
        vmSize: config.size
      }
      osProfile: {
        computerName: config.name
        adminUsername: adminUsername
      }
      storageProfile: {
        imageReference: {
          publisher: 'Canonical'
          offer: 'UbuntuServer'
          sku: '18.04-LTS'
          version: 'latest'
        }
      }
    }
  }
]

// Count would need to be calculated differently
output deployedVmNames array = [for config in vmConfigs: config.enabled ? config.name : 'disabled']
