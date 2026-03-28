targetScope = 'resourceGroup'

param name string
param location string
param skuName string
param skuTier string
param capacity int

resource plan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: name
  location: location
  sku: {
    name: skuName
    tier: skuTier
    capacity: capacity
  }
  kind: 'app'
  properties: {
    reserved: false
  }
}

output appServicePlanName string = plan.name
output appServicePlanId string = plan.id
