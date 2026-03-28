param applicationName string
param environment string
param location string

resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-${applicationName}-euw-${environment}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}

output connectionString string = appInsights.properties.ConnectionString