param namePrefix string
param location string = resourceGroup().location

var laName = '${namePrefix}-log-analytics-workspace'

resource la 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: laName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

var slnName = 'Containers(${la.name})'

resource sln 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: slnName
  location: location
  plan: {
    name: slnName
    product: 'OMSGallery/Containers'
    publisher: 'Microsoft'
    promotionCode: ''
  }
  properties: {
    workspaceResourceId: la.id
  }
}

resource diagnosticsettings 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: la
  name: '${la.name}-diagnosticSettings'
  properties: {
    workspaceId: la.id
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
    ]
    logs:[
      {
        categoryGroup: 'allLogs'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
/*      {
        categoryGroup: 'audit'
        enabled: true
        retentionPolicy: {
          days: 90
          enabled: true
        }
      }
*/
]
  }
}

output laName string = la.name
output slnName string = sln.name

