param resourceNamePrefix string = 'promitor-scale-resources'

resource workflowInEastAsia 'Microsoft.Logic/workflows@2019-05-01' = [for i in range(1, 200): {
  name: '${resourceNamePrefix}-workflow-ea-${format('{0:D3}', i)}'
  location: 'eastasia'
  tags: {
    region: 'Asia'
    app: 'promitor-large-scale-testing'
    instance: '${resourceNamePrefix}-workflow-we-${format('{0:D3}', i)}'
  }
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      parameters: {}
      triggers: {}
      actions: {}
      outputs: {}
    }
    parameters: {}
  }
}]

resource workflowInEastAustralia 'Microsoft.Logic/workflows@2019-05-01' = [for i in range(1, 200): {
  name: '${resourceNamePrefix}-workflow-aue-${format('{0:D3}', i)}'
  location: 'australiaeast'
  tags: {
    region: 'Australia'
    app: 'promitor-large-scale-testing'
    instance: '${resourceNamePrefix}-workflow-au-${format('{0:D3}', i)}'
  }
  properties: {
    state: 'Enabled'
    definition: {
      '$schema': 'https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowdefinition.json#'
      contentVersion: '1.0.0.0'
      parameters: {}
      triggers: {}
      actions: {}
      outputs: {}
    }
    parameters: {}
  }
}]
