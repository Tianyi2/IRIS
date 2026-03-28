param appServiceName string = take('nfappsvc${uniqueString(resourceGroup().id)}', 24)
param location string = resourceGroup().location

var tags = {
  'nf-app-type': 'Example'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'nfexampleplan'
  location: location
  tags: tags
  kind: 'app,linux'
  sku: {
    name: 'F1'
  }
  properties: {
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceName
  location: location
  tags: tags
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    clientAffinityEnabled: false
    httpsOnly: true
    siteConfig: {
      ftpsState: 'Disabled'
      linuxFxVersion: 'DOTNETCORE|7.0'
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
    }
  }
}

output appName string = appServiceName
output appUrl string = 'https://${appService.properties.defaultHostName}'
