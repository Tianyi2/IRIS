param region string
param environmentName string
param applicationName string 
param containerName string
param containerImage string
param targetPort int
param cpu string
param mem string

resource acaenv 'Microsoft.App/managedEnvironments@2022-06-01-preview' existing = {
  name: environmentName
}


resource defaultapp 'Microsoft.App/containerApps@2022-06-01-preview' = {
  name: applicationName
  location: region
  properties: {
    environmentId: acaenv.id
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
         external: true
         targetPort: targetPort
      }
    
    }
    template: {
       containers: [
         {
            name: containerName
            image: containerImage
            resources: {
              cpu: json(cpu)
              memory: mem
            }
            
         }
       ]
    }
  }
}
