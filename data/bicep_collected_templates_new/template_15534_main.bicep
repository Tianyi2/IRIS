@description('The name of the Azure Static Web App')
param staticWebAppName string = 'boltmarket-app'

@description('The location where the Azure Static Web App will be deployed')
param location string = 'eastus2'

@description('The GitHub repository URL for deployment')
param repositoryUrl string = 'https://github.com/nenad0707/Bolt-Market'

@description('The branch in the GitHub repository to deploy from')
param branch string = 'main'

@description('The build configuration for the Azure Static Web App')
param appBuildConfig object = {
  appLocation: ''
  apiLocation: ''
  outputLocation:'dist'
}

resource staticWebApp 'Microsoft.Web/staticSites@2022-09-01' = {
  name: staticWebAppName
  location: location
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {
    repositoryUrl: repositoryUrl
    branch: branch
    buildProperties: appBuildConfig
  }
}

output staticWebAppUrl string = staticWebApp.properties.defaultHostname
