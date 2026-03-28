// Azure Cache for Redis

param location string
param tags object
param resourceToken string

resource redis 'Microsoft.Cache/redis@2023-08-01' = {
  name: 'redis-${resourceToken}'
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'Basic'
      family: 'C'
      capacity: 0
    }
    enableNonSslPort: false
    minimumTlsVersion: '1.2'
    redisConfiguration: {
      'maxmemory-policy': 'volatile-lru'
    }
  }
}

output connectionString string = '${redis.properties.hostName}:${redis.properties.sslPort},password=${redis.listKeys().primaryKey},ssl=True,abortConnect=False'
output hostName string = redis.properties.hostName
output sslPort int = redis.properties.sslPort
