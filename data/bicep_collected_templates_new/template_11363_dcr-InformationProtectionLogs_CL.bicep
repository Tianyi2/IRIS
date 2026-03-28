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
// Data Collection Rule for InformationProtectionLogs_CL
// ============================================================================
// Generated: 2025-09-19 14:20:22
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 85, DCR columns: 83 (Type column always filtered)
// Output stream: Custom-InformationProtectionLogs_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-InformationProtectionLogs_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-InformationProtectionLogs_CL': {
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'IsLabelChanged_b'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'Protected_b'
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-InformationProtectionLogs_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-InformationProtectionLogs_CL']
        destinations: ['Sentinel-InformationProtectionLogs_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), LabelName_s = tostring(LabelName_s), AadTenantId_g = tostring(AadTenantId_g), DeviceId_g = tostring(DeviceId_g), ActionSource_s = tostring(ActionSource_s), MachineId_s = tostring(MachineId_s), DeviceRisk_s = tostring(DeviceRisk_s), InformationTypesAbove95_s = tostring(InformationTypesAbove95_s), ParentLabelName_s = tostring(ParentLabelName_s), InformationTypesAbove85_s = tostring(InformationTypesAbove85_s), InformationTypesAbove65_s = tostring(InformationTypesAbove65_s), InformationTypesAbove55_s = tostring(InformationTypesAbove55_s), DiscoveredInformationTypes_s = tostring(DiscoveredInformationTypes_s), InformationTypes_s = tostring(InformationTypes_s), DeviceId_s = tostring(DeviceId_s), ProcessVersion_s = tostring(ProcessVersion_s), ProtectionTime_t = todatetime(ProtectionTime_t), InformationTypesAbove75_s = tostring(InformationTypesAbove75_s), UserId_s = tostring(UserId_s), MachineName_s = tostring(MachineName_s), Version_s = tostring(Version_s), LogId_g = tostring(LogId_g), ProductVersion_s = tostring(ProductVersion_s), IsProtectionChanged_b = tobool(IsProtectionChanged_b), IsLabelChanged_b = tobool(IsLabelChanged_b), DataState_s = tostring(DataState_s), ApplicationId_g = tostring(ApplicationId_g), Location_s = tostring(Location_s), Activity_s = tostring(Activity_s), Platform_s = tostring(Platform_s), ProtectedBeforeAction_b = tobool(ProtectedBeforeAction_b), Protected_b = tobool(Protected_b), LabelId_g = tostring(LabelId_g), ObjectId_s = tostring(ObjectId_s), Operation_s = tostring(Operation_s), ApplicationName_s = tostring(ApplicationName_s), ProcessName_s = tostring(ProcessName_s), Workload_s = tostring(Workload_s), ContentId_g = tostring(ContentId_g), ProtectionOwner_s = tostring(ProtectionOwner_s), ProtectionType_s = tostring(ProtectionType_s), TemplateId_g = tostring(TemplateId_g), AadTenantId_g_g = tostring(AadTenantId_g_g), ProcessVersion_s_s = tostring(ProcessVersion_s_s), ProtectionTime_t_UTC__s = tostring(ProtectionTime_t_UTC__s), ContentId_g_g = tostring(ContentId_g_g), ProtectionOwner_s_s = tostring(ProtectionOwner_s_s), ProtectionType_s_s = tostring(ProtectionType_s_s), TemplateId_g_g = tostring(TemplateId_g_g), TimeGenerated_UTC__s = tostring(TimeGenerated_UTC__s), TimeGenerated_s = tostring(TimeGenerated_s), Protected_s = tostring(Protected_s), ProtectionTime_s = tostring(ProtectionTime_s), PK_LA___Content_Types__xml_MN_0_H_nY_t_Q_Ic_g_b_2p_J_6_oE_V_P_t_3_vX_I_u_p_e_nd_z_Q_Q_K_oH_X_U_s = tostring(PK_LA___Content_Types__xml_MN_0_H_nY_t_Q_Ic_g_b_2p_J_6_oE_V_P_t_3_vX_I_u_p_e_nd_z_Q_Q_K_oH_X_U_s), RawData = tostring(RawData), Computer = tostring(Computer), ManagementGroupName = tostring(ManagementGroupName), MG = tostring(MG), SourceSystem = tostring(SourceSystem), UserId_s_s = tostring(UserId_s_s), ActionId_g = tostring(ActionId_g), Version_s_s = tostring(Version_s_s), ProcessName_s_s = tostring(ProcessName_s_s), ActionIdBefore_g = tostring(ActionIdBefore_g), LabelNameBefore_s = tostring(LabelNameBefore_s), SensitivityChange_s = tostring(SensitivityChange_s), LabelIdBeforeAction_g = tostring(LabelIdBeforeAction_g), ParentLabelNameBefore_s = tostring(ParentLabelNameBefore_s), TemplateIdBefore_g = tostring(TemplateIdBefore_g), ProtectionTypeBefore_s = tostring(ProtectionTypeBefore_s), MatchedLabelName_s = tostring(MatchedLabelName_s), MatchedLabelId_g = tostring(MatchedLabelId_g), IPv4_s_s = tostring(IPv4_s_s), LogId_g_g = tostring(LogId_g_g), DataState_s_s = tostring(DataState_s_s), Activity_s_s = tostring(Activity_s_s), Platform_s_s = tostring(Platform_s_s), Protected_b_s = tostring(Protected_b_s), Operation_s_s = tostring(Operation_s_s), ApplicationName_s_s = tostring(ApplicationName_s_s), Workload_s_s = tostring(Workload_s_s), IPv4_s = tostring(IPv4_s)'
        outputStream: 'Custom-InformationProtectionLogs_CL'
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
