param name string
param location string
param tags object

resource textAnalytics 'Microsoft.CognitiveServices/accounts@2024-04-01-preview' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: 'F0'
  }
  kind: 'TextAnalytics'
  properties: {
    customSubDomainName: name
    publicNetworkAccess: 'Enabled'
  }
}

output name string = textAnalytics.name
output endpoint string = textAnalytics.properties.endpoint
