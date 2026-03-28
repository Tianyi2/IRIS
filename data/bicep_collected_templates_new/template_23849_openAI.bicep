param location string
param openaiName string
param openaiSubDomain string = openaiName
param modelName string
param modelCapacity int = 20

resource openai 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: openaiName
  location: location
  kind: 'OpenAI'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: openaiSubDomain
  }
  
  resource modelDeployment 'deployments@2023-05-01' = {
    name: modelName
    sku: {
      name: 'Standard'
      capacity: modelCapacity
    }
    properties: {
      model: {
        format: 'OpenAI'
        name: modelName
      }
      versionUpgradeOption: 'OnceNewDefaultVersionAvailable'
    }
  }
}

output openaiEndpoint string = openai.properties.endpoint
