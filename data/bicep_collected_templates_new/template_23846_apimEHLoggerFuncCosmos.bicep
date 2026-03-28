param location string
param existingApimName string
param eventHubNamespaceName string
param eventHubName string
param apimLoggerName string

resource apim 'Microsoft.ApiManagement/service@2021-08-01' existing = {
  name: existingApimName
  resource eventHubLogger 'loggers@2023-03-01-preview' = {
    name: apimLoggerName
    properties: {
      loggerType: 'azureEventHub'
      credentials: {
        connectionString: eventHubNamespace::eventHub::senderAuth.listKeys().primaryConnectionString
        name: eventHubNamespace::eventHub.name
      }
    }
  }
}

resource eventHubNamespace 'Microsoft.EventHub/namespaces@2023-01-01-preview' = {
  name: eventHubNamespaceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    isAutoInflateEnabled: false
  }
  resource eventHub 'eventhubs@2023-01-01-preview' = {
    name: eventHubName
    properties: {
      messageRetentionInDays: 7
      partitionCount: 1
    }
    resource senderAuth 'authorizationRules@2023-01-01-preview' = {
      name: 'apimLogger'
      properties: {
        rights: [
          'Send'
        ]
      }
    }
  }
}


// TODO: Func + Cosmos
