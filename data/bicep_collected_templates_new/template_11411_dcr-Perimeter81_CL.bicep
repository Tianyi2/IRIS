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
// Data Collection Rule for Perimeter81_CL
// ============================================================================
// Generated: 2025-09-19 14:20:28
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 72, DCR columns: 70 (Type column always filtered)
// Output stream: Custom-Perimeter81_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-Perimeter81_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-Perimeter81_CL': {
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
            name: 'application_type_s'
            type: 'string'
          }
          {
            name: 'application_endpoint_s'
            type: 'string'
          }
          {
            name: 'application_alias_cname_s'
            type: 'string'
          }
          {
            name: 'idpName_s'
            type: 'string'
          }
          {
            name: 'network_name_s'
            type: 'string'
          }
          {
            name: 'network_dns_s'
            type: 'string'
          }
          {
            name: 'geoPoint_accuracy_radius_d'
            type: 'string'
          }
          {
            name: 'geoPoint_latitude_d'
            type: 'string'
          }
          {
            name: 'geoPoint_longitude_d'
            type: 'string'
          }
          {
            name: 'geoPoint_metro_code_d'
            type: 'string'
          }
          {
            name: 'geoPoint_time_zone_s'
            type: 'string'
          }
          {
            name: 'addressCountry_s'
            type: 'string'
          }
          {
            name: 'event_eventName_s'
            type: 'string'
          }
          {
            name: 'event_tenantId_s'
            type: 'string'
          }
          {
            name: 'event_originalTenantId_s'
            type: 'string'
          }
          {
            name: 'event_releasedFrom_tenantId_s'
            type: 'string'
          }
          {
            name: 'event_releasedBy_email_s'
            type: 'string'
          }
          {
            name: 'ip_s'
            type: 'string'
          }
          {
            name: 'releasedBy_email_s'
            type: 'string'
          }
          {
            name: 'releasedFrom_tenantId_s'
            type: 'string'
          }
          {
            name: 'originalTenantId_s'
            type: 'string'
          }
          {
            name: 'eventName_s'
            type: 'string'
          }
          {
            name: 'integrationName_s'
            type: 'string'
          }
          {
            name: 'application_name_s'
            type: 'string'
          }
          {
            name: 'releasedBy_firstName_s'
            type: 'string'
          }
          {
            name: 'releasedBy_tenantId_s'
            type: 'string'
          }
          {
            name: 'releasedFrom_company_s'
            type: 'string'
          }
          {
            name: 'releasedFrom_name_s'
            type: 'string'
          }
          {
            name: 'event_eventVersion_s'
            type: 'string'
          }
          {
            name: 'event_integrationIdentifier_s'
            type: 'string'
          }
          {
            name: 'event_ip_s'
            type: 'string'
          }
          {
            name: 'releasedBy_lastName_s'
            type: 'string'
          }
          {
            name: 'integrationIdentifier_s'
            type: 'string'
          }
          {
            name: 'paymentInfo_s'
            type: 'string'
          }
          {
            name: 'networkName_s'
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
            name: 'emails_s'
            type: 'string'
          }
          {
            name: 'enabled_b'
            type: 'string'
          }
          {
            name: 'installation_installationId_g'
            type: 'string'
          }
          {
            name: 'releasedBy_roleName_s'
            type: 'string'
          }
          {
            name: 'role_displayName_s'
            type: 'string'
          }
          {
            name: 'oldRole_displayName_s'
            type: 'string'
          }
          {
            name: 'planName_s'
            type: 'string'
          }
          {
            name: 'planId_s'
            type: 'string'
          }
          {
            name: 'error_message_s'
            type: 'string'
          }
          {
            name: 'amount_d'
            type: 'string'
          }
          {
            name: 'vpnLocation_name_s'
            type: 'string'
          }
          {
            name: 'account_tenantId_s'
            type: 'string'
          }
          {
            name: 'group_name_s'
            type: 'string'
          }
          {
            name: 'regions_s'
            type: 'string'
          }
          {
            name: 'policy_name_s'
            type: 'string'
          }
          {
            name: 'user_firstName_s'
            type: 'string'
          }
          {
            name: 'user_lastName_s'
            type: 'string'
          }
          {
            name: 'user_email_s'
            type: 'string'
          }
          {
            name: 'applicationName_s'
            type: 'string'
          }
          {
            name: 'user_tenantId_s'
            type: 'string'
          }
          {
            name: 'newPlan_planWeight_d'
            type: 'string'
          }
          {
            name: 'oldPlan_name_s'
            type: 'string'
          }
          {
            name: 'oldPlan_planWeight_d'
            type: 'string'
          }
          {
            name: 'installation_installationId_s'
            type: 'string'
          }
          {
            name: 'account_company_s'
            type: 'string'
          }
          {
            name: 'account_name_s'
            type: 'string'
          }
          {
            name: 'newPlan_name_s'
            type: 'string'
          }
          {
            name: 'eventVersion_s'
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
          name: 'Sentinel-Perimeter81_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-Perimeter81_CL']
        destinations: ['Sentinel-Perimeter81_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), TenantId = toguid(TenantId), application_type_s = tostring(application_type_s), application_endpoint_s = tostring(application_endpoint_s), application_alias_cname_s = tostring(application_alias_cname_s), idpName_s = tostring(idpName_s), network_name_s = tostring(network_name_s), network_dns_s = tostring(network_dns_s), geoPoint_accuracy_radius_d = toreal(geoPoint_accuracy_radius_d), geoPoint_latitude_d = toreal(geoPoint_latitude_d), geoPoint_longitude_d = toreal(geoPoint_longitude_d), geoPoint_metro_code_d = toreal(geoPoint_metro_code_d), geoPoint_time_zone_s = tostring(geoPoint_time_zone_s), addressCountry_s = tostring(addressCountry_s), event_eventName_s = tostring(event_eventName_s), event_tenantId_s = tostring(event_tenantId_s), event_originalTenantId_s = tostring(event_originalTenantId_s), event_releasedFrom_tenantId_s = tostring(event_releasedFrom_tenantId_s), event_releasedBy_email_s = tostring(event_releasedBy_email_s), ip_s = tostring(ip_s), releasedBy_email_s = tostring(releasedBy_email_s), releasedFrom_tenantId_s = tostring(releasedFrom_tenantId_s), originalTenantId_s = tostring(originalTenantId_s), eventName_s = tostring(eventName_s), integrationName_s = tostring(integrationName_s), application_name_s = tostring(application_name_s), releasedBy_firstName_s = tostring(releasedBy_firstName_s), releasedBy_tenantId_s = tostring(releasedBy_tenantId_s), releasedFrom_company_s = tostring(releasedFrom_company_s), releasedFrom_name_s = tostring(releasedFrom_name_s), event_eventVersion_s = tostring(event_eventVersion_s), event_integrationIdentifier_s = tostring(event_integrationIdentifier_s), event_ip_s = tostring(event_ip_s), releasedBy_lastName_s = tostring(releasedBy_lastName_s), integrationIdentifier_s = tostring(integrationIdentifier_s), paymentInfo_s = tostring(paymentInfo_s), networkName_s = tostring(networkName_s), SourceSystem = tostring(SourceSystem), MG = tostring(MG), ManagementGroupName = tostring(ManagementGroupName), Computer = tostring(Computer), RawData = tostring(RawData), emails_s = tostring(emails_s), enabled_b = tostring(enabled_b), installation_installationId_g = tostring(installation_installationId_g), releasedBy_roleName_s = tostring(releasedBy_roleName_s), role_displayName_s = tostring(role_displayName_s), oldRole_displayName_s = tostring(oldRole_displayName_s), planName_s = tostring(planName_s), planId_s = tostring(planId_s), error_message_s = tostring(error_message_s), amount_d = toreal(amount_d), vpnLocation_name_s = tostring(vpnLocation_name_s), account_tenantId_s = tostring(account_tenantId_s), group_name_s = tostring(group_name_s), regions_s = tostring(regions_s), policy_name_s = tostring(policy_name_s), user_firstName_s = tostring(user_firstName_s), user_lastName_s = tostring(user_lastName_s), user_email_s = tostring(user_email_s), applicationName_s = tostring(applicationName_s), user_tenantId_s = tostring(user_tenantId_s), newPlan_planWeight_d = tostring(newPlan_planWeight_d), oldPlan_name_s = tostring(oldPlan_name_s), oldPlan_planWeight_d = toreal(oldPlan_planWeight_d), installation_installationId_s = tostring(installation_installationId_s), account_company_s = tostring(account_company_s), account_name_s = tostring(account_name_s), newPlan_name_s = tostring(newPlan_name_s), eventVersion_s = tostring(eventVersion_s)'
        outputStream: 'Custom-Perimeter81_CL'
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
