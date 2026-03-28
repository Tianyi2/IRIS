// Bicep template for Log Analytics custom table: Corelight_v2_ssh_CL
// Generated on 2025-09-19 14:13:53 UTC
// Source: JSON schema export
// Original columns: 33, Deployed columns: 30 (Type column filtered)
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

resource corelightv2sshclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'Corelight_v2_ssh_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'Corelight_v2_ssh_CL'
      description: 'Custom table Corelight_v2_ssh_CL - imported from JSON schema'
      displayName: 'Corelight_v2_ssh_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'ts_t'
          type: 'dateTime'
        }
        {
          name: 'sshka_s'
          type: 'string'
        }
        {
          name: 'hasshAlgorithms_s'
          type: 'string'
        }
        {
          name: 'cshka_s'
          type: 'string'
        }
        {
          name: 'hasshVersion_s'
          type: 'string'
        }
        {
          name: 'remote_location_longitude_d'
          type: 'real'
        }
        {
          name: 'remote_location_latitude_d'
          type: 'real'
        }
        {
          name: 'remote_location_city_s'
          type: 'string'
        }
        {
          name: 'remote_location_region_s'
          type: 'string'
        }
        {
          name: 'remote_location_country_code_s'
          type: 'string'
        }
        {
          name: 'host_key_s'
          type: 'string'
        }
        {
          name: 'host_key_alg_s'
          type: 'string'
        }
        {
          name: 'kex_alg_s'
          type: 'string'
        }
        {
          name: 'hasshServerAlgorithms_s'
          type: 'string'
        }
        {
          name: 'compression_alg_s'
          type: 'string'
        }
        {
          name: 'cipher_alg_s'
          type: 'string'
        }
        {
          name: 'server_s'
          type: 'string'
        }
        {
          name: 'client_s'
          type: 'string'
        }
        {
          name: 'direction_s'
          type: 'string'
        }
        {
          name: 'auth_attempts_d'
          type: 'real'
        }
        {
          name: 'auth_success_b'
          type: 'boolean'
        }
        {
          name: 'version_d'
          type: 'real'
        }
        {
          name: 'id_resp_p_d'
          type: 'real'
        }
        {
          name: 'id_resp_h_s'
          type: 'string'
        }
        {
          name: 'id_orig_p_d'
          type: 'real'
        }
        {
          name: 'id_orig_h_s'
          type: 'string'
        }
        {
          name: 'uid_s'
          type: 'string'
        }
        {
          name: 'mac_alg_s'
          type: 'string'
        }
        {
          name: 'inferences_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = corelightv2sshclTable.name
output tableId string = corelightv2sshclTable.id
output provisioningState string = corelightv2sshclTable.properties.provisioningState
