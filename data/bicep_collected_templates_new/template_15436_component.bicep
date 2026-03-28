

param appInsights string
param location string = resourceGroup().location
param costCenter string
param environment string

var resourceTags = {
  CostCenter: costCenter
  Environment: environment
  Kind: 'Managed-Service'
}


resource appIns 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: appInsights
  location: location
  kind: appInsights
  tags: resourceTags

  properties: {
    Application_Type: 'web'
  }
}

output InstrumentationKey string = appIns.properties.InstrumentationKey