// Bicep template - creates namespace-prefixed resources using 'prefix' parameter
param prefix string = 'codiebyheart'
param location string = resourceGroup().location

// Resource: Storage Account
resource st 'Microsoft.Storage/storageAccounts@2023-06-01' = {
  name: toLower('${prefix}st')
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {}
}

// Resource: Service Bus Namespace
resource sb 'Microsoft.ServiceBus/namespaces@2023-10-01' = {
  name: '${prefix}-sb'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {}
}

resource sbQueue 'Microsoft.ServiceBus/namespaces/queues@2023-10-01' = {
  parent: sb
  name: 'codiebyheart-queue'
  properties: {
    enablePartitioning: true
  }
}

// Resource: Key Vault
resource kv 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${prefix}-kv'
  location: location
  properties: {
    tenantId: subscription().tenantId
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enableSoftDelete: true
  }
}

// Application Insights
resource ai 'Microsoft.Insights/components@2020-02-02' = {
  name: '${prefix}-ai'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

// PostgreSQL Flexible Server (Basic sample config — review for production)
resource pg 'Microsoft.DBforPostgreSQL/flexibleServers@2023-03-01' = {
  name: '${prefix}-pg'
  location: location
  properties: {
    version: '15'
    administratorLogin: 'pgadminuser'
    administratorLoginPassword: 'ReplacePassword123!' // suggest to use Key Vault in production
    storage: {
      storageSizeGB: 32
    }
  }
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'GeneralPurpose'
    capacity: 2
  }
}

// Container Apps Environment (Log analytics workspace could be added)
resource caEnv 'Microsoft.App/managedEnvironments@2023-10-01' = {
  name: '${prefix}-ca-env'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
    }
  }
}

// Outputs useful connection strings / names for reference
output storageAccountName string = st.name
output serviceBusNamespace string = sb.name
output serviceBusQueue string = sbQueue.name
output keyVaultName string = kv.name
output appInsightsName string = ai.name
output postgresName string = pg.name
output containerAppsEnvironment string = caEnv.name
