param envName string
param location string
param appPlanSku string
param appPlanCapacity int = 1

resource appPlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'asp-prexpiry-${envName}'
  location: location
  sku: {
    name: appPlanSku
    capacity: appPlanCapacity
  }
}

resource app 'Microsoft.Web/sites@2023-01-01' = {
  name: 'prexpiry-${envName}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appPlan.id
    httpsOnly: true
  }
}
