// Bicep template for Log Analytics custom table: InformationProtectionLogs_CL
// Generated on 2025-09-19 14:13:56 UTC
// Source: JSON schema export
// Original columns: 85, Deployed columns: 83 (Type column filtered)
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

resource informationprotectionlogsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'InformationProtectionLogs_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'InformationProtectionLogs_CL'
      description: 'Custom table InformationProtectionLogs_CL - imported from JSON schema'
      displayName: 'InformationProtectionLogs_CL'
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
          name: 'LabelName_s'
          type: 'string'
        }
        {
          name: 'AadTenantId_g'
          type: 'string'
        }
        {
          name: 'DeviceId_g'
          type: 'string'
        }
        {
          name: 'ActionSource_s'
          type: 'string'
        }
        {
          name: 'MachineId_s'
          type: 'string'
        }
        {
          name: 'DeviceRisk_s'
          type: 'string'
        }
        {
          name: 'InformationTypesAbove95_s'
          type: 'string'
        }
        {
          name: 'ParentLabelName_s'
          type: 'string'
        }
        {
          name: 'InformationTypesAbove85_s'
          type: 'string'
        }
        {
          name: 'InformationTypesAbove65_s'
          type: 'string'
        }
        {
          name: 'InformationTypesAbove55_s'
          type: 'string'
        }
        {
          name: 'DiscoveredInformationTypes_s'
          type: 'string'
        }
        {
          name: 'InformationTypes_s'
          type: 'string'
        }
        {
          name: 'DeviceId_s'
          type: 'string'
        }
        {
          name: 'ProcessVersion_s'
          type: 'string'
        }
        {
          name: 'ProtectionTime_t'
          type: 'dateTime'
        }
        {
          name: 'InformationTypesAbove75_s'
          type: 'string'
        }
        {
          name: 'UserId_s'
          type: 'string'
        }
        {
          name: 'MachineName_s'
          type: 'string'
        }
        {
          name: 'Version_s'
          type: 'string'
        }
        {
          name: 'LogId_g'
          type: 'string'
        }
        {
          name: 'ProductVersion_s'
          type: 'string'
        }
        {
          name: 'IsProtectionChanged_b'
          type: 'boolean'
        }
        {
          name: 'IsLabelChanged_b'
          type: 'boolean'
        }
        {
          name: 'DataState_s'
          type: 'string'
        }
        {
          name: 'ApplicationId_g'
          type: 'string'
        }
        {
          name: 'Location_s'
          type: 'string'
        }
        {
          name: 'Activity_s'
          type: 'string'
        }
        {
          name: 'Platform_s'
          type: 'string'
        }
        {
          name: 'ProtectedBeforeAction_b'
          type: 'boolean'
        }
        {
          name: 'Protected_b'
          type: 'boolean'
        }
        {
          name: 'LabelId_g'
          type: 'string'
        }
        {
          name: 'ObjectId_s'
          type: 'string'
        }
        {
          name: 'Operation_s'
          type: 'string'
        }
        {
          name: 'ApplicationName_s'
          type: 'string'
        }
        {
          name: 'ProcessName_s'
          type: 'string'
        }
        {
          name: 'Workload_s'
          type: 'string'
        }
        {
          name: 'ContentId_g'
          type: 'string'
        }
        {
          name: 'ProtectionOwner_s'
          type: 'string'
        }
        {
          name: 'ProtectionType_s'
          type: 'string'
        }
        {
          name: 'TemplateId_g'
          type: 'string'
        }
        {
          name: 'AadTenantId_g_g'
          type: 'string'
        }
        {
          name: 'ProcessVersion_s_s'
          type: 'string'
        }
        {
          name: 'ProtectionTime_t_UTC__s'
          type: 'string'
        }
        {
          name: 'ContentId_g_g'
          type: 'string'
        }
        {
          name: 'ProtectionOwner_s_s'
          type: 'string'
        }
        {
          name: 'ProtectionType_s_s'
          type: 'string'
        }
        {
          name: 'TemplateId_g_g'
          type: 'string'
        }
        {
          name: 'TimeGenerated_UTC__s'
          type: 'string'
        }
        {
          name: 'TimeGenerated_s'
          type: 'string'
        }
        {
          name: 'Protected_s'
          type: 'string'
        }
        {
          name: 'ProtectionTime_s'
          type: 'string'
        }
        {
          name: 'PK_LA___Content_Types__xml_MN_0_H_nY_t_Q_Ic_g_b_2p_J_6_oE_V_P_t_3_vX_I_u_p_e_nd_z_Q_Q_K_oH_X_U_s'
          type: 'string'
        }
        {
          name: 'RawData'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'UserId_s_s'
          type: 'string'
        }
        {
          name: 'ActionId_g'
          type: 'string'
        }
        {
          name: 'Version_s_s'
          type: 'string'
        }
        {
          name: 'ProcessName_s_s'
          type: 'string'
        }
        {
          name: 'ActionIdBefore_g'
          type: 'string'
        }
        {
          name: 'LabelNameBefore_s'
          type: 'string'
        }
        {
          name: 'SensitivityChange_s'
          type: 'string'
        }
        {
          name: 'LabelIdBeforeAction_g'
          type: 'string'
        }
        {
          name: 'ParentLabelNameBefore_s'
          type: 'string'
        }
        {
          name: 'TemplateIdBefore_g'
          type: 'string'
        }
        {
          name: 'ProtectionTypeBefore_s'
          type: 'string'
        }
        {
          name: 'MatchedLabelName_s'
          type: 'string'
        }
        {
          name: 'MatchedLabelId_g'
          type: 'string'
        }
        {
          name: 'IPv4_s_s'
          type: 'string'
        }
        {
          name: 'LogId_g_g'
          type: 'string'
        }
        {
          name: 'DataState_s_s'
          type: 'string'
        }
        {
          name: 'Activity_s_s'
          type: 'string'
        }
        {
          name: 'Platform_s_s'
          type: 'string'
        }
        {
          name: 'Protected_b_s'
          type: 'string'
        }
        {
          name: 'Operation_s_s'
          type: 'string'
        }
        {
          name: 'ApplicationName_s_s'
          type: 'string'
        }
        {
          name: 'Workload_s_s'
          type: 'string'
        }
        {
          name: 'IPv4_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = informationprotectionlogsclTable.name
output tableId string = informationprotectionlogsclTable.id
output provisioningState string = informationprotectionlogsclTable.properties.provisioningState
