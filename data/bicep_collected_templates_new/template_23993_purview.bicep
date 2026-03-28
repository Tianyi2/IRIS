param purviewAccountName string
param location string
param managedResourceGroupName string
param skuName string = 'Standard'
param skuCapacity int = 1
param publicNetworkAccess string = 'Enabled' // 'Enabled' or 'Disabled'
param managedResourcesPublicNetworkAccess string = 'Enabled'
param managedEventHubState string = 'Enabled'

resource purview 'Microsoft.Purview/accounts@2024-04-01-preview' = {
  name: purviewAccountName
  location: location
  sku: {
    name: skuName
    capacity: skuCapacity
  }
  properties: {
    managedResourceGroupName: managedResourceGroupName
    publicNetworkAccess: publicNetworkAccess
    managedResourcesPublicNetworkAccess: managedResourcesPublicNetworkAccess
    managedEventHubState: managedEventHubState
  }
}
