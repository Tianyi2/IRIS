@description('Azure AD App Registration for ByteBark authentication')

// Parameters
param appName string
param webAppUrl string

// Note: This template creates the AD app registration structure
// The actual registration needs to be done via Azure CLI/PowerShell 
// as Bicep doesn't fully support Azure AD app registrations yet

// Variables
var redirectUris = [
  '${webAppUrl}/auth/callback'
  '${webAppUrl}/auth/redirect'
]

var logoutUrl = '${webAppUrl}/auth/logout'

// Output the configuration that will be used by the deployment script
// to create the Azure AD app registration
output appRegistrationConfig object = {
  displayName: appName
  signInAudience: 'AzureADMyOrg'
  web: {
    redirectUris: redirectUris
    logoutUrl: logoutUrl
    implicitGrantSettings: {
      enableAccessTokenIssuance: false
      enableIdTokenIssuance: true
    }
  }
  requiredResourceAccess: [
    {
      resourceAppId: '00000003-0000-0000-c000-000000000000' // Microsoft Graph
      resourceAccess: [
        {
          id: 'e1fe6dd8-ba31-4d61-89e7-88639da4683d' // User.Read
          type: 'Scope'
        }
        {
          id: '64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0' // User.Read.All
          type: 'Scope'
        }
      ]
    }
  ]
  optionalClaims: {
    idToken: [
      {
        name: 'email'
        essential: true
      }
      {
        name: 'given_name'
        essential: false
      }
      {
        name: 'family_name'
        essential: false
      }
    ]
  }
}

// Placeholder output - will be populated by deployment script
output clientId string = 'will-be-set-by-deployment-script'
output tenantId string = subscription().tenantId