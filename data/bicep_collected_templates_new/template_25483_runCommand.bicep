param name string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' existing = {
  name: 'stg${replace(name,'-','')}'
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-06-01' existing = {
  parent: storageAccount
  name: 'default'
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-06-01' existing = {
  parent: blobService
  name: name
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' existing = {
  name: 'vm-${name}'
}

resource deploymentscript 'Microsoft.Compute/virtualMachines/runCommands@2022-03-01' = {
  parent: virtualMachine
  name: 'RunPowerShellScript'
  location: location
  properties: {
    source: {
      script: loadTextContent('runCommand.ps1')
    }
    parameters: [
      {
        name: 'siteName'
        value: '${instance.name}-${name}'
      }
      {
        name: 'applicationPool'
        value: replace('${instance.name}-${name}','-','')
      }
    ]
    outputBlobUri: '${storageAccount.properties.primaryEndpoints.blob}${blobContainer.name}/runCommand-${instance.name}.log'
    errorBlobUri: '${storageAccount.properties.primaryEndpoints.blob}${blobContainer.name}/runCommand-${instance.name}-error.log'
  }
}