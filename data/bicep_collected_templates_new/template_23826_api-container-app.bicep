// Container App for MDPM API

param location string
param tags object
param containerAppsEnvironmentId string
param containerRegistryName string

@secure()
param postgresConnectionString string

@secure()
param storageConnectionString string

@secure()
param redisConnectionString string

// Reference to existing container registry
resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' existing = {
  name: containerRegistryName
}

resource api 'Microsoft.App/containerApps@2023-05-01' = {
  name: 'ca-mdpm-api'
  location: location
  tags: union(tags, { 'azd-service-name': 'api' })
  properties: {
    managedEnvironmentId: containerAppsEnvironmentId
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
        external: true
        targetPort: 8080
        transport: 'http'
        allowInsecure: false
      }
      registries: [
        {
          server: containerRegistry.properties.loginServer
          username: containerRegistry.listCredentials().username
          passwordSecretRef: 'registry-password'
        }
      ]
      secrets: [
        {
          name: 'registry-password'
          value: containerRegistry.listCredentials().passwords[0].value
        }
        {
          name: 'postgres-connection'
          value: postgresConnectionString
        }
        {
          name: 'storage-connection'
          value: storageConnectionString
        }
        {
          name: 'redis-connection'
          value: redisConnectionString
        }
      ]
    }
    template: {
      containers: [
        {
          name: 'api'
          image: '${containerRegistry.properties.loginServer}/mdpm-api:latest'
          resources: {
            cpu: json('0.5')
            memory: '1Gi'
          }
          env: [
            {
              name: 'ASPNETCORE_ENVIRONMENT'
              value: 'Production'
            }
            {
              name: 'ConnectionStrings__mdpmdb'
              secretRef: 'postgres-connection'
            }
            {
              name: 'ConnectionStrings__packages'
              secretRef: 'storage-connection'
            }
            {
              name: 'ConnectionStrings__package-scan-queue'
              secretRef: 'storage-connection'
            }
            {
              name: 'ConnectionStrings__cache'
              secretRef: 'redis-connection'
            }
          ]
          probes: [
            {
              type: 'Liveness'
              httpGet: {
                path: '/health/live'
                port: 8080
              }
              initialDelaySeconds: 5
              periodSeconds: 30
            }
            {
              type: 'Readiness'
              httpGet: {
                path: '/health/ready'
                port: 8080
              }
              initialDelaySeconds: 10
              periodSeconds: 10
            }
          ]
        }
      ]
      scale: {
        minReplicas: 1
        maxReplicas: 3
        rules: [
          {
            name: 'http-scaling'
            http: {
              metadata: {
                concurrentRequests: '100'
              }
            }
          }
        ]
      }
    }
  }
}

output endpoint string = 'https://${api.properties.configuration.ingress.fqdn}'
output name string = api.name
