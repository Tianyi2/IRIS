// Dev Box Project under a Dev Center
targetScope = 'resourceGroup'

@description('Name of the Dev Center where the project will be created')
param devCenterName string

@description('Name of the Dev Center project to create')
param projectName string

@description('Location for the project')
param location string

@description('Common tags')
param tags object = {}

// Dev Center is a separate resource; we only reference its ID
resource devCenter 'Microsoft.DevCenter/devcenters@2024-02-01' existing = {
  name: devCenterName
}

// IMPORTANT:
// Project is top-level type Microsoft.DevCenter/projects
// and we link it to the Dev Center via properties.devCenterId.
resource project 'Microsoft.DevCenter/projects@2025-02-01' = {
  name: projectName
  location: location
  properties: {
    devCenterId: devCenter.id
    // NOTE: Keep the Project configuration minimal and idempotent.
    // Project-level attached networks (Microsoft.DevCenter/projects/attachednetworks) are not deployable via ARM/Bicep due to OpenAPI preflight validation.
    // description: 'Dev Box project for dvbx-dev'
    // maxDevBoxesPerUser: 0   // 0 = no limit
  }
  tags: tags
}

output id string = project.id
output nameOut string = project.name
