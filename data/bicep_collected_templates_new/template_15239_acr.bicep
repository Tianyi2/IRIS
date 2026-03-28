@minLength(5)
@maxLength(50)
@description('Globally unique name for your Azure Container Registry')
param acrName string = 'aifinancialregistry'

@description('Location for the registry')
param location string = resourceGroup().location

@description('Tier of your Azure Container Registry')
@allowed([
  'Basic'
  'Standard'
  'Premium'
])
param acrSku string = 'Basic'

resource acrResource 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: true // set to false later once you switch to managed identity
  }
}

output loginServer string = acrResource.properties.loginServer
output acrName string = acrResource.name
