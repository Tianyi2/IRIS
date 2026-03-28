@description('The location of the resources')
param location string = 'Australia East'
@description('The name of the Data Collection Endpoint Id')
param dataCollectionEndpointId string
@description('The Log Analytics Workspace Id used for Sentinel')
param workspaceResourceId string
@description('The Target Sentinel workspace name')
param workspaceName string = 'sentinel-workspace'
@description('The Service Principal Object ID of the Entra App')
param servicePrincipalObjectId string

// ============================================================================
// Data Collection Rule for LinuxAudit_CL
// ============================================================================
// Generated: 2025-09-19 14:20:23
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 53, DCR columns: 51 (Type column always filtered)
// Output stream: Custom-LinuxAudit_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-LinuxAudit_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-LinuxAudit_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
          }
          {
            name: 'TenantId'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'items_d'
            type: 'string'
          }
          {
            name: 'ppid_d'
            type: 'string'
          }
          {
            name: 'pid_d'
            type: 'string'
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
            name: 'type_s'
            type: 'string'
          }
          {
            name: 'time_t'
            type: 'string'
          }
          {
            name: 'seq_d'
            type: 'string'
          }
          {
            name: 'item_d'
            type: 'string'
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
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-LinuxAudit_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-LinuxAudit_CL']
        destinations: ['Sentinel-LinuxAudit_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), auid_s = tostring(auid_s), ses_s = tostring(ses_s), path_s = tostring(path_s), key_s = tostring(key_s), list_s = tostring(list_s), res_s = tostring(res_s), arch_s = tostring(arch_s), syscall_s = tostring(syscall_s), success_s = tostring(success_s), exit_d = toreal(exit_d), items_d = toreal(items_d), ppid_d = toreal(ppid_d), pid_d = toreal(pid_d), uid_s = tostring(uid_s), gid_s = tostring(gid_s), euid_s = tostring(euid_s), suid_s = tostring(suid_s), fsuid_s = tostring(fsuid_s), egid_s = tostring(egid_s), sgid_s = tostring(sgid_s), fsgid_s = tostring(fsgid_s), argc_s = tostring(argc_s), SourceModuleType_s = tostring(SourceModuleType_s), SourceModuleName_s = tostring(SourceModuleName_s), EventReceivedTime_t = todatetime(EventReceivedTime_t), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), type_s = tostring(type_s), time_t = todatetime(time_t), seq_d = toreal(seq_d), item_d = toreal(item_d), name_s = tostring(name_s), comm_s = tostring(comm_s), inode_d = toreal(inode_d), mode_s = tostring(mode_s), ouid_s = tostring(ouid_s), ogid_s = tostring(ogid_s), rdev_s = tostring(rdev_s), nametype_s = tostring(nametype_s), cap_fp_s = tostring(cap_fp_s), cap_fi_s = tostring(cap_fi_s), cap_fe_s = tostring(cap_fe_s), cap_fver_s = tostring(cap_fver_s), cap_frootid_s = tostring(cap_frootid_s), dev_s = tostring(dev_s), exe_s = tostring(exe_s)'
        outputStream: 'Custom-LinuxAudit_CL'
      }
    ]
  }
}

// Role Assignment to the DCR
resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: dataCollectionRule
  name: guid(resourceGroup().id, roleDefinitionResourceId, dataCollectionRule.name)
  properties: {
    roleDefinitionId: roleDefinitionResourceId
    principalId: servicePrincipalObjectId
    principalType: 'ServicePrincipal'
  }
}

output immutableId string = dataCollectionRule.properties.immutableId
output dataCollectionRuleId string = dataCollectionRule.id
output dataCollectionRuleName string = dataCollectionRule.name
