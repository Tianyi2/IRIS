param staticSiteName string
param staticSiteLocation string
param staticSiteSku string

resource staticSite 'Microsoft.Web/staticSites@2024-04-01' = {
  name: staticSiteName
  location: staticSiteLocation
  sku: {
    name: staticSiteSku
  }
  properties: {}
}

output staticSiteEndpoint string = staticSite.properties.defaultHostname
output staticSiteName string = staticSite.name
