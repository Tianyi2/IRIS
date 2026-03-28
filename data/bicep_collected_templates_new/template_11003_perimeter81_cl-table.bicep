// Bicep template for Log Analytics custom table: Perimeter81_CL
// Generated on 2025-09-19 14:13:57 UTC
// Source: JSON schema export
// Original columns: 72, Deployed columns: 70 (Type column filtered)
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

resource perimeter81clTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Perimeter81_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Perimeter81_CL'
      description: 'Custom table Perimeter81_CL - imported from JSON schema'
      displayName: 'Perimeter81_CL'
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
          type: 'real'
        }
        {
          name: 'geoPoint_latitude_d'
          type: 'real'
        }
        {
          name: 'geoPoint_longitude_d'
          type: 'real'
        }
        {
          name: 'geoPoint_metro_code_d'
          type: 'real'
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
          type: 'real'
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
          type: 'real'
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
}

output tableName string = perimeter81clTable.name
output tableId string = perimeter81clTable.id
output provisioningState string = perimeter81clTable.properties.provisioningState
