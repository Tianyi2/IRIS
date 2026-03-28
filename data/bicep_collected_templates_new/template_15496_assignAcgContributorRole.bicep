targetScope = 'resourceGroup'

@description('Name of the Azure Compute Gallery in this resource group')
param acgName string

@description('Principal ID (objectId) of the Dev Center managed identity')
param devCenterPrincipalId string

// Built-in Contributor role
var contributorRoleId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'b24988ac-6180-42a0-ab88-20f7382dd24c')

resource acg 'Microsoft.Compute/galleries@2024-03-01' existing = {
  name: acgName
}

resource acgContributor 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(acg.id, devCenterPrincipalId, contributorRoleId)
  scope: acg
  properties: {
    roleDefinitionId: contributorRoleId
    principalId: devCenterPrincipalId
    principalType: 'ServicePrincipal'
  }
}
