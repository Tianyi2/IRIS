resource appInsight 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appInsight'
  location: resourceGroup().location
  kind: 'web'
}

