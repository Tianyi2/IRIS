param location string
param applicationName string
param environment string
param principalId string

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
    name: 'kv-${applicationName}-euw-${environment}'
    location: location
    properties: {
        sku: {
            family: 'A'
            name: 'standard'
        }
        tenantId: subscription().tenantId
        accessPolicies: [] // either use RBAC or access policies - recommended approach is to use RBAC for new designs
        enableSoftDelete: true
        enableRbacAuthorization: true
        publicNetworkAccess: 'Enabled'
    }
}

resource keyVaultAccess 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
    name: guid(keyVault.id, principalId, 'KeyVaultSecretsUser')
    scope: keyVault
    properties: {
        roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '4633458b-17de-408a-b874-0445c86b69e6') // Key Vault Secrets User
        principalId: principalId
        principalType: 'ServicePrincipal'
    }
}

output keyVaultId string = keyVault.id
output keyVaultName string = keyVault.name
output keyVaultUri string = keyVault.properties.vaultUri