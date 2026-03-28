param name string
param location string
@secure()
param adminUsername string
@secure()
param adminPassword string
param databaseSku string = 'Basic'
param databaseTier string = 'Basic'
param databaseCapacity int = 5

resource sqlserver 'Microsoft.Sql/servers@2022-11-01-preview' = {
  name: 'sql-${name}'
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
  }
}

resource sqlfirewall 'Microsoft.Sql/servers/firewallRules@2021-05-01-preview' = {
  name: 'AllowAllWindowsAzureIps'
  parent: sqlserver
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource database 'Microsoft.Sql/servers/databases@2021-05-01-preview' = {
  name: 'db-${name}'
  parent: sqlserver
  location: location
  sku: {
    name: databaseSku
    tier: databaseTier
    capacity: databaseCapacity
  }
}
