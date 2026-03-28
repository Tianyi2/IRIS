@description('Azure Cosmos DB deployment for ByteBark')

// Parameters
param accountName string
param location string
param tags object
param environmentName string

param keyVaultName string

@description('Enable Azure Cosmos DB Free Tier (not supported on some subscriptions)')
param enableFreeTier bool = false


// Variables
var databaseName = 'bytebark'
var containerName = 'datasets'
var partitionKeyPath = '/partitionKey'
var throughput = environmentName == 'prod' ? 1000 : 400

// Cosmos DB Account
resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2023-04-15' = {
  name: accountName
  location: location
  tags: tags
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    databaseAccountOfferType: 'Standard'
    enableAutomaticFailover: false
    enableMultipleWriteLocations: false
    enableFreeTier: enableFreeTier
    publicNetworkAccess: 'Enabled'
    networkAclBypass: 'AzureServices'
    capabilities: [
      {
        name: 'EnableServerless'
      }
    ]
  }
}

// Database
resource database 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2023-04-15' = {
  parent: cosmosDbAccount
  name: databaseName
  properties: {
    resource: {
      id: databaseName
    }
  }
}

// Container for datasets
resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-04-15' = {
  parent: database
  name: containerName
  properties: {
    resource: {
      id: containerName
      partitionKey: {
        paths: [partitionKeyPath]
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/_etag/?'
          }
        ]
      }
      defaultTtl: -1 // No automatic deletion
    }
    options: environmentName == 'dev' ? {} : {
      throughput: throughput
    }
  }
}

// Container for user sessions (if authentication is enabled)
resource sessionsContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-04-15' = {
  parent: database
  name: 'sessions'
  properties: {
    resource: {
      id: 'sessions'
      partitionKey: {
        paths: ['/userId']
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/_etag/?'
          }
        ]
      }
      defaultTtl: 86400 // 24 hours TTL for sessions
    }
    options: environmentName == 'dev' ? {} : {
      throughput: 400
    }
  }
}

// Reference to existing Key Vault
resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

// Store Cosmos DB primary key in Key Vault
resource cosmosDbKeySecret 'Microsoft.KeyVault/vaults/secrets@2023-07-01' = {
  parent: keyVault
  name: 'cosmos-db-key'
  properties: {
    value: cosmosDbAccount.listKeys().primaryMasterKey
  }
}

// Outputs
output accountName string = cosmosDbAccount.name
output endpoint string = cosmosDbAccount.properties.documentEndpoint
output databaseName string = databaseName
output containerName string = containerName
output resourceId string = cosmosDbAccount.id
