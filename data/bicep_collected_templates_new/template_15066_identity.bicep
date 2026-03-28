// =============================================================================
// Identity Module - RBAC Role Assignments
// =============================================================================

@description('VM Managed Identity Principal ID')
param vmPrincipalId string

@description('Key Vault Name')
param keyVaultName string

@description('Azure OpenAI Name')
param openAIName string

@description('Azure Speech Name')
param speechName string

@description('Storage Account Name')
param storageAccountName string

@description('Application Insights Name')
param appInsightsName string

@description('Log Analytics Workspace Name')
param logAnalyticsWorkspaceName string

// =============================================================================
// ROLE DEFINITION IDs (Built-in Azure RBAC Roles)
// =============================================================================

var roleDefinitions = {
  keyVaultSecretsUser: '4633458b-17de-408a-b874-0445c86b69e6'
  cognitiveServicesUser: 'a97b65f3-24c7-4388-baec-2e87135dc908'
  storageBlobDataContributor: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe'
  monitoringMetricsPublisher: '3913510d-42f4-4e42-8a64-420c390055eb'
  logAnalyticsReader: '73c42c96-874c-492b-b04d-ab87d138a893'
}

// =============================================================================
// RESOURCE REFERENCES
// =============================================================================

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

resource openAI 'Microsoft.CognitiveServices/accounts@2023-05-01' existing = {
  name: openAIName
}

resource speech 'Microsoft.CognitiveServices/accounts@2023-05-01' existing = {
  name: speechName
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' existing = {
  name: storageAccountName
}

resource appInsights 'Microsoft.Insights/components@2020-02-02' existing = {
  name: appInsightsName
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: logAnalyticsWorkspaceName
}

// =============================================================================
// RBAC: Key Vault Secrets User
// =============================================================================

resource kvRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVault.id, vmPrincipalId, roleDefinitions.keyVaultSecretsUser)
  scope: keyVault
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitions.keyVaultSecretsUser)
    principalId: vmPrincipalId
    principalType: 'ServicePrincipal'
  }
}

// =============================================================================
// RBAC: Cognitive Services User (OpenAI)
// =============================================================================

resource openAIRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(openAI.id, vmPrincipalId, roleDefinitions.cognitiveServicesUser)
  scope: openAI
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitions.cognitiveServicesUser)
    principalId: vmPrincipalId
    principalType: 'ServicePrincipal'
  }
}

// =============================================================================
// RBAC: Cognitive Services User (Speech)
// =============================================================================

resource speechRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(speech.id, vmPrincipalId, roleDefinitions.cognitiveServicesUser)
  scope: speech
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitions.cognitiveServicesUser)
    principalId: vmPrincipalId
    principalType: 'ServicePrincipal'
  }
}

// =============================================================================
// RBAC: Storage Blob Data Contributor
// =============================================================================

resource storageRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(storageAccount.id, vmPrincipalId, roleDefinitions.storageBlobDataContributor)
  scope: storageAccount
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitions.storageBlobDataContributor)
    principalId: vmPrincipalId
    principalType: 'ServicePrincipal'
  }
}

// =============================================================================
// RBAC: Monitoring Metrics Publisher (App Insights)
// =============================================================================

resource appInsightsRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(appInsights.id, vmPrincipalId, roleDefinitions.monitoringMetricsPublisher)
  scope: appInsights
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitions.monitoringMetricsPublisher)
    principalId: vmPrincipalId
    principalType: 'ServicePrincipal'
  }
}

// =============================================================================
// RBAC: Log Analytics Reader
// =============================================================================

resource logAnalyticsRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(logAnalyticsWorkspace.id, vmPrincipalId, roleDefinitions.logAnalyticsReader)
  scope: logAnalyticsWorkspace
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitions.logAnalyticsReader)
    principalId: vmPrincipalId
    principalType: 'ServicePrincipal'
  }
}

// =============================================================================
// KEY VAULT ACCESS POLICY (Alternative to RBAC if needed)
// =============================================================================

// Note: Using RBAC above, but keeping this as reference
// Uncomment if you need access policies instead of RBAC

/*
resource keyVaultAccessPolicy 'Microsoft.KeyVault/vaults/accessPolicies@2023-07-01' = {
  parent: keyVault
  name: 'add'
  properties: {
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: vmPrincipalId
        permissions: {
          secrets: [
            'get'
            'list'
          ]
          certificates: [
            'get'
            'list'
          ]
        }
      }
    ]
  }
}
*/

// =============================================================================
// OUTPUTS
// =============================================================================

@description('All RBAC assignments completed')
output rbacAssignmentsComplete bool = true

@description('Key Vault Role Assignment ID')
output keyVaultRoleAssignmentId string = kvRoleAssignment.id

@description('OpenAI Role Assignment ID')
output openAIRoleAssignmentId string = openAIRoleAssignment.id

@description('Speech Role Assignment ID')
output speechRoleAssignmentId string = speechRoleAssignment.id

@description('Storage Role Assignment ID')
output storageRoleAssignmentId string = storageRoleAssignment.id

@description('App Insights Role Assignment ID')
output appInsightsRoleAssignmentId string = appInsightsRoleAssignment.id

@description('Log Analytics Role Assignment ID')
output logAnalyticsRoleAssignmentId string = logAnalyticsRoleAssignment.id
