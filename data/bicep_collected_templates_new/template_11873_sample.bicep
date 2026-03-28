@description('Web app name.')
@minLength(2)
@maxLength(64)
param webAppName string = 'webApp-${uniqueString(resourceGroup().id)}'

// The following list of regions are the Azure regions that support Availability Zones. Enabling Availability Zones is recommended as it provides increased resiliency for your App Service apps. If you need to use a region that is not listed here, you won't be able to use Availability Zones. To learn more, see https://learn.microsoft.com/azure/reliability/reliability-app-service?pivots=premium.
@description('Location for all resources. This region must support Availability Zones.')
@allowed([
  'brazilsouth'
  'canadacentral'
  'centralus'
  'eastus'
  'eastus2'
  'southcentralus'
  'westus2'
  'westus3'
  'mexicocentral'
  'francecentral'
  'italynorth'
  'germanywestcentral'
  'norwayeast'
  'northeurope'
  'uksouth'
  'westeurope'
  'swedencentral'
  'switzerlandnorth'
  'polandcentral'
  'spaincentral'
  'qatarcentral'
  'uaenorth'
  'israelcentral'
  'southafricanorth'
  'australiaeast'
  'centralindia'
  'japaneast'
  'japanwest'
  'southeastasia'
  'eastasia'
  'koreacentral'
  'newzealandnorth'
  'usgovvirginia'
  'chinanorth3'
  'ussecwestcentral'
])
param location string = 'eastus'

@description('The SKU of App Service Plan.')
param sku string = 'P1v3' // P1v3 is from the Premium v3 SKU offering. This is one of the production SKU offerings. You can resize this option based on your needs. Each of the SKUs have different prices and may have different features available. To learn more, see https://azure.microsoft.com/pricing/details/app-service/windows/?msockid=0a6035fcc17b67023fcf2079c0386601.

@description('OS of your Azure App Service plan.')
@allowed([
  'Windows'
  'Linux'
  'Windows Container'
])
param appServicePlanHostingOS string = 'Linux'

@description('The Runtime stack of current web app')
param linuxFxVersion string = 'PYTHON|3.12' // Update this to align with your app's runtime. Using the Azure CLI, run "az webapp list-runtimes" to view the latest languages and supported versions. If the runtime your application requires isn't supported in the built-in images, you can deploy it with a custom container.

@description('The allowed IP/CIDR defines what is allowed to access the app. This should be restricted to your client IP for example. Leaving it as the default makes your app publicly accessible.')
param allowedIps string = '0.0.0.0/0' // We've left this open to the internet for this sample to prevent access issues when creating an app from this template. However, for your application, you should set access restrictions based on a least privilege model to ensure only those that need access can access your app. To learn more, see https://learn.microsoft.com/azure/app-service/networking-features#access-restrictions.

var appUserManagedIdentityName = 'umi-${webAppName}'
var appServicePlanName = 'AppServicePlan-${webAppName}'
var vnetName = '${webAppName}-vnet'
var vnetAddressPrefix = '10.0.0.0/16'
var subnetName = '${webAppName}-sn'
var subnetAddressPrefix = '10.0.0.0/24'
var logAnalyticsName = 'logAnalytics-${webAppName}'
var diagnosticSettingName = 'diagnosticSetting-${webAppName}'
var appInsightName = 'appInsights-${webAppName}'

// A virtual network is created to use the virtual network integration feature, which enables your app to make outbound requests into an Azure virtual network. To learn more about virtual network integrations, see https://learn.microsoft.com/azure/app-service/networking-features#regional-vnet-integration.
// To manange inbound requests, review the private endpoint feature at https://learn.microsoft.com/azure/app-service/networking-features#private-endpoint. Private endpoint configuration is not provided in this sample but is certainly a recommended feature if you need to connect secure inbound connections to your app.
resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-03-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          delegations: [
            {
              name: 'delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms' // The subnet is delegated to this value to let the subnet know it is being used for App Service virtual network integration.
              }
            }
          ]
        }
      }
    ]
  }
}

// Managed identity is used because if needed, it wil allow your app to easily access other Microsoft Entra protected resources such as Azure Key Vault. As a best practice, you should enable and configure a managed identity following a least privilege model. To learn more, see https://learn.microsoft.com/azure/app-service/overview-managed-identity?tabs=arm%2Chttp.
resource appUserManagedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-07-31-preview' = {
  name: appUserManagedIdentityName
  location: location
}

resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
    capacity: 3 // This is the number of instances for this App Service plan. It is set to 3 because the zoneRedundancy property is enabled, which means you intend to use Availability Zones. If you enable Availability Zones, you must have a minimum of 3 instances.
  }
  properties: {
    reserved: appServicePlanHostingOS == 'Linux' ? true : false // Set this to "true" for Linux or "false" for Windows. We've included logic here so that you don't have to set this yourself. The property will be set based on your selection in the "appServicePlanHostingOS" parameter. 
    hyperV: appServicePlanHostingOS == 'Windows Container' ? true : false
    zoneRedundant: true // This property enables Availability Zones for your App Service plan. All apps in this plan will be zone redundant, meaning the instances will be distributed across the maximum number of available zones. This feature can only be enabled if you are in a region that supports Availability Zones and if you are placed on an App Service scale unit that supports Availability Zones. Enabling this property will enforce a minimum instance count of 3 instances, which is why the capacity above is set to 3. To learn more, see https://learn.microsoft.com/azure/reliability/reliability-app-service?pivots=premium.
    elasticScaleEnabled: true // This feature enables automatic scaling. This ensures your app scales to meet the demand of your HTTP traffic. If you enable this feature, you don't need to set scaling rules. To learn more, see https://learn.microsoft.com/azure/app-service/manage-automatic-scaling?tabs=azure-portal.
    maximumElasticWorkerCount: 30 // This property is the highest number of instances that your App Service Plan can increase to based on incoming HTTP requests. For Premium v2 & v3 plans, you can set a maximum burst of up to 30 instances. The maximum burst must be equal to or greater than the number of workers specified for the App Service Plan. To learn more, see https://learn.microsoft.com/azure/reliability/reliability-app-service?pivots=premium.
  }
}

resource webApp 'Microsoft.Web/sites@2024-04-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    virtualNetworkSubnetId: virtualNetwork.properties.subnets[0].id // Enables virtual network integration in the subnet that was created in this template.
    vnetRouteAllEnabled: true // Enables application routing. Application routing defines what traffic is routed from your app and into the virtual network. We recommend that you use the vnetRouteAllEnabled site setting to enable routing of all traffic rather than the existing app setting WEBSITE_VNET_ROUTE_ALL so that you can audit the behavior with a Azure Policy. To learn more, see https://learn.microsoft.com/azure/app-service/configure-vnet-integration-routing#configure-application-routing.
    vnetBackupRestoreEnabled: true // Enables configuration routing - backup/restore. This setting routes backup traffic through the virtual network. To learn more, see https://learn.microsoft.com/azure/app-service/configure-vnet-integration-routing#backuprestore.
    vnetContentShareEnabled: true // Enables configuration routing - content share. This setting routes content share through the virtual network. To learn more, see https://learn.microsoft.com/azure/app-service/configure-vnet-integration-routing#content-share.
    vnetImagePullEnabled: true // Enables configuration routing - container image pull. This setting routes container image pull through the virtual network. To learn more, see https://learn.microsoft.com/azure/app-service/configure-vnet-integration-routing#backuprestore.
    httpsOnly: true // Enforces HTTPS and redirects all HTTP traffic to HTTPS.
    endToEndEncryptionEnabled: true // Prevents TLS termination of incoming HTTPS requests. Encrypts intra-cluster traffic between App Service front-ends and workers running application workloads, so TLS doesn't get terminated on the front-ends. https://techcommunity.microsoft.com/blog/appsonazureblog/end-to-end-e2e-tls-encryption-preview-on-linux-multi-tenant-app-service-resource/3976646  
    autoGeneratedDomainNameLabelScope: 'TenantReuse'
    sshEnabled: false // Enables SSH access to your app. https://learn.microsoft.com/azure/app-service/configure-linux-open-ssh-session?pivots=container-linux
    ipMode: 'IPv4AndIPv6' // Defines what kind of addresses you can send traffic to. https://azure.github.io/AppService/2024/11/08/Announcing-Inbound-IPv6-support.html.
    publicNetworkAccess: 'Enabled' // Enables or disables public access to your app. This setting should be used with access restrictions to ensure only principals that need access can access your app. To learn more, see https://learn.microsoft.com/azure/app-service/app-service-ip-restrictions?tabs=azurecli.
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      minTlsVersion: '1.3' // TLS 1.3 is the latest version. This setting defines the minimum TLS encryption version required by clients connecting to your app. To learn more, see https://learn.microsoft.com/azure/app-service/overview-tls.
      minTlsCipherSuite: 'TLS_AES_256_GCM_SHA384' // To learn more, see https://learn.microsoft.com/azure/app-service/overview-tls#minimum-tls-cipher-suite.
      scmMinTlsVersion: '1.3' // TLS 1.3 is the latest version. This setting defines the minimum TLS encryption version required by clients connecting to the SCM/Kudu site of your app. To learn more, see https://learn.microsoft.com/azure/app-service/overview-tls.
      ftpsState: 'Disabled' // FTPS state is disabled to block all FTP connections and prevent unauthorized access to your app. To learn more, see https://learn.microsoft.com/azure/app-service/deploy-ftp.
      http20Enabled: true // Enables clients to connect to the app over HTTP/2.
      remoteDebuggingEnabled: false // Remote debugging is disabled to prevent unauthorized access to the app.
      antivirusScanEnabled: true
      ipSecurityRestrictions: [ // The block is used to configure the app's access restrictions and can be modified by updating the allowedIps parameter. To learn more, see https://learn.microsoft.com/azure/app-service/networking-features#access-restrictions.
        {
          ipAddress: allowedIps
          action: 'Allow'
          priority: 100
          name: 'Allowed IPs'
        }
      ]
      ipSecurityRestrictionsDefaultAction: 'Deny' // Sets the default access restriction to deny all traffic. Only explicitly defined IPs will be able to access the app. To learn more, see https://learn.microsoft.com/azure/app-service/networking-features#access-restrictions.
      scmIpSecurityRestrictionsDefaultAction: 'Deny' // Sets the default access restriction for the SCM/Kudu site to deny all traffic. Only explicitly defined IPs will be able to access the app. To learn more, see https://learn.microsoft.com/azure/app-service/networking-features#access-restrictions.
      scmIpSecurityRestrictionsUseMain: true // Copies the access restrictions set for the main site. If you need to further restrict access to the SCM site, you should set this to false and define another set of access restrictions using the scmIpSecurityRestrictions property.
    }
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${appUserManagedIdentity.id}': {}
    }
  }
  resource appSettings 'config' = {
    name: 'appsettings'
    properties: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: 'true' // This app setting is provided as an example and may not apply to all apps. To learn more, see https://learn.microsoft.com/azure/app-service/reference-app-settings.
    }
  }
  dependsOn: [
    logAnalyticsWorkspace
  ]
}

// App Service provides basic authentication for FTP and WebDeploy clients to connect to it by using deployment credentials. These APIs are great for browsing your site’s file system, uploading drivers and utilities, and deploying with MsBuild. However, enterprises often require more secure deployment methods than basic authentication, such as Microsoft Entra ID authentication. For that reason, it's recommended to disable these features. To learn more, see https://learn.microsoft.com/azure/app-service/configure-basic-auth-disable.
resource ftpPolicy 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  name: 'ftp'
  location: location
  kind: 'string'
  parent: webApp
  properties: {
    allow: false
  }
}

// App Service provides basic authentication for FTP and WebDeploy clients to connect to it by using deployment credentials. These APIs are great for browsing your site’s file system, uploading drivers and utilities, and deploying with MsBuild. However, enterprises often require more secure deployment methods than basic authentication, such as Microsoft Entra ID authentication. For that reason, it's recommended to disable these features. To learn more, see https://learn.microsoft.com/azure/app-service/configure-basic-auth-disable.
resource scmPolicy 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  name: 'scm'
  location: location
  kind: 'string'
  parent: webApp
  properties: {
    allow: true
  }
}

// Creates a log analytics workspace to stream logs to. To learn more, see https://learn.microsoft.com/azure/app-service/monitor-app-service.
resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 120
    features: {
      searchVersion: 1
      legacy: 0
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

// This resource defines the diagnostic settings that are enabled and sends them to the log analytics workspace. In this example, all available settings are enabled. To learn more, see https://learn.microsoft.com/azure/app-service/troubleshoot-diagnostic-logs.
resource setting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: diagnosticSettingName
  scope: webApp
  properties: {
    workspaceId: logAnalyticsWorkspace.id
    logs: [
      {
        category: 'AppServiceAntivirusScanAuditLogs'
        enabled: true
      }
      {
        category: 'AppServiceHTTPLogs'
        enabled: true
      }
      {
        category: 'AppServiceConsoleLogs'
        enabled: true
      }
      {
        category: 'AppServiceAppLogs'
        enabled: true
      }
      {
        category: 'AppServiceFileAuditLogs'
        enabled: true
      }
      {
        category: 'AppServiceAuditLogs'
        enabled: true
      }
      {
        category: 'AppServiceIPSecAuditLogs'
        enabled: true
      }
      {
        category: 'AppServicePlatformLogs'
        enabled: true
      }
      {
        category: 'AppServiceAuthenticationLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

// This resource creates an App Service slot for your app. It includes the same properties and configurations as the main site. Whenever possible, when you deploy a new production build, use deployment slots to test and validate your build before pushing to production. To learn more, see https://learn.microsoft.com/azure/app-service/deploy-staging-slots.
resource webAppSlot 'Microsoft.Web/sites/slots@2024-04-01' = {
  parent: webApp
  name: 'stage'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    virtualNetworkSubnetId: virtualNetwork.properties.subnets[0].id
    vnetRouteAllEnabled: true
    vnetBackupRestoreEnabled: true
    vnetContentShareEnabled: true
    vnetImagePullEnabled: true
    httpsOnly: true
    endToEndEncryptionEnabled: true
    autoGeneratedDomainNameLabelScope: 'TenantReuse'
    sshEnabled: false
    ipMode: 'IPv4AndIPv6'
    publicNetworkAccess: 'Enabled'
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      minTlsVersion: '1.3'
      minTlsCipherSuite: 'TLS_AES_256_GCM_SHA384'
      scmMinTlsVersion: '1.3'
      ftpsState: 'Disabled'
      http20Enabled: true
      remoteDebuggingEnabled: false
      antivirusScanEnabled: true
      ipSecurityRestrictions: [
        {
          ipAddress: allowedIps
          action: 'Allow'
          priority: 100
          name: 'Allowed IPs'
        }
      ]
      ipSecurityRestrictionsDefaultAction: 'Deny'
      scmIpSecurityRestrictionsDefaultAction: 'Deny'
      scmIpSecurityRestrictionsUseMain: true
    }
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${appUserManagedIdentity.id}': {}
    }
  }
  resource appSettings 'config' = {
    name: 'appsettings'
    properties: {
      SCM_DO_BUILD_DURING_DEPLOYMENT: 'true'
    }
  }
}

resource ftpPolicySlot 'Microsoft.Web/sites/slots/basicPublishingCredentialsPolicies@2022-03-01' = {
  name: 'ftp'
  location: location
  kind: 'string'
  parent: webAppSlot
  properties: {
    allow: false
  }
}

resource scmPolicySlot 'Microsoft.Web/sites/slots/basicPublishingCredentialsPolicies@2022-03-01' = {
  name: 'scm'
  location: location
  kind: 'string'
  parent: webAppSlot
  properties: {
    allow: false
  }
}
