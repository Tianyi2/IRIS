param location string
param projectName string
param dockerRegistryUrl string = 'https://mcr.microsoft.com'
param mySqlVersion string = '5.7'
param mySqlServerName string
param mySqlServerUsername string
param mySqlServerPassword string
param mySqlServerStorageSizeMB int = 32768
param mySqlServerBackupRetentionDays int = 7
param mySqlServerGeoRedundantBackup string = 'Disabled'
param mySqlServerStorageAutogrow string = 'Enabled'
param mySqlServerSslEnforcement string = 'Enabled'
param mySqlServerSku object = {
  name: 'B_Gen5_1'
  tier: 'Basic'
  capacity: 1
  size: '32768'
  family: 'Gen5'
}
param wordpressDatabaseName string
param wordpressAdminEmail string
param wordpressUsername string
param wordpressPassword string
param wordpressTitle string
param wordpressLocale string = 'en_US'

resource mySqlServer 'Microsoft.DBforMySQL/servers@2017-12-01-preview' = {
  location: location
  name: mySqlServerName
  tags: {
    AppProfile: 'Wordpress'
  }
  properties: {
    version: mySqlVersion
    administratorLogin: mySqlServerUsername
    administratorLoginPassword: mySqlServerPassword
    storageProfile: {
      storageMB: mySqlServerStorageSizeMB
      backupRetentionDays: mySqlServerBackupRetentionDays
      geoRedundantBackup: mySqlServerGeoRedundantBackup
      storageAutogrow: mySqlServerStorageAutogrow
    }
    sslEnforcement: mySqlServerSslEnforcement
    createMode: 'Default'
  }
  sku: mySqlServerSku
}

resource mySqlDatabase 'Microsoft.DBforMySQL/servers/databases@2017-12-01-preview' = {
  name: '${mySqlServerName}/${wordpressDatabaseName}'
  properties: {
    charset: 'utf8'
    collation: 'utf8_general_ci'
  }
  dependsOn: [
    mySqlServer
  ]
}

resource mySQLServer_AllowAll 'Microsoft.DBforMySQL/servers/firewallRules@2017-12-01-preview' = {
  name: '${mySqlServerName}/AllowAll'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '255.255.255.255'
  }
  dependsOn: [
    mySqlServer
  ]
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: '${projectName}-plan'
  location: location
  kind: 'linux'
  tags: {}
  properties: {
    name: '${projectName}-plan'
    workerSize: 3
    workerSizeId: 3
    numberOfWorkers: 1
    reserved: true
  }
  sku: {
    Tier: 'PremiumV2'
    Name: 'P1v2'
  }
}

resource appService 'Microsoft.Web/sites@2021-03-01' = {
  name: projectName
  location: location
  tags: {}
  properties: {
    name: projectName
    siteConfig: {
      appSettings: [
        {
          name: 'DOCKER_REGISTRY_SERVER_URL'
          value: dockerRegistryUrl
        }
        {
          name: 'WEBSITES_ENABLE_APP_SERVICE_STORAGE'
          value: 'true'
        }
        {
          name: 'DATABASE_HOST'
          value: '${mySqlServerName}.mysql.database.azure.com'
        }
        {
          name: 'DATABASE_NAME'
          value: wordpressDatabaseName
        }
        {
          name: 'DATABASE_USERNAME'
          value: mySqlServerUsername
        }
        {
          name: 'DATABASE_PASSWORD'
          value: mySqlServerPassword
        }
        {
          name: 'WORDPRESS_ADMIN_EMAIL'
          value: wordpressAdminEmail
        }
        {
          name: 'WORDPRESS_ADMIN_USER'
          value: wordpressUsername
        }
        {
          name: 'WORDPRESS_ADMIN_PASSWORD'
          value: wordpressPassword
        }
        {
          name: 'WORDPRESS_TITLE'
          value: wordpressTitle
        }
        {
          name: 'WEBSITES_CONTAINER_START_TIME_LIMIT'
          value: '900'
        }
        {
          name: 'WORDPRESS_LOCALE_CODE'
          value: wordpressLocale
        }
        {
          name: 'CDN_ENABLED'
          value: 'true'
        }
        {
          name: 'CDN_ENDPOINT'
          value: '${projectName}.azureedge.net'
        }
      ]
      connectionStrings: []
      linuxFxVersion: 'DOCKER|mcr.microsoft.com/appsvc/wordpress-alpine-php:latest'
      alwaysOn: true
    }
    serverFarmId: appServicePlan.id
    clientAffinityEnabled: false
  }
}

resource cdnProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: '${projectName}-profile'
  location: 'Global'
  sku: {
    name: 'Standard_Microsoft'
  }
  tags: {
    AppProfile: 'Wordpress'
  }
  properties: {}
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  name: '${projectName}-profile/${projectName}-endpoint'
  location: 'Global'
  properties: {
    isHttpAllowed: true
    isHttpsAllowed: true
    originHostHeader: '${projectName}.azurewebsites.net'
    origins: [
      {
        name: '${projectName}-azurewebsites-net'
        properties: {
            hostName: '${projectName}.azurewebsites.net'
            httpPort: 80
            httpsPort: 443
            originHostHeader: '${projectName}.azurewebsites.net'
            priority: 1
            weight: 1000
            enabled: true
        }
      }
    ]
    isCompressionEnabled: true
    contentTypesToCompress: [
      'application/eot'
      'application/font'
      'application/font-sfnt'
      'application/javascript'
      'application/json'
      'application/opentype'
      'application/otf'
      'application/pkcs7-mime'
      'application/truetype'
      'application/ttf'
      'application/vnd.ms-fontobject'
      'application/xhtml+xml'
      'application/xml'
      'application/xml+rss'
      'application/x-font-opentype'
      'application/x-font-truetype'
      'application/x-font-ttf'
      'application/x-httpd-cgi'
      'application/x-javascript'
      'application/x-mpegurl'
      'application/x-opentype'
      'application/x-otf'
      'application/x-perl'
      'application/x-ttf'
      'font/eot'
      'font/ttf'
      'font/otf'
      'font/opentype'
      'image/svg+xml'
      'text/css'
      'text/csv'
      'text/html'
      'text/javascript'
      'text/js'
      'text/plain'
      'text/richtext'
      'text/tab-separated-values'
      'text/xml'
      'text/x-script'
      'text/x-component'
      'text/x-java-source'
    ]
  }
  dependsOn: [
    cdnProfile
  ]
}
