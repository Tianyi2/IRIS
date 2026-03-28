param name string
param location string
param tags object

resource translator 'Microsoft.CognitiveServices/accounts@2024-06-01-preview' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: 'F0'
  }
  kind: 'TextTranslation'
  properties: {
    customSubDomainName: name
    publicNetworkAccess: 'Enabled'
  }
}

output name string = translator.name
