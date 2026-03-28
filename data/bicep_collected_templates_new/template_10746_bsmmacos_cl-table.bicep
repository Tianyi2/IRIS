// Bicep template for Log Analytics custom table: BSMmacOS_CL
// Generated on 2025-09-19 14:13:50 UTC
// Source: JSON schema export
// Original columns: 38, Deployed columns: 36 (Type column filtered)
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

resource bsmmacosclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'BSMmacOS_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'BSMmacOS_CL'
      description: 'Custom table BSMmacOS_CL - imported from JSON schema'
      displayName: 'BSMmacOS_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'TenantId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'SubjectTerminal_Port_s'
          type: 'string'
        }
        {
          name: 'SubjectTerminal_Host_s'
          type: 'string'
        }
        {
          name: 'Text_s'
          type: 'string'
        }
        {
          name: 'ReturnErrno_s'
          type: 'string'
        }
        {
          name: 'ReturnRetval_s'
          type: 'string'
        }
        {
          name: 'Identity_s'
          type: 'string'
        }
        {
          name: 'SubjectTerminal_s'
          type: 'string'
        }
        {
          name: 'Identity_SignerType_s'
          type: 'string'
        }
        {
          name: 'Identity_SignerIdTruncated_s'
          type: 'string'
        }
        {
          name: 'Identity_TeamId_s'
          type: 'string'
        }
        {
          name: 'Identity_TeamIdTruncated_s'
          type: 'string'
        }
        {
          name: 'Identity_CDHash_s'
          type: 'string'
        }
        {
          name: 'TrailerCount_s'
          type: 'string'
        }
        {
          name: 'EventReceivedTime_t'
          type: 'dateTime'
        }
        {
          name: 'Identity_SignerId_s'
          type: 'string'
        }
        {
          name: 'SourceModuleName_s'
          type: 'string'
        }
        {
          name: 'SubjectSID_s'
          type: 'string'
        }
        {
          name: 'SubjectRealGID_s'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'TokenVersion_s'
          type: 'string'
        }
        {
          name: 'SubjectPID_s'
          type: 'string'
        }
        {
          name: 'EventType_s'
          type: 'string'
        }
        {
          name: 'EventModifier_s'
          type: 'string'
        }
        {
          name: 'EventTime_s'
          type: 'string'
        }
        {
          name: 'SubjectAuditID_s'
          type: 'string'
        }
        {
          name: 'SubjectUID_s'
          type: 'string'
        }
        {
          name: 'SubjectGID_s'
          type: 'string'
        }
        {
          name: 'SubjectRealUID_s'
          type: 'string'
        }
        {
          name: 'EventName_s'
          type: 'string'
        }
        {
          name: 'SourceModuleType_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = bsmmacosclTable.name
output tableId string = bsmmacosclTable.id
output provisioningState string = bsmmacosclTable.properties.provisioningState
