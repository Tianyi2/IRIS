@minLength(1)
@maxLength(64)
@description('Name of the resource group that will contain all the resources')
param resourceGroupName string = resourceGroup().name

@minLength(1)
@description('Primary location for all resources')
param location string = resourceGroup().location

var resourceToken = toLower(uniqueString(subscription().id, resourceGroupName, location))
var containerRegistryName = 'acr${resourceToken}'

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: containerRegistryName
  location: location
  sku: {
      name: 'Basic'
  }
  properties: {
      adminUserEnabled: true
      dataEndpointEnabled: false
      encryption: {
        status: 'disabled'
      }
      networkRuleBypassOptions: 'AzureServices'
      publicNetworkAccess: 'Enabled'
      zoneRedundancy: 'Disabled'
  }
}

resource identity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: 'acrpullid${resourceToken}'
  location: location
}

var acrPullRole = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '7f951dda-4ed3-4680-a7ca-43fe172d538d')

resource aksAcrPull 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: containerRegistry // Use when specifying a scope that is different than the deployment scope
  name: guid(subscription().id, resourceGroup().id, acrPullRole)
  properties: {
      roleDefinitionId: acrPullRole
      principalType: 'ServicePrincipal'
      principalId: identity.properties.principalId
  }
}

output containerRegistryUrl string = containerRegistry.properties.loginServer
output managedIdentityName string = identity.name
