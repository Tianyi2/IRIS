@allowed([
  'Public'
  'PubDev'
])
param environment string
param appSettings object = {}

resource serverfarm 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: 'serverfarm'
  location: resourceGroup().location
  sku: {
    name: 'B1'
  }
}

resource webapp 'Microsoft.Web/sites@2021-03-01' = {
  name: 'webapp'
  location: resourceGroup().location
  properties: {
    serverFarmId: serverfarm.id
  }

  resource appsettings 'config@2021-03-01' = {
    name: 'appsettings'
    properties: union(appSettings, {
      ASPNETCORE_ENVIRONMENT: environment
    })
  }

  resource stagingSlot 'slots@2021-03-01' = {
    name: 'stagingSlot'
    location: resourceGroup().location
    properties: {
      serverFarmId: serverfarm.id
    }

    resource  appSettings 'config@2021-03-01' = {
      name: 'appsettings'
      properties: webapp::appsettings.properties
    }
  }
}
