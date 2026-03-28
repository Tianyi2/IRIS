metadata name = 'Azure Landing Zone - Configuration Loader'
metadata description = 'Centralized configuration loader that processes the alz-components.yaml configuration file'

// Configuration parameters loaded from centralized config
@description('Configuration loaded from config/alz-components.yaml')
param config object

@description('Environment name (overrides config if provided)')
param environment string = ''

@description('Organization prefix (overrides config if provided)')
param organizationPrefix string = ''

@description('Azure region (overrides config if provided)')
param location string = ''

// ============================
// CONFIGURATION PROCESSING
// ============================

// Get environment-specific config with inheritance
var baseEnvironment = environment != '' ? environment : config.global.environment
var environmentConfig = contains(config.environments, baseEnvironment) ? config.environments[baseEnvironment] : {}
var parentEnvironment = contains(environmentConfig, 'inherits') ? environmentConfig.inherits : ''
var parentConfig = parentEnvironment != '' && contains(config.environments, parentEnvironment) ? config.environments[parentEnvironment] : {}

// Merge configurations with precedence: parameter > environment-specific > parent environment > global
var mergedGlobalConfig = union(config.global, parentConfig.?global ?? {}, environmentConfig.?global ?? {})
var resolvedGlobalConfig = {
  environment: environment != '' ? environment : mergedGlobalConfig.environment
  organizationPrefix: organizationPrefix != '' ? organizationPrefix : mergedGlobalConfig.organizationPrefix
  location: location != '' ? location : mergedGlobalConfig.location
  subscriptionId: mergedGlobalConfig.?subscriptionId ?? ''
}

// Merge component configurations
var mergedNetworking = union(config.networking, parentConfig.?networking ?? {}, environmentConfig.?networking ?? {})
var mergedSecurity = union(config.security, parentConfig.?security ?? {}, environmentConfig.?security ?? {})
var mergedIdentity = union(config.identity, parentConfig.?identity ?? {}, environmentConfig.?identity ?? {})
var mergedApplications = union(config.applications, parentConfig.?applications ?? {}, environmentConfig.?applications ?? {})
var mergedContainers = union(config.containers, parentConfig.?containers ?? {}, environmentConfig.?containers ?? {})
var mergedData = union(config.data, parentConfig.?data ?? {}, environmentConfig.?data ?? {})
var mergedMonitoring = union(config.monitoring, parentConfig.?monitoring ?? {}, environmentConfig.?monitoring ?? {})

// ============================
// NAMING CONVENTIONS
// ============================

// Bicep naming functions with 'bi' prefix
var namingConventions = {
  // Resource Groups
  resourceGroup: {
    hub: 'rg-${resolvedGlobalConfig.organizationPrefix}-bi-hub-${resolvedGlobalConfig.environment}'
    spoke: 'rg-${resolvedGlobalConfig.organizationPrefix}-bi-spoke-${resolvedGlobalConfig.environment}'
    shared: 'rg-${resolvedGlobalConfig.organizationPrefix}-bi-shared-${resolvedGlobalConfig.environment}'
    management: 'rg-${resolvedGlobalConfig.organizationPrefix}-bi-mgmt-${resolvedGlobalConfig.environment}'
  }

  // Networking
  networking: {
    hubVnet: 'vnet-${resolvedGlobalConfig.organizationPrefix}-bi-hub-${resolvedGlobalConfig.environment}'
    spokeVnet: 'vnet-${resolvedGlobalConfig.organizationPrefix}-bi-spoke-${resolvedGlobalConfig.environment}'
    managementVnet: 'vnet-${resolvedGlobalConfig.organizationPrefix}-bi-mgmt-${resolvedGlobalConfig.environment}'
    hubToSpokePeering: 'peer-${resolvedGlobalConfig.organizationPrefix}-bi-hub-to-spoke-${resolvedGlobalConfig.environment}'
    spokeToHubPeering: 'peer-${resolvedGlobalConfig.organizationPrefix}-bi-spoke-to-hub-${resolvedGlobalConfig.environment}'
  }

  // Security
  security: {
    keyVault: 'kv-${resolvedGlobalConfig.organizationPrefix}-bi-${resolvedGlobalConfig.environment}-{uniqueSuffix}'
    bastion: 'bas-${resolvedGlobalConfig.organizationPrefix}-bi-hub-${resolvedGlobalConfig.environment}'
    bastionPip: 'pip-${resolvedGlobalConfig.organizationPrefix}-bi-bastion-${resolvedGlobalConfig.environment}'
    firewall: 'afw-${resolvedGlobalConfig.organizationPrefix}-bi-hub-${resolvedGlobalConfig.environment}'
    firewallPip: 'pip-${resolvedGlobalConfig.organizationPrefix}-bi-firewall-${resolvedGlobalConfig.environment}'
  }

  // Applications
  applications: {
    servicePlan: 'asp-${resolvedGlobalConfig.organizationPrefix}-bi-${resolvedGlobalConfig.environment}'
    webApp: 'app-${resolvedGlobalConfig.organizationPrefix}-bi-web-${resolvedGlobalConfig.environment}'
    functionApp: 'func-${resolvedGlobalConfig.organizationPrefix}-bi-${resolvedGlobalConfig.environment}'
    containerEnvironment: 'cae-${resolvedGlobalConfig.organizationPrefix}-bi-${resolvedGlobalConfig.environment}'
  }

  // Containers
  containers: {
    registry: 'acr${resolvedGlobalConfig.organizationPrefix}bi${resolvedGlobalConfig.environment}{uniqueSuffix}'
    cluster: 'aks-${resolvedGlobalConfig.organizationPrefix}-bi-${resolvedGlobalConfig.environment}-{uniqueSuffix}'
  }

  // Data
  data: {
    storageAccount: 'st${resolvedGlobalConfig.organizationPrefix}bi${resolvedGlobalConfig.environment}{uniqueSuffix}'
    postgresql: 'psql-${resolvedGlobalConfig.organizationPrefix}-bi-${resolvedGlobalConfig.environment}-{uniqueSuffix}'
  }

  // Monitoring
  monitoring: {
    logAnalytics: 'log-${resolvedGlobalConfig.organizationPrefix}-bi-${resolvedGlobalConfig.environment}-{uniqueSuffix}'
    applicationInsights: 'appi-${resolvedGlobalConfig.organizationPrefix}-bi-${resolvedGlobalConfig.environment}-{uniqueSuffix}'
  }
}

// ============================
// COMMON TAGS
// ============================

var commonTags = {
  Environment: resolvedGlobalConfig.environment
  Organization: resolvedGlobalConfig.organizationPrefix
  IaC: 'Bicep-AVM'
  ConfigVersion: config.metadata.version
  LastUpdated: config.metadata.lastUpdated
  ManagedBy: 'Azure-Landing-Zone'
  Pattern: 'Centralized-Configuration'
}

// ============================
// OUTPUTS
// ============================

// Global configuration
output global object = resolvedGlobalConfig
output commonTags object = commonTags
output namingConventions object = namingConventions

// Component configurations
output networking object = mergedNetworking
output security object = mergedSecurity
output identity object = mergedIdentity
output applications object = mergedApplications
output containers object = mergedContainers
output data object = mergedData
output monitoring object = mergedMonitoring

// Helper functions
output resourceEnabled object = {
  hubVnet: mergedNetworking.hubVnet.enabled
  spokeVnet: mergedNetworking.spokeVnet.enabled
  peering: mergedNetworking.peering.enabled
  keyVault: mergedSecurity.keyVault.enabled
  bastion: mergedSecurity.azureBastion.enabled
  firewall: mergedSecurity.azureFirewall.enabled
  containerRegistry: mergedContainers.containerRegistry.enabled
  aks: mergedContainers.aks.enabled
  webApps: mergedApplications.webApps.enabled
  functions: mergedApplications.functions.enabled
  containerApps: mergedApplications.containerApps.enabled
  postgresql: mergedData.postgresql.enabled
  storageAccount: mergedData.storageAccount.enabled
  logAnalytics: mergedMonitoring.logAnalytics.enabled
  applicationInsights: mergedMonitoring.applicationInsights.enabled
}

// Validation
output validationResults object = {
  configVersion: config.metadata.version
  environment: resolvedGlobalConfig.environment
  organizationPrefix: resolvedGlobalConfig.organizationPrefix
  location: resolvedGlobalConfig.location
  validConfiguration: length(resolvedGlobalConfig.organizationPrefix) >= 2 && length(resolvedGlobalConfig.organizationPrefix) <= 10
}
