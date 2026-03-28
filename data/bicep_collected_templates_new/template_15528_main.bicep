param location string = resourceGroup().location

var config = loadJsonContent('config.json')

resource server 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: 'sqlpowerappsbenchmark'
  location: location

  properties: {
    administratorLogin: config.login
    administratorLoginPassword: config.password
  }
}

resource database 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: 'sqldbbenchmark'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  parent: server
  properties: {
    maxSizeBytes: 2147483648
    requestedBackupStorageRedundancy: 'Local'
    zoneRedundant: false
  }
}

resource firewall 'Microsoft.Sql/servers/firewallRules@2022-05-01-preview' = {
  name: 'AllowRange'
  parent: server
  properties: {
    endIpAddress: config.firewall.endIpAddress
    startIpAddress: config.firewall.startIpAddress
  }
}
