

param vmName string
param location string

var iisExtensionName = 'IIS'

resource vm 'Microsoft.Compute/virtualMachines@2020-06-01' existing = {
  name: vmName
}

resource iisExtension 'Microsoft.Compute/virtualMachines/extensions@2021-03-01' = {
  name: '${vmName}-${iisExtensionName}'
   parent: vm
  location: location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.10'
    autoUpgradeMinorVersion: true
    settings: {
      commandToExecute: 'powershell.exe Add-WindowsFeature Web-Server -IncludeManagementTools'
    }
    protectedSettings: {}
  }
}
