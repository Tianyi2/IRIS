@allowed(['dev', 'prod'])
param environment string

param backupRetention int = 7               // ← S1: Unused Parameter

var isProduction = environment == 'prod'

resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = if (isProduction) {
  name: 'myDbServer'
  location: resourceGroup().location
  properties: {
    administratorLogin: 'admin'
    administratorLoginPassword: 'Admin123!'  // ← S3: Hard-coded Secret
  }
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2021-11-01' = if (isProduction) {
  parent: sqlServer
  name: 'AllowAll'
  properties: {
    startIpAddress: '0.0.0.0'               // ← S2: Unrestricted IP
    endIpAddress: '255.255.255.255'
  }
}

resource dbAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'dbCpuAlert'                        // ← S4: No condition here!
  location: 'global'                        //    Cascading Provision Failure
  properties: {
    severity: 2
    enabled: true
    scopes: [sqlServer.id]                  //    depends on conditional sqlServer
    evaluationFrequency: 'PT5M'
    windowSize: 'PT5M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'cpuPercent'
          metricName: 'cpu_percent'
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
        }
      ]
    }
  }
}
