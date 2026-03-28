// Bicep template for Log Analytics custom table: LinuxAudit_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 53, Deployed columns: 51 (Type column filtered)
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

resource linuxauditclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'LinuxAudit_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'LinuxAudit_CL'
      description: 'Custom table LinuxAudit_CL - imported from JSON schema'
      displayName: 'LinuxAudit_CL'
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
          name: 'auid_s'
          type: 'string'
        }
        {
          name: 'ses_s'
          type: 'string'
        }
        {
          name: 'path_s'
          type: 'string'
        }
        {
          name: 'key_s'
          type: 'string'
        }
        {
          name: 'list_s'
          type: 'string'
        }
        {
          name: 'res_s'
          type: 'string'
        }
        {
          name: 'arch_s'
          type: 'string'
        }
        {
          name: 'syscall_s'
          type: 'string'
        }
        {
          name: 'success_s'
          type: 'string'
        }
        {
          name: 'exit_d'
          type: 'real'
        }
        {
          name: 'items_d'
          type: 'real'
        }
        {
          name: 'ppid_d'
          type: 'real'
        }
        {
          name: 'pid_d'
          type: 'real'
        }
        {
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 'gid_s'
          type: 'string'
        }
        {
          name: 'euid_s'
          type: 'string'
        }
        {
          name: 'suid_s'
          type: 'string'
        }
        {
          name: 'fsuid_s'
          type: 'string'
        }
        {
          name: 'egid_s'
          type: 'string'
        }
        {
          name: 'sgid_s'
          type: 'string'
        }
        {
          name: 'fsgid_s'
          type: 'string'
        }
        {
          name: 'argc_s'
          type: 'string'
        }
        {
          name: 'SourceModuleType_s'
          type: 'string'
        }
        {
          name: 'SourceModuleName_s'
          type: 'string'
        }
        {
          name: 'EventReceivedTime_t'
          type: 'dateTime'
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
          name: 'type_s'
          type: 'string'
        }
        {
          name: 'time_t'
          type: 'dateTime'
        }
        {
          name: 'seq_d'
          type: 'real'
        }
        {
          name: 'item_d'
          type: 'real'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'comm_s'
          type: 'string'
        }
        {
          name: 'inode_d'
          type: 'real'
        }
        {
          name: 'mode_s'
          type: 'string'
        }
        {
          name: 'ouid_s'
          type: 'string'
        }
        {
          name: 'ogid_s'
          type: 'string'
        }
        {
          name: 'rdev_s'
          type: 'string'
        }
        {
          name: 'nametype_s'
          type: 'string'
        }
        {
          name: 'cap_fp_s'
          type: 'string'
        }
        {
          name: 'cap_fi_s'
          type: 'string'
        }
        {
          name: 'cap_fe_s'
          type: 'string'
        }
        {
          name: 'cap_fver_s'
          type: 'string'
        }
        {
          name: 'cap_frootid_s'
          type: 'string'
        }
        {
          name: 'dev_s'
          type: 'string'
        }
        {
          name: 'exe_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = linuxauditclTable.name
output tableId string = linuxauditclTable.id
output provisioningState string = linuxauditclTable.properties.provisioningState
