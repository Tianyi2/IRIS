// PostgreSQL Flexible Server

param location string
param tags object
param resourceToken string
param administratorLogin string

@secure()
param administratorLoginPassword string

resource postgres 'Microsoft.DBforPostgreSQL/flexibleServers@2023-03-01-preview' = {
  name: 'psql-${resourceToken}'
  location: location
  tags: tags
  sku: {
    name: 'Standard_B1ms'
    tier: 'Burstable'
  }
  properties: {
    version: '16'
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    storage: {
      storageSizeGB: 32
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    highAvailability: {
      mode: 'Disabled'
    }
  }

  resource database 'databases' = {
    name: 'mdpmdb'
    properties: {
      charset: 'UTF8'
      collation: 'en_US.utf8'
    }
  }

  // Allow Azure services to connect
  resource firewallRule 'firewallRules' = {
    name: 'AllowAzureServices'
    properties: {
      startIpAddress: '0.0.0.0'
      endIpAddress: '0.0.0.0'
    }
  }
}

output connectionString string = 'Host=${postgres.properties.fullyQualifiedDomainName};Database=mdpmdb;Username=${administratorLogin};Password=${administratorLoginPassword}'
output serverName string = postgres.name
output serverFqdn string = postgres.properties.fullyQualifiedDomainName
