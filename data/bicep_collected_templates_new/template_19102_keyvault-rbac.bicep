@description('Reference to the Key Vault resource ID')
param keyVaultId string
param principalId string //id of the resource you wish to assign to the user role

resource keyVaultAccess 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    name: guid(keyVaultId, principalId, 'KeyVaultSecretsUser')
    scope: keyVaultId
    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6') // Key Vault Secrets User
        principalId: principalId
        principalType: 'ServicePrincipal'
    }
}