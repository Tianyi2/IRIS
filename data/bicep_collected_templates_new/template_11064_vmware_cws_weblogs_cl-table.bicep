// Bicep template for Log Analytics custom table: VMware_CWS_Weblogs_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 48, Deployed columns: 48 (Type column filtered)
// Underscore columns filtered out
// dataTypeHint values: 0=Uri, 1=Guid, 2=ArmPath, 3=IP

@description('Log Analytics Workspace name')
param workspaceName string

@description('Table plan - Analytics or Basic')
@allowed(['Analytics', 'Basic'])
param tablePlan string = 'Analytics'

@description('Data retention period in days')
@minValue(4)
@maxValue(730)
param retentionInDays int = 30

@description('Total retention period in days')
@minValue(4)
@maxValue(4383)
param totalRetentionInDays int = 30

resource workspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' existing = {
  name: workspaceName
}

resource vmwarecwsweblogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'VMware_CWS_Weblogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'VMware_CWS_Weblogs_CL'
      description: 'Custom table VMware_CWS_Weblogs_CL - imported from JSON schema'
      displayName: 'VMware_CWS_Weblogs_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'accessMode'
          type: 'string'
        }
        {
          name: 'policyName'
          type: 'string'
        }
        {
          name: 'protocol'
          type: 'string'
        }
        {
          name: 'region'
          type: 'string'
        }
        {
          name: 'requestMethod'
          type: 'string'
        }
        {
          name: 'requestType'
          type: 'string'
        }
        {
          name: 'responseCode'
          type: 'string'
        }
        {
          name: 'risks'
          type: 'dynamic'
        }
        {
          name: 'ruleMatched'
          type: 'string'
        }
        {
          name: 'saasEgressHeaders'
          type: 'dynamic'
        }
        {
          name: 'policyHeaders'
          type: 'string'
        }
        {
          name: 'sandboxInspectionResult'
          type: 'string'
        }
        {
          name: 'sandboxScore'
          type: 'string'
        }
        {
          name: 'sourceIp'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'srcCountry'
          type: 'string'
        }
        {
          name: 'threatTypes'
          type: 'dynamic'
        }
        {
          name: 'url'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'userAgent'
          type: 'string'
        }
        {
          name: 'userGroups'
          type: 'dynamic'
        }
        {
          name: 'userGroupsMatched'
          type: 'dynamic'
        }
        {
          name: 'userId'
          type: 'string'
          dataTypeHint: 1
        }
        {
          name: 'sandboxMaliciousActivitiesFound'
          type: 'string'
        }
        {
          name: 'virusList'
          type: 'string'
        }
        {
          name: 'mimeType'
          type: 'string'
        }
        {
          name: 'fileSize'
          type: 'string'
        }
        {
          name: 'action'
          type: 'string'
        }
        {
          name: 'browserType'
          type: 'dynamic'
        }
        {
          name: 'browserVersion'
          type: 'dynamic'
        }
        {
          name: 'casbAppName'
          type: 'dynamic'
        }
        {
          name: 'casbCatName'
          type: 'dynamic'
        }
        {
          name: 'casbFunName'
          type: 'dynamic'
        }
        {
          name: 'casbOrgName'
          type: 'dynamic'
        }
        {
          name: 'casbRiskScore'
          type: 'dynamic'
        }
        {
          name: 'categories'
          type: 'string'
        }
        {
          name: 'fileType'
          type: 'string'
        }
        {
          name: 'contentType'
          type: 'string'
        }
        {
          name: 'destinationIp'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'dnsResponse'
          type: 'string'
        }
        {
          name: 'domain'
          type: 'string'
        }
        {
          name: 'dstCountry'
          type: 'string'
        }
        {
          name: 'egressIp'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'fileHash'
          type: 'dynamic'
        }
        {
          name: 'fileHashScore'
          type: 'string'
        }
        {
          name: 'fileName'
          type: 'string'
        }
        {
          name: 'fileScanResult'
          type: 'dynamic'
        }
        {
          name: 'cws_timestamp'
          type: 'dateTime'
        }
        {
          name: 'webRiskScore'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = vmwarecwsweblogsclTable.name
output tableId string = vmwarecwsweblogsclTable.id
output provisioningState string = vmwarecwsweblogsclTable.properties.provisioningState
