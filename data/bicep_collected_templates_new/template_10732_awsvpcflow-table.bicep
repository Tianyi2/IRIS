// Bicep template for Log Analytics custom table: AWSVPCFlow
// Generated on 2025-09-19 14:13:49 UTC
// Source: JSON schema export
// Original columns: 43, Deployed columns: 42 (Type column filtered)
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

resource awsvpcflowTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'AWSVPCFlow'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'AWSVPCFlow'
      description: 'Custom table AWSVPCFlow - imported from JSON schema'
      displayName: 'AWSVPCFlow'
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
          name: 'AzId'
          type: 'string'
        }
        {
          name: 'SublocationType'
          type: 'string'
        }
        {
          name: 'SublocationId'
          type: 'string'
        }
        {
          name: 'PktSrcAwsService'
          type: 'string'
        }
        {
          name: 'PktDstAwsService'
          type: 'string'
        }
        {
          name: 'FlowDirection'
          type: 'string'
        }
        {
          name: 'TrafficPath'
          type: 'string'
        }
        {
          name: 'Start'
          type: 'dateTime'
        }
        {
          name: 'EcsClusterArn'
          type: 'string'
        }
        {
          name: 'EcsClusterName'
          type: 'string'
        }
        {
          name: 'EcsContainerInstanceArn'
          type: 'string'
        }
        {
          name: 'EcsContainerInstanceId'
          type: 'string'
        }
        {
          name: 'EcsContainerId'
          type: 'string'
        }
        {
          name: 'EcsSecondContainerId'
          type: 'string'
        }
        {
          name: 'EcsServiceName'
          type: 'string'
        }
        {
          name: 'EcsTaskDefinitionArn'
          type: 'string'
        }
        {
          name: 'EcsTaskArn'
          type: 'string'
        }
        {
          name: 'Region'
          type: 'string'
        }
        {
          name: 'EcsTaskId'
          type: 'string'
        }
        {
          name: 'PktDstAddr'
          type: 'string'
        }
        {
          name: 'TrafficType'
          type: 'string'
        }
        {
          name: 'Version'
          type: 'int'
        }
        {
          name: 'AccountId'
          type: 'string'
        }
        {
          name: 'InterfaceId'
          type: 'string'
        }
        {
          name: 'SrcAddr'
          type: 'string'
        }
        {
          name: 'DstAddr'
          type: 'string'
        }
        {
          name: 'SrcPort'
          type: 'int'
        }
        {
          name: 'DstPort'
          type: 'int'
        }
        {
          name: 'Protocol'
          type: 'int'
        }
        {
          name: 'Packets'
          type: 'int'
        }
        {
          name: 'Bytes'
          type: 'long'
        }
        {
          name: 'End'
          type: 'dateTime'
        }
        {
          name: 'Action'
          type: 'string'
        }
        {
          name: 'LogStatus'
          type: 'string'
        }
        {
          name: 'VpcId'
          type: 'string'
        }
        {
          name: 'SubnetId'
          type: 'string'
        }
        {
          name: 'InstanceId'
          type: 'string'
        }
        {
          name: 'TcpFlags'
          type: 'int'
        }
        {
          name: 'PktSrcAddr'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = awsvpcflowTable.name
output tableId string = awsvpcflowTable.id
output provisioningState string = awsvpcflowTable.properties.provisioningState
