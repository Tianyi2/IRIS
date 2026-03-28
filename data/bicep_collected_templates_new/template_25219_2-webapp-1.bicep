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
}
