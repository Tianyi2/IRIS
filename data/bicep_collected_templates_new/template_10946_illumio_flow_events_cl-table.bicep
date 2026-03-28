// Bicep template for Log Analytics custom table: Illumio_Flow_Events_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 32, Deployed columns: 31 (Type column filtered)
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

resource illumiofloweventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Illumio_Flow_Events_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Illumio_Flow_Events_CL'
      description: 'Custom table Illumio_Flow_Events_CL - imported from JSON schema'
      displayName: 'Illumio_Flow_Events_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'code'
          type: 'int'
        }
        {
          name: 'interval_sec'
          type: 'int'
        }
        {
          name: 'dst_labels'
          type: 'dynamic'
        }
        {
          name: 'src_labels'
          type: 'dynamic'
        }
        {
          name: 'network'
          type: 'string'
        }
        {
          name: 'dst_href'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'dst_hostname'
          type: 'string'
        }
        {
          name: 'src_href'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'src_hostname'
          type: 'string'
        }
        {
          name: 'pd'
          type: 'int'
        }
        {
          name: 'pd_qualifier'
          type: 'int'
        }
        {
          name: 'state'
          type: 'string'
        }
        {
          name: 'org_id'
          type: 'int'
        }
        {
          name: 'dir'
          type: 'string'
        }
        {
          name: 'flow_count'
          type: 'int'
        }
        {
          name: 'dst_port'
          type: 'int'
        }
        {
          name: 'proto'
          type: 'int'
        }
        {
          name: 'class'
          type: 'string'
        }
        {
          name: 'dst_ip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'src_ip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'un'
          type: 'string'
        }
        {
          name: 'pn'
          type: 'string'
        }
        {
          name: 'tdms'
          type: 'int'
        }
        {
          name: 'ddms'
          type: 'int'
        }
        {
          name: 'dst_tbo'
          type: 'int'
        }
        {
          name: 'dst_tbi'
          type: 'int'
        }
        {
          name: 'dst_dbo'
          type: 'int'
        }
        {
          name: 'dst_dbi'
          type: 'int'
        }
        {
          name: 'pce_fqdn'
          type: 'string'
        }
        {
          name: 'version'
          type: 'int'
        }
      ]
    }
  }
}

output tableName string = illumiofloweventsclTable.name
output tableId string = illumiofloweventsclTable.id
output provisioningState string = illumiofloweventsclTable.properties.provisioningState
