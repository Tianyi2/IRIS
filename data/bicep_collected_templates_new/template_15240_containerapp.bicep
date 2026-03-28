@description('Name of the container app')
param containerAppName string = 'financialapp'

@description('Location of the container app')
param location string = resourceGroup().location

@description('ACR login server (e.g., aifinancialregistry.azurecr.io)')
param acrLoginServer string

@description('ACR username')
param acrUsername string

@secure()
@description('ACR password')
param acrPassword string

@description('Container image tag')
param imageTag string = 'latest'

@description('CPU cores for the container')
param cpuCores int = 1

@description('Memory allocation for the container (GiB)')
param memory string = '2Gi'

@secure()
@description('Azure OpenAI key')
param openAiKey string

// Container Apps need a managed environment
resource containerEnv 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: '${containerAppName}-env'
  location: location
  properties: {}
}

// Container App definition
resource containerApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: containerAppName
  location: location
  properties: {
    managedEnvironmentId: containerEnv.id
    configuration: {
      ingress: {
        external: true
        targetPort: 8000 // your Waitress is listening here
      }
      registries: [
        {
          server: acrLoginServer
          username: acrUsername
          passwordSecretRef: 'acr-pwd'
        }
      ]
      secrets: [
        {
          name: 'acr-pwd'
          value: acrPassword
        }
        {
          name: 'openai-key'
          value: openAiKey
        }
      ]
    }
    template: {
      containers: [
        {
          name: containerAppName
          image: '${acrLoginServer}/financial-tracker:${imageTag}'
          resources: {
            cpu: cpuCores
            memory: memory
          }
          env: [
            {
              name: 'AZURE_OPENAI_KEY'
              secretRef: 'openai-key'
            }
          ]
        }
      ]
    }
  }
}
