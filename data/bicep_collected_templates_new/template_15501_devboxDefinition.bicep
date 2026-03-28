targetScope = 'resourceGroup'

@description('Full resource ID of the Dev Center (the parent resource)')
param devCenterId string

@description('Name of the Dev Box definition to create under the Dev Center')
param devBoxDefinitionName string

@description('Location for the Dev Box definition')
param location string

@description('Name of the gallery attached to the Dev Center')
param acgName string

@description('Name of the image in that gallery (as seen by Dev Center), e.g. win11-base')
param devCenterImageName string

@description('SKU name for this Dev Box definition (compute SKU name from Dev Center)')
param skuName string

@description('Enable hibernation for all Dev Box definitions in this deployment.')
param enableHibernation bool

@description('Common tags')
param tags object = {}

resource devCenter 'Microsoft.DevCenter/devcenters@2024-02-01' existing = {
  name: last(split(devCenterId, '/'))
}

// Dev Box Definition
resource devBoxDefinition 'Microsoft.DevCenter/devcenters/devboxdefinitions@2024-02-01' = {
  name: '${devCenter.name}/${devBoxDefinitionName}'
  location: location
  properties: {
    imageReference: {
      // Dev Center-scoped image ID
      id: '${devCenterId}/galleries/${acgName}/images/${devCenterImageName}'
    }
    sku: {
      name: skuName
    }
    // Enable / disable hibernation for this definition
    hibernateSupport: enableHibernation ? 'Enabled' : 'Disabled'
  }
  tags: tags
}

output id string = devBoxDefinition.id
output nameOut string = devBoxDefinition.name
