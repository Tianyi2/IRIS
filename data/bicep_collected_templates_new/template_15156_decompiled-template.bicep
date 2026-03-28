param serverfarms_UKSouthPlan_name string = 'UKSouthPlan'
param components_Chapter2DocumentClassifier_name string = 'Chapter2DocumentClassifier'
param storageAccounts_tutch2docsclassifierst_name string = 'tutch2docsclassifierst'
param sites_Chapter2DocumentClassifier20240912215556_name string = 'Chapter2DocumentClassifier20240912215556'
param accounts_tut_ch2_docs_classifier_lang_name string = 'tut-ch2-docs-classifier-lang'
param workspaces_DefaultWorkspace_2eb5b1d0_d315_4b57_815c_3df15002ac69_SUK_externalid string = '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/DefaultResourceGroup-SUK/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-2eb5b1d0-d315-4b57-815c-3df15002ac69-SUK'

resource accounts_tut_ch2_docs_classifier_lang_name_resource 'Microsoft.CognitiveServices/accounts@2024-04-01-preview' = {
  name: accounts_tut_ch2_docs_classifier_lang_name
  location: 'uksouth'
  tags: {
    tutorial: 'chapter2'
  }
  sku: {
    name: 'F0'
  }
  kind: 'TextAnalytics'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    apiProperties: {}
    customSubDomainName: accounts_tut_ch2_docs_classifier_lang_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource components_Chapter2DocumentClassifier_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_Chapter2DocumentClassifier_name
  location: 'uksouth'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'WebTools16.0'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_2eb5b1d0_d315_4b57_815c_3df15002ac69_SUK_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource storageAccounts_tutch2docsclassifierst_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_tutch2docsclassifierst_name
  location: 'uksouth'
  tags: {
    tutorial: 'chapter2'
  }
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource serverfarms_UKSouthPlan_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: serverfarms_UKSouthPlan_name
  location: 'UK South'
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
  kind: 'functionapp'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource components_Chapter2DocumentClassifier_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'degradationindependencyduration'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'degradationinserverresponsetime'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'digestMailConfiguration'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'extension_canaryextension'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'extension_memoryleakextension'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'extension_securityextensionspackage'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'extension_traceseveritydetector'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'longdependencyduration'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'slowpageloadtime'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_Chapter2DocumentClassifier_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_Chapter2DocumentClassifier_name_resource
  name: 'slowserverresponsetime'
  location: 'uksouth'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource storageAccounts_tutch2docsclassifierst_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_tutch2docsclassifierst_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_tutch2docsclassifierst_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_tutch2docsclassifierst_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_tutch2docsclassifierst_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_tutch2docsclassifierst_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_tutch2docsclassifierst_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_tutch2docsclassifierst_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_Chapter2DocumentClassifier20240912215556_name
  location: 'UK South'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/tut-ch2-docs-classifier-rg/providers/microsoft.insights/components/Chapter2DocumentClassifier'
    'hidden-link: /app-insights-instrumentation-key': 'e18b8120-7d34-4a42-9252-731089f2d6bc'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=e18b8120-7d34-4a42-9252-731089f2d6bc;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=cfa9dd5d-d5ed-43cf-a91d-f7ddec98e084'
  }
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: 'chapter2documentclassifier20240912215556.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: 'chapter2documentclassifier20240912215556.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_UKSouthPlan_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: '482E121B69BFFE705F3EA93CD00DE46CC02BDB3B9E95D8EFCF0E682AF0BAEDB0'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: 'ftp'
  location: 'UK South'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/tut-ch2-docs-classifier-rg/providers/microsoft.insights/components/Chapter2DocumentClassifier'
    'hidden-link: /app-insights-instrumentation-key': 'e18b8120-7d34-4a42-9252-731089f2d6bc'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=e18b8120-7d34-4a42-9252-731089f2d6bc;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=cfa9dd5d-d5ed-43cf-a91d-f7ddec98e084'
  }
  properties: {
    allow: true
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: 'scm'
  location: 'UK South'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/tut-ch2-docs-classifier-rg/providers/microsoft.insights/components/Chapter2DocumentClassifier'
    'hidden-link: /app-insights-instrumentation-key': 'e18b8120-7d34-4a42-9252-731089f2d6bc'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=e18b8120-7d34-4a42-9252-731089f2d6bc;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=cfa9dd5d-d5ed-43cf-a91d-f7ddec98e084'
  }
  properties: {
    allow: true
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: 'web'
  location: 'UK South'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/tut-ch2-docs-classifier-rg/providers/microsoft.insights/components/Chapter2DocumentClassifier'
    'hidden-link: /app-insights-instrumentation-key': 'e18b8120-7d34-4a42-9252-731089f2d6bc'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=e18b8120-7d34-4a42-9252-731089f2d6bc;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=cfa9dd5d-d5ed-43cf-a91d-f7ddec98e084'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v8.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$Chapter2DocumentClassifier20240912215556'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    localMySqlEnabled: false
    managedServiceIdentityId: 39410
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_513ea17023944452813600ea98f52bc4 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: '513ea17023944452813600ea98f52bc4'
  location: 'UK South'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-09-12T21:01:49.2175491Z'
    end_time: '2024-09-12T21:01:50.8737953Z'
    active: false
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_6521b43a795a4cbab9d72d450ed9a5de 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: '6521b43a795a4cbab9d72d450ed9a5de'
  location: 'UK South'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-09-13T13:40:29.2302081Z'
    end_time: '2024-09-13T13:40:30.37084Z'
    active: true
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_8a747cafb1b248e2a01682fdc14f8863 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: '8a747cafb1b248e2a01682fdc14f8863'
  location: 'UK South'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-09-12T22:29:27.8187729Z'
    end_time: '2024-09-12T22:29:29.4281646Z'
    active: false
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_aecba92a2de240f3972cf24402102572 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: 'aecba92a2de240f3972cf24402102572'
  location: 'UK South'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-09-12T21:09:10.8034992Z'
    end_time: '2024-09-12T21:09:12.3503925Z'
    active: false
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_DocumentClassifier 'Microsoft.Web/sites/functions@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: 'DocumentClassifier'
  location: 'UK South'
  properties: {
    script_href: 'https://chapter2documentclassifier20240912215556.azurewebsites.net/admin/vfs/site/wwwroot/Chapter2DocumentClassifier.dll'
    test_data_href: 'https://chapter2documentclassifier20240912215556.azurewebsites.net/admin/vfs/data/Functions/sampledata/DocumentClassifier.dat'
    href: 'https://chapter2documentclassifier20240912215556.azurewebsites.net/admin/functions/DocumentClassifier'
    config: {
      name: 'DocumentClassifier'
      entryPoint: 'Chapter2DocumentClassifier.DocumentClassifier.Run'
      scriptFile: 'Chapter2DocumentClassifier.dll'
      language: 'dotnet-isolated'
      functionDirectory: ''
      bindings: [
        {
          name: 'stream'
          type: 'blobTrigger'
          direction: 'In'
          properties: {
            supportsDeferredBinding: 'True'
          }
          path: '%sourceContainerName%/{name}'
          source: 'LogsAndContainerScan'
          connection: 'blobConn'
        }
      ]
    }
    language: 'dotnet-isolated'
    isDisabled: false
  }
}

resource sites_Chapter2DocumentClassifier20240912215556_name_sites_Chapter2DocumentClassifier20240912215556_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_Chapter2DocumentClassifier20240912215556_name_resource
  name: '${sites_Chapter2DocumentClassifier20240912215556_name}.azurewebsites.net'
  location: 'UK South'
  properties: {
    siteName: 'Chapter2DocumentClassifier20240912215556'
    hostNameType: 'Verified'
  }
}

resource storageAccounts_tutch2docsclassifierst_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_tutch2docsclassifierst_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_tutch2docsclassifierst_name_resource
  ]
}

resource storageAccounts_tutch2docsclassifierst_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_tutch2docsclassifierst_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_tutch2docsclassifierst_name_resource
  ]
}

resource storageAccounts_tutch2docsclassifierst_name_default_destination 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_tutch2docsclassifierst_name_default
  name: 'destination'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_tutch2docsclassifierst_name_resource
  ]
}

resource storageAccounts_tutch2docsclassifierst_name_default_source 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_tutch2docsclassifierst_name_default
  name: 'source'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_tutch2docsclassifierst_name_resource
  ]
}

resource storageAccounts_tutch2docsclassifierst_name_default_chapter2documentclassifier20240912215556 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_tutch2docsclassifierst_name_default
  name: 'chapter2documentclassifier20240912215556'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_tutch2docsclassifierst_name_resource
  ]
}

resource storageAccounts_tutch2docsclassifierst_name_default_azure_webjobs_blobtrigger_chapter2documentclassifier202409 'Microsoft.Storage/storageAccounts/queueServices/queues@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_queueServices_storageAccounts_tutch2docsclassifierst_name_default
  name: 'azure-webjobs-blobtrigger-chapter2documentclassifier202409'
  properties: {
    metadata: {}
  }
  dependsOn: [
    storageAccounts_tutch2docsclassifierst_name_resource
  ]
}
