
param sqlServerName string
param adminLogin string
param location string
param environment string


@secure()
param adminPassword string

resource sqlServer 'Microsoft.Sql/servers@2021-11-01' = {
  name: '${sqlServerName}-sql-${environment}'
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    version: '12.0'
  }
}
