// =============================================================================
// Storage Module
// =============================================================================

@description('Azure region')
param location string

@description('Resource prefix')
@minLength(1)
@maxLength(10)
param prefix string

@description('Unique suffix for global uniqueness')
param uniqueSuffix string

@description('Resource tags')
param tags object

// =============================================================================
// VARIABLES
// =============================================================================

// Storage account names must be 3-24 characters, lowercase letters and numbers only
// prefix is at least 1 char + 'st' (2 chars) + uniqueSuffix (13 chars) = minimum 16 chars
var storageAccountName = toLower('${prefix}st${uniqueSuffix}')

// =============================================================================
// STORAGE ACCOUNT
// =============================================================================

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      defaultAction: 'Allow' // Change to 'Deny' for production with specific rules
      bypass: 'AzureServices'
      ipRules: []
      virtualNetworkRules: []
    }
    encryption: {
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

// =============================================================================
// BLOB SERVICE
// =============================================================================

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

// =============================================================================
// BLOB CONTAINERS
// =============================================================================

resource bootDiagnosticsContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'bootdiagnostics'
  properties: {
    publicAccess: 'None'
  }
}

resource appLogsContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'app-logs'
  properties: {
    publicAccess: 'None'
  }
}

resource backupsContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'backups'
  properties: {
    publicAccess: 'None'
  }
}

// =============================================================================
// LIFECYCLE MANAGEMENT
// =============================================================================

resource lifecyclePolicy 'Microsoft.Storage/storageAccounts/managementPolicies@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    policy: {
      rules: [
        {
          enabled: true
          name: 'MoveOldLogsToArchive'
          type: 'Lifecycle'
          definition: {
            actions: {
              baseBlob: {
                tierToCool: {
                  daysAfterModificationGreaterThan: 90
                }
                delete: {
                  daysAfterModificationGreaterThan: 365
                }
              }
            }
            filters: {
              blobTypes: [
                'blockBlob'
              ]
              prefixMatch: [
                'app-logs/'
              ]
            }
          }
        }
      ]
    }
  }
}

// =============================================================================
// OUTPUTS
// =============================================================================

@description('Storage Account ID')
output storageAccountId string = storageAccount.id

@description('Storage Account Name')
output storageAccountName string = storageAccount.name

@description('Storage Account Primary Endpoints')
output storageAccountPrimaryEndpoints object = storageAccount.properties.primaryEndpoints
