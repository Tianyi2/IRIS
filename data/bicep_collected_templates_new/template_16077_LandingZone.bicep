targetScope = 'subscription'

@description('Short prefix for resource names (e.g., "contoso").')
param prefix string

@description('Primary Azure region for core resources.')
param location string = 'canadacentral'

@description('Regions allowed for deployments (Policy-lite: enforced via VNet location suggestion & tagging; use Azure Policy for true enforcement).')
param allowedLocations array = [
  'canadacentral'
  'canadaeast'
]

@description('Default subscription-level tags to apply to created resources.')
param defaultTags object = {
  Environment: 'prod'
  Owner: 'platform-team'
  CostCenter: '1000'
}

@description('Monthly budget amount in the subscription currency (set 0 to skip).')
@minValue(0)
param monthlyBudgetAmount float = 1000

@description('Emails to notify for budget alerts.')
param contactEmails array = []

@description('Object IDs (AAD) to assign Reader at the subscription (optional).')
param readerPrincipalObjectIds array = []

@description('Log Analytics retention (days).')
@minValue(30)
@maxValue(730)
param laRetentionDays int = 180

@description('Whether Key Vault should deny public network by default.')
param kvDenyPublicNetwork bool = true

@description('Key Vault RBAC authorization (true) vs legacy access policies (false).')
param kvUseRBACAuth bool = true

@description('SKU for Log Analytics.')
@allowed([ 'PerGB2018' ])
param laSku string = 'PerGB2018'

var rgCoreName     = '${prefix}-rg-core'
var rgNetworkName  = '${prefix}-rg-network'
var rgSecurityName = '${prefix}-rg-security'
var rgWorkloadName = '${prefix}-rg-workload'

var laName     = '${prefix}-law'
var saLogsName = toLower('${prefix}stlogs${uniqueString(subscription().subscriptionId)}')
var kvName     = '${prefix}-kv'
var rsvName    = '${prefix}-rsv'
var vnetName   = '${prefix}-vnet-hub'

// ---------- Resource Groups ----------
resource rgCore 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgCoreName
  location: location
  tags: defaultTags
}
resource rgNetwork 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgNetworkName
  location: location
  tags: defaultTags
}
resource rgSecurity 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgSecurityName
  location: location
  tags: defaultTags
}
resource rgWorkload 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgWorkloadName
  location: location
  tags: defaultTags
}

// ---------- Log Analytics (central logging) ----------
resource law 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: laName
  location: location
  scope: rgSecurity
  tags: defaultTags
  properties: {
    retentionInDays: laRetentionDays
    features: {
      legacy: 0
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
  sku: {
    name: laSku
  }
}

// Solutions (optional but common: Security + Agent Health)
resource solutionSecurity 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'Security(${law.name})'
  location: location
  scope: rgSecurity
  properties: {
    workspaceResourceId: law.id
    containedResources: []
  }
  plan: {
    name: 'Security(${law.name})'
    product: 'OMSGallery/Security'
    publisher: 'Microsoft'
  }
}

resource solutionAgentHealth 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'AgentHealthAssessment(${law.name})'
  location: location
  scope: rgSecurity
  properties: {
    workspaceResourceId: law.id
    containedResources: []
  }
  plan: {
    name: 'AgentHealthAssessment(${law.name})'
    product: 'OMSGallery/AgentHealthAssessment'
    publisher: 'Microsoft'
  }
}

// ---------- Storage Account for logs/archives ----------
resource saLogs 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: saLogsName
  location: location
  scope: rgSecurity
  tags: defaultTags
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        blob: { enabled: true }
        file: { enabled: true }
      }
      keySource: 'Microsoft.Storage'
    }
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
  }
}

// ---------- Recovery Services Vault (for backups) ----------
resource rsv 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: rsvName
  location: location
  scope: rgSecurity
  tags: defaultTags
  sku: {
    name: 'Standard'
  }
  properties: {}
}

// ---------- Key Vault (for secrets/keys) ----------
resource kv 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: kvName
  location: location
  scope: rgSecurity
  tags: defaultTags
  properties: {
    tenantId: subscription().tenantId
    enableRbacAuthorization: kvUseRBACAuth
    enablePurgeProtection: true
    enableSoftDelete: true
    publicNetworkAccess: kvDenyPublicNetwork ? 'Disabled' : 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    networkAcls: kvDenyPublicNetwork ? {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
      ipRules: []
      virtualNetworkRules: []
    } : null
  }
}

// ---------- Hub VNet + subnets + NSGs ----------
resource nsgHub 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: '${prefix}-nsg-hub'
  location: location
  scope: rgNetwork
  tags: defaultTags
  properties: {}
}

resource nsgWorkload 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: '${prefix}-nsg-workload'
  location: location
  scope: rgNetwork
  tags: defaultTags
  properties: {}
}

resource vnetHub 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  scope: rgNetwork
  tags: union(defaultTags, {
    AllowedRegions: concat(allowedLocations)
  })
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.0.0.0/27'
          networkSecurityGroup: { id: nsgHub.id }
        }
      }
      {
        name: 'hub'
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: { id: nsgHub.id }
        }
      }
      {
        name: 'workload'
        properties: {
          addressPrefix: '10.0.2.0/24'
          networkSecurityGroup: { id: nsgWorkload.id }
        }
      }
      {
        name: 'private-endpoints'
        properties: {
          addressPrefix: '10.0.3.0/24'
          privateEndpointNetworkPolicies: 'Disabled'
          networkSecurityGroup: { id: nsgWorkload.id }
        }
      }
    ]
  }
}

// ---------- Subscription Activity Log -> LA + Storage ----------
resource subDiag 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${prefix}-sub-activitylog'
  scope: subscription()
  properties: {
    workspaceId: law.id
    storageAccountId: saLogs.id
    logs: [
      { category: 'Administrative', enabled: true }
      { category: 'Security',       enabled: true }
      { category: 'ServiceHealth',  enabled: true }
      { category: 'Alert',          enabled: true }
      { category: 'Recommendation', enabled: true }
      { category: 'Policy',         enabled: true }
      { category: 'Autoscale',      enabled: true }
      { category: 'ResourceHealth', enabled: true }
    ]
    metrics: [
      { category: 'AllMetrics', enabled: true }
    ]
  }
}

// ---------- Budget
