// Attach Azure Compute Gallery (ACG) to Dev Center
targetScope = 'resourceGroup'

@description('Name of the existing Dev Center')
param devCenterName string

@description('Full Resource ID of the Azure Compute Gallery (ACG)')
param acgId string

@description('Name of the Azure Compute Gallery (ACG) - used as the gallery name in Dev Center')
param acgName string

resource attachGallery 'Microsoft.DevCenter/devcenters/galleries@2024-02-01' = {
  name: '${devCenterName}/${acgName}'
  properties: {
    galleryResourceId: acgId
  }
}

output galleryName string = attachGallery.name
