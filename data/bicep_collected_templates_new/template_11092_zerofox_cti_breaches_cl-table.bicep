// Bicep template for Log Analytics custom table: ZeroFox_CTI_breaches_CL
// Generated on 2025-09-19 14:13:59 UTC
// Source: JSON schema export
// Original columns: 20, Deployed columns: 20 (Type column filtered)
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

resource zerofoxctibreachesclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ZeroFox_CTI_breaches_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ZeroFox_CTI_breaches_CL'
      description: 'Custom table ZeroFox_CTI_breaches_CL - imported from JSON schema'
      displayName: 'ZeroFox_CTI_breaches_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'id_s'
          type: 'real'
        }
        {
          name: 'reliability_s'
          type: 'string'
        }
        {
          name: 'confidence_s'
          type: 'string'
        }
        {
          name: 'geography_country_s'
          type: 'string'
        }
        {
          name: 'geography_sub_region_s'
          type: 'string'
        }
        {
          name: 'geography_region_s'
          type: 'string'
        }
        {
          name: 'geography_country_iso_alpha3_code_s'
          type: 'string'
        }
        {
          name: 'geography_country_code_s'
          type: 'string'
        }
        {
          name: 'tlp_s'
          type: 'string'
        }
        {
          name: 'geography_sub_region_code_s'
          type: 'string'
        }
        {
          name: 'threat_type_s'
          type: 'string'
        }
        {
          name: 'record_count_d'
          type: 'real'
        }
        {
          name: 'included_fields_s'
          type: 'string'
        }
        {
          name: 'created_at_t'
          type: 'dateTime'
        }
        {
          name: 'breach_date_t'
          type: 'dateTime'
        }
        {
          name: 'description_s'
          type: 'string'
        }
        {
          name: 'name_s'
          type: 'string'
        }
        {
          name: 'geography_region_code_s'
          type: 'string'
        }
        {
          name: 'industry_s'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = zerofoxctibreachesclTable.name
output tableId string = zerofoxctibreachesclTable.id
output provisioningState string = zerofoxctibreachesclTable.properties.provisioningState
