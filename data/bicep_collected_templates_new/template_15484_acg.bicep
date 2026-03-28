@description('Azure Compute Gallery name.')
param name string

@description('Resource location for the gallery.')
param location string

@description('Tags applied to the gallery and image definition.')
param tags object = {}

@description('Whether to create a default image definition inside the gallery.')
param createImageDef bool = true

@description('Image definition name (e.g., win11-base-tl).')
param imageDefName string = 'win11-base-tl'

@description('Publisher part of the image definition identifier.')
param imgPublisher string = 'Contoso'

@description('Offer part of the image definition identifier.')
param imgOffer string = 'DevBox'

@description('SKU part of the image definition identifier (must be unique within publisher/offer).')
param imgSku string = 'Win11-TL'

@description('Enable Trusted Launch feature for the image definition.')
param enableTrustedLaunch bool = true

@description('OS type for the image definition.')
@allowed([
  'Windows'
  'Linux'
])
param osType string = 'Windows'

@description('Hyper-V generation for the image definition.')
@allowed([
  'V1'
  'V2'
])
param hyperVGeneration string = 'V2'

@description('Architecture for the image definition.')
@allowed([
  'x64'
  'Arm64'
])
param architecture string = 'x64'

// Shared Image Gallery
resource gallery 'Microsoft.Compute/galleries@2022-01-03' = {
  name: name
  location: location
  tags: tags
  properties: {
    description: 'Azure Dev Box base images'
  }
}

// Optional default image definition
resource imgDef 'Microsoft.Compute/galleries/images@2022-03-03' = if (createImageDef) {
  name: imageDefName
  parent: gallery
  location: location
  tags: tags
  properties: {
    osType: osType
    osState: 'Generalized'
    hyperVGeneration: hyperVGeneration
    architecture: architecture
    identifier: {
      publisher: imgPublisher
      offer: imgOffer
      sku: imgSku
    }
    features: enableTrustedLaunch ? [
      {
        name: 'SecurityType'
        value: 'TrustedLaunch'
      }
    ] : []
  }
}

@description('Shared Image Gallery resource ID.')
output galleryId string = gallery.id

@description('Image definition resource ID (empty if not created).')
output imageDefId string = createImageDef ? imgDef.id : ''
