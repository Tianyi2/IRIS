param applicationName string
param environment string
param location string
param applicationInsightsConnectionString  string

var appServicePlanName = 'asp-${applicationName}-euw-${environment}'
var appServiceName = 'app-${applicationName}-euw-${environment}'

// App Service Plan (required to host the App Service)
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
    name: appServicePlanName
    location: location
    sku: {
        name: 'B1'
        tier: 'Basic'
        size: 'B1'
        family: 'B'
        capacity: 1
    }
    kind: 'linux' // or 'app' for standard App Service
    properties: {
        reserved: true //required for linux
    }
}

// App Service with system-assigned identity
resource appService 'Microsoft.Web/sites@2024-04-01' = {
    name: appServiceName
    location: location
    kind: 'app,linux' //ensures Linux web app setup
    identity: {
        type: 'SystemAssigned'
    }
    properties: {
        serverFarmId: appServicePlan.id
        siteConfig: {
            numberOfWorkers: 1
            linuxFxVersion: 'DOCKER|itigaidev.azurecr.io/odata-api:latest'
            acrUseManagedIdentityCreds: true
            alwaysOn: false
            http20Enabled: false
            functionAppScaleLimit: 0
            appSettings: [
                {
                    name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
                    value: applicationInsightsConnectionString
                }
            ]
        }            
        httpsOnly: true
    }
}

output appServicePrincipalId string = appService.identity.principalId