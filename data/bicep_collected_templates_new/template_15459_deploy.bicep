// Double forward slash for comments

// Parameters are input into your ARM Template. ARM stands for Azure Resource Manager.
param stackPrefix string
param stackEnvironment string
param stackLocation string = 'centralus'
param clientId string
param domain string

// Variables can be delcared to be leveraged throughout your ARM Template.
var stackName = '${stackPrefix}${stackEnvironment}'

// Variables can be objects
var tags = {
  'stack-name': 'contoso-web-app'
  'stack-environment': stackEnvironment
}

// Symobolic name = appPlan which can be referenced later. Notice also we include the version of the API because
// everything in the backend is an API for ARM
resource appPlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: '${stackName}plan'
  location: stackLocation
  tags: tags
  sku: {
    name: 'F1'
    tier: 'Free'
  }
}

resource app 'Microsoft.Web/sites@2021-03-01' = {
  name: stackName
  location: stackLocation
  kind: 'app'
  tags: tags
  properties: {
    httpsOnly: true
    serverFarmId: appPlan.id // Notice the reference here back to appPlan created earlier.
    siteConfig: {
      netFrameworkVersion: 'v6.0' // Not sure why we need to include the metadata in order for the App Service to configure .NET stack setting correctly but hey, that's what makes it work.
      #disable-next-line BCP037
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnet'
        }
      ]
      appSettings: [
        // Configuration as code.
        {
          name: 'AzureAd:Instance'
          value: environment().authentication.loginEndpoint // Use functions provided in bicep to reference static values.
        }
        {
          name: 'AzureAd:Domain'
          value: '${domain}.onmicrosoft.com'
        }
        {
          name: 'AzureAd:TenantId'
          value: subscription().tenantId // Yet another function so we don't have to figure this out and pass it in.
        }
        {
          name: 'AzureAd:ClientId'
          value: clientId
        }
        {
          name: 'AzureAd:CallbackPath'
          value: '/signin-oidc'
        }
      ]
    }
  }
}

// This is an output of a App Service so we can re-use it if needed later in our script or CI/CD.
output appServiceName string = app.name
