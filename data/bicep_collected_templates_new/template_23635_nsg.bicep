param name string
param location string
param laName string

var securityRules = json(loadTextContent('securityRules.json'))

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: name
  location: location
  properties: {
    securityRules: securityRules
  }
}

resource la 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' existing = {
  name:laName
}

resource diagnosticsettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: nsg
  name: '${nsg.name}-diagnosticSettings'
  properties: {
    workspaceId: la.id
    logs:[
      {
        categoryGroup: 'AllLogs'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
    ]
  }
}

output nsgName string = nsg.name
