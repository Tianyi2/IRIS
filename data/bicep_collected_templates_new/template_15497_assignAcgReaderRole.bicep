targetScope = 'resourceGroup'

@description('Name of the Azure Compute Gallery in this resource group')
param acgName string

@description('Principal ID (managed identity) of the Dev Center that should read the ACG')
param devCenterPrincipalId string

resource acg 'Microsoft.Compute/galleries@2024-03-01' existing = {
  name: acgName
}

// Built-in Reader role
var readerRoleDefinitionId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'acdd72a7-3385-48ef-bd42-f606fba81ae7')

resource acgReaderForDevCenter 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(acg.id, devCenterPrincipalId, 'acg-reader')
  scope: acg
  properties: {
    roleDefinitionId: readerRoleDefinitionId
    principalId: devCenterPrincipalId
    principalType: 'ServicePrincipal'
  }
}
