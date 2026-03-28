param vmName string
@minLength(5)
param adminUsername string
@minLength(6)
@maxLength(20)
@secure()
param adminPassword string
param networkInterfaceId string
param locaton string
param environment string
param diagStorageUri string

var var_vmName = 'vm-${vmName}-${environment}'

resource virtualMachine 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: var_vmName
  location: locaton
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    osProfile: {
      computerName: var_vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2016-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaceId
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: diagStorageUri
      }
    }
  }
}

output vmId string = virtualMachine.id
output vmFullName string = virtualMachine.name
