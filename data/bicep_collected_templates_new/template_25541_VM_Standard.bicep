param vmName string
@minLength(5)
param adminUsername string
@minLength(6)
@maxLength(12)
@secure()
param adminPassword string
param networkInterfaceId string
param locaton string = resourceGroup().location
param environment string

var var_vmName = '${vmName}-${environment}'

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
          networkInterfaces: [{
              id: networkInterfaceId
          }]
      }
  }
}

output vmId string = virtualMachine.id
