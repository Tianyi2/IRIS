resource proximityPlacementGroup 'Microsoft.Compute/proximityPlacementGroups@2024-11-01' = {
  name: 'example-ppg-from-bicep'
  location: 'berlin'
  properties: {
    proximityPlacementGroupType: 'Standard'
  }
}