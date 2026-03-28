targetScope = 'subscription'

@description('Name of the resource group.')
param name string

@description('Location of the resource group.')
param location string

@description('Tags applied to the resource group.')
param tags object = {}

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: name
  location: location
  tags: tags
}

@description('Name of the created resource group.')
output rgName string = rg.name
