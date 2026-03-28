resource routeTable 'Microsoft.Network/routeTables@2024-07-01' = {
  name: 'example-route-table-from-bicep'
  location: 'berlin'
  properties: {
    routes: [
      {
        name: 'default-route'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'Internet'
        }
      }
    ]
  }
}