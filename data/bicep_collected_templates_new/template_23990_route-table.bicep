param name string
param location string
param disableBgpRoutePropagation bool = false
param routes array = []

resource routeTable 'Microsoft.Network/routeTables@2024-07-01' = {
  name: name
  location: location
  properties: {
    disableBgpRoutePropagation: disableBgpRoutePropagation
    routes: [
      for route in routes: {
        name: route.name
        properties: {
          addressPrefix: route.addressPrefix
          nextHopType: route.nextHopType
          nextHopIpAddress: route.nextHopIpAddress
        }
      }
    ]
  }
}
