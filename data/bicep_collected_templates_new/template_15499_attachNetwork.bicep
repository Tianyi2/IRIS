targetScope = 'resourceGroup'

@description('Name of the Dev Center')
param devCenterName string

@description('Name of the attached network connection record')
param attachedNetworkName string = 'nc-default'

@description('Resource ID of the existing Network Connection')
param networkConnectionId string

// Dev Center already exists in this resource group
resource devCenter 'Microsoft.DevCenter/devcenters@2024-02-01' existing = {
  name: devCenterName
}

// Attach the network connection to the Dev Center
resource attachedNetwork 'Microsoft.DevCenter/devcenters/attachednetworks@2024-05-01-preview' = {
  name: attachedNetworkName
  parent: devCenter
  properties: {
    networkConnectionId: networkConnectionId
  }
}

output nameOut string = attachedNetwork.name
