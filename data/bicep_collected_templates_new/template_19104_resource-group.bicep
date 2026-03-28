targetScope = 'subscription'

param location string
param name string

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: name
  location: location
}

output resourceGroupName string = rg.name
output location string = rg.location