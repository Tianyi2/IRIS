@description('Specifies the name of the Azure Storage account.')
param storageAccountName string

@description('Specifies the name of the blob container.')
param containerName string


resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  name: '${storageAccountName}/default/${containerName}'
}
