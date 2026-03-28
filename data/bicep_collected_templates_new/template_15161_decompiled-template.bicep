param sites_tut_ch3_translator_func_name string = 'tut-ch3-translator-func'
param storageAccounts_tutch3translatorst_name string = 'tutch3translatorst'
param components_tut_ch3_translator_func_name string = 'tut-ch3-translator-func'
param serverfarms_ASP_tutch3translatorrg_a857_name string = 'ASP-tutch3translatorrg-a857'
param accounts_tut_ch3_translator_trsl_name string = 'tut-ch3-translator-trsl'
param workspaces_DefaultWorkspace_2eb5b1d0_d315_4b57_815c_3df15002ac69_SUK_externalid string = '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/DefaultResourceGroup-SUK/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-2eb5b1d0-d315-4b57-815c-3df15002ac69-SUK'

resource accounts_tut_ch3_translator_trsl_name_resource 'Microsoft.CognitiveServices/accounts@2024-06-01-preview' = {
  name: accounts_tut_ch3_translator_trsl_name
  location: 'uksouth'
  tags: {
    tutorial: 'chapter3'
  }
  sku: {
    name: 'F0'
  }
  kind: 'TextTranslation'
  identity: {
    type: 'None'
  }
  properties: {
    customSubDomainName: accounts_tut_ch3_translator_trsl_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource components_tut_ch3_translator_func_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_tut_ch3_translator_func_name
  location: 'uksouth'
  tags: {
    tutorial: 'chapter3'
  }
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_2eb5b1d0_d315_4b57_815c_3df15002ac69_SUK_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource storageAccounts_tutch3translatorst_name_resource 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccounts_tutch3translatorst_name
  location: 'uksouth'
  tags: {
    tutorial: 'chapter3'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'Storage'
  properties: {
    defaultToOAuthAuthentication: true
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
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
  }
}

resource serverfarms_ASP_tutch3translatorrg_a857_name_resource 'Microsoft.Web/serverfarms@2023-12-01' = {
  name: serverfarms_ASP_tutch3translatorrg_a857_name
  location: 'UK South'
  tags: {
    tutorial: 'chapter3'
  }
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

resource components_tut_ch3_translator_func_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource components_tut_ch3_translator_func_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_tut_ch3_translator_func_name_resource
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

resource storageAccounts_tutch3translatorst_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  parent: storageAccounts_tutch3translatorst_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_tutch3translatorst_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccounts_tutch3translatorst_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
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

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_tutch3translatorst_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' = {
  parent: storageAccounts_tutch3translatorst_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_tutch3translatorst_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-05-01' = {
  parent: storageAccounts_tutch3translatorst_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_tut_ch3_translator_func_name_resource 'Microsoft.Web/sites@2023-12-01' = {
  name: sites_tut_ch3_translator_func_name
  location: 'UK South'
  tags: {
    tutorial: 'chapter3'
    'hidden-link: /app-insights-resource-id': '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/tut-ch3-translator-rg/providers/microsoft.insights/components/tut-ch3-translator-func'
    'hidden-link: /app-insights-instrumentation-key': '6c0f7711-8246-4083-864a-5c41fd63a302'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=6c0f7711-8246-4083-864a-5c41fd63a302;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=fbed34b1-7bc5-4ef2-ae8e-87f8a97f308e'
  }
  kind: 'functionapp'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_tut_ch3_translator_func_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_tut_ch3_translator_func_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_tutch3translatorrg_a857_name_resource.id
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
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_tut_ch3_translator_func_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_tut_ch3_translator_func_name_resource
  name: 'ftp'
  location: 'UK South'
  tags: {
    tutorial: 'chapter3'
    'hidden-link: /app-insights-resource-id': '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/tut-ch3-translator-rg/providers/microsoft.insights/components/tut-ch3-translator-func'
    'hidden-link: /app-insights-instrumentation-key': '6c0f7711-8246-4083-864a-5c41fd63a302'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=6c0f7711-8246-4083-864a-5c41fd63a302;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=fbed34b1-7bc5-4ef2-ae8e-87f8a97f308e'
  }
  properties: {
    allow: false
  }
}

resource sites_tut_ch3_translator_func_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2023-12-01' = {
  parent: sites_tut_ch3_translator_func_name_resource
  name: 'scm'
  location: 'UK South'
  tags: {
    tutorial: 'chapter3'
    'hidden-link: /app-insights-resource-id': '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/tut-ch3-translator-rg/providers/microsoft.insights/components/tut-ch3-translator-func'
    'hidden-link: /app-insights-instrumentation-key': '6c0f7711-8246-4083-864a-5c41fd63a302'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=6c0f7711-8246-4083-864a-5c41fd63a302;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=fbed34b1-7bc5-4ef2-ae8e-87f8a97f308e'
  }
  properties: {
    allow: false
  }
}

resource sites_tut_ch3_translator_func_name_web 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: sites_tut_ch3_translator_func_name_resource
  name: 'web'
  location: 'UK South'
  tags: {
    tutorial: 'chapter3'
    'hidden-link: /app-insights-resource-id': '/subscriptions/2eb5b1d0-d315-4b57-815c-3df15002ac69/resourceGroups/tut-ch3-translator-rg/providers/microsoft.insights/components/tut-ch3-translator-func'
    'hidden-link: /app-insights-instrumentation-key': '6c0f7711-8246-4083-864a-5c41fd63a302'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=6c0f7711-8246-4083-864a-5c41fd63a302;IngestionEndpoint=https://uksouth-1.in.applicationinsights.azure.com/;LiveEndpoint=https://uksouth.livediagnostics.monitor.azure.com/;ApplicationId=fbed34b1-7bc5-4ef2-ae8e-87f8a97f308e'
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
    publishingUsername: 'REDACTED'
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
    publicNetworkAccess: 'Enabled'
    cors: {
      allowedOrigins: [
        'https://portal.azure.com'
      ]
      supportCredentials: false
    }
    localMySqlEnabled: false
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

resource sites_tut_ch3_translator_func_name_496e69f8ac824996911fbdfa7b3ccc34 'Microsoft.Web/sites/deployments@2023-12-01' = {
  parent: sites_tut_ch3_translator_func_name_resource
  name: '496e69f8ac824996911fbdfa7b3ccc34'
  location: 'UK South'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'ZipDeploy'
    message: 'Created via a push deployment'
    start_time: '2024-10-18T00:13:22.9674522Z'
    end_time: '2024-10-18T00:13:24.1393205Z'
    active: true
  }
}

resource sites_tut_ch3_translator_func_name_Translator 'Microsoft.Web/sites/functions@2023-12-01' = {
  parent: sites_tut_ch3_translator_func_name_resource
  name: 'Translator'
  location: 'UK South'
  properties: {
    script_href: 'https://tut-ch3-translator-func.azurewebsites.net/admin/vfs/site/wwwroot/Chapter3LanguageTranslator.dll'
    test_data_href: 'https://tut-ch3-translator-func.azurewebsites.net/admin/vfs/data/Functions/sampledata/Translator.dat'
    href: 'https://tut-ch3-translator-func.azurewebsites.net/admin/functions/Translator'
    config: {
      name: 'Translator'
      entryPoint: 'Chapter3LanguageTranslator.Translator.RunAsync'
      scriptFile: 'Chapter3LanguageTranslator.dll'
      language: 'dotnet-isolated'
      functionDirectory: ''
      bindings: [
        {
          name: 'req'
          type: 'httpTrigger'
          direction: 'In'
          authLevel: 'Function'
          methods: [
            'get'
            'post'
          ]
        }
        {
          name: '$return'
          type: 'http'
          direction: 'Out'
        }
      ]
    }
    invoke_url_template: 'https://tut-ch3-translator-func.azurewebsites.net/api/translator'
    language: 'dotnet-isolated'
    isDisabled: false
  }
}

resource sites_tut_ch3_translator_func_name_sites_tut_ch3_translator_func_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2023-12-01' = {
  parent: sites_tut_ch3_translator_func_name_resource
  name: '${sites_tut_ch3_translator_func_name}.azurewebsites.net'
  location: 'UK South'
  properties: {
    siteName: 'tut-ch3-translator-func'
    hostNameType: 'Verified'
  }
}

resource storageAccounts_tutch3translatorst_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_tutch3translatorst_name_default
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
    storageAccounts_tutch3translatorst_name_resource
  ]
}

resource storageAccounts_tutch3translatorst_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: storageAccounts_tutch3translatorst_name_default
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
    storageAccounts_tutch3translatorst_name_resource
  ]
}

resource storageAccounts_tutch3translatorst_name_default_tut_ch3_translator_funcbc26 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-05-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_tutch3translatorst_name_default
  name: 'tut-ch3-translator-funcbc26'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 102400
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_tutch3translatorst_name_resource
  ]
}
