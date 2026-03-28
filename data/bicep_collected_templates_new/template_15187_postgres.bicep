// Parameters
param location string
param nameAffix string
param administratorLogin string
@secure()
param administratorLoginPassword string
param subnetId string = ''
param privateDnsZoneArmResourceId string = ''

// Variables
var serverName = 'psql-${nameAffix}-${uniqueString(resourceGroup().id)}'

// Postgres
resource serverName_resource 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
  name: serverName
  location: location
  sku: {
    name: 'Standard_B2s'
    tier: 'Burstable'
  }
  properties: {
    version: '15'
    administratorLogin: administratorLogin
    administratorLoginPassword: administratorLoginPassword
    network: {
      delegatedSubnetResourceId: (empty(subnetId) ? null : subnetId)
      privateDnsZoneArmResourceId: (empty(privateDnsZoneArmResourceId) ? null : privateDnsZoneArmResourceId)
    }
    highAvailability: {
      mode: 'Disabled'
    }
    storage: {
      storageSizeGB: 128
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
  }
}
