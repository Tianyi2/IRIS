@description('Name of the Azure Container Registry (5–50 chars, lowercase alphanumeric).')
param name string

@description('Location of the Azure Container Registry.')
param location string

@description('If true, public network access to ACR is disabled. If false, public endpoint is enabled.')
param disablePublicNetworkAccess bool = true

@description('Tags applied to the registry.')
param tags object = {}

resource acr 'Microsoft.ContainerRegistry/registries@2022-02-01-preview' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: 'Premium'
  }
  properties: {
    adminUserEnabled: false

    // Public endpoint ON/OFF – independent from private endpoints
    publicNetworkAccess: disablePublicNetworkAccess ? 'Disabled' : 'Enabled'

    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        type: 'Notary'
        status: 'disabled'
      }
      retentionPolicy: {
        days: 7
        status: 'enabled'
      }
    }
  }
}

@description('ACR name.')
output name string = acr.name

@description('ACR resource ID.')
output id string = acr.id

@description('ACR login server (FQDN).')
output loginServer string = acr.properties.loginServer
