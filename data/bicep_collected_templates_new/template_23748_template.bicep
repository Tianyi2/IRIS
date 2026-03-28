resource bicep_dns 'Microsoft.Network/dnsZones@2018-05-01' = {
  name: 'example.com'
  location: 'berlin'
  properties: {}
  sku: {
    name: 'Aligned'
  }
}
