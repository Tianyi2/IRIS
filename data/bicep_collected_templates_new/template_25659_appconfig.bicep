@description('Deploys an Azure App Configuration resource')
param appConfigName string
param location string
param tags object
@allowed(['Free','Standard'])
param appConfigSku string = 'Standard'

resource appConfig 'Microsoft.AppConfiguration/configurationStores@2024-06-01' = {
  name: appConfigName
  location: location
  sku: {
    name: appConfigSku
  }
  tags: tags
}

output connectionString string = listKeys(appConfig.id, '2024-06-01').value[0].connectionString

