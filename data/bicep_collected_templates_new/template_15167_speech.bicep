param speechName string
param location string
param tags object

resource translator 'Microsoft.CognitiveServices/accounts@2024-06-01-preview' = {
  name: speechName
  location: location
  tags: tags
  sku: {
    name: 'F0'
  }
  kind: 'SpeechServices'
  identity: {
    type: 'None'
  }
  properties: {
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}

