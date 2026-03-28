@description('Name of the container app')
param appName string

@description('Location for the app')
param location string

@description('Tags to apply to the app')
param tags object = {}

@description('Container Apps Environment ID')
param containerAppsEnvironmentId string

@description('Container image URI')
param containerImage string

@description('Container port')
param containerPort int = 80

@description('CPU cores for the container')
param containerCpuCores int = 1

@description('Memory for the container in GB')
param containerMemory string = '0.5'

@description('Number of replicas')
param replicas int = 1

@description('Enable internal ingress (private endpoints)')
param internalIngress bool = true

// Create the Container App with internal ingress
resource containerApp 'Microsoft.App/containerApps@2023-11-02-preview' = {
  name: appName
  location: location
  tags: union(tags, { 'azd-service-name': 'aca' })
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    environmentId: containerAppsEnvironmentId
    configuration: {
      ingress: internalIngress ? {
        external: false
        targetPort: containerPort
        transport: 'auto'
      } : {
        external: true
        targetPort: containerPort
        transport: 'auto'
      }
      registries: []
      secrets: []
    }
    template: {
      containers: [
        {
          image: containerImage
          name: appName
          resources: {
            cpu: containerCpuCores
            memory: containerMemory
          }
        }
      ]
      scale: {
        minReplicas: replicas
        maxReplicas: replicas
      }
    }
  }
}

output appId string = containerApp.id
output appName string = containerApp.name
output appFqdn string = containerApp.properties.configuration.ingress.fqdn
output appInternalFqdn string = internalIngress ? containerApp.properties.configuration.ingress.fqdn : ''
