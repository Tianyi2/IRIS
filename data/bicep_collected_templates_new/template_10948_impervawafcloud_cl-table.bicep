// Bicep template for Log Analytics custom table: ImpervaWAFCloud_CL
// Generated on 2025-09-19 14:13:55 UTC
// Source: JSON schema export
// Original columns: 38, Deployed columns: 38 (Type column filtered)
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

resource impervawafcloudclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'ImpervaWAFCloud_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'ImpervaWAFCloud_CL'
      description: 'Custom table ImpervaWAFCloud_CL - imported from JSON schema'
      displayName: 'ImpervaWAFCloud_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'EventVendor_s'
          type: 'string'
        }
        {
          name: 'requestMethod_s'
          type: 'string'
        }
        {
          name: 'sip_s'
          type: 'string'
        }
        {
          name: 'siteid_s'
          type: 'string'
        }
        {
          name: 'sourceServiceName_s'
          type: 'string'
        }
        {
          name: 'spt_s'
          type: 'string'
        }
        {
          name: 'src_s'
          type: 'string'
        }
        {
          name: 'start_s'
          type: 'string'
        }
        {
          name: 'suid_s'
          type: 'string'
        }
        {
          name: 'ver_s'
          type: 'string'
        }
        {
          name: 'xff_s'
          type: 'string'
        }
        {
          name: 'CapSupport_s'
          type: 'string'
        }
        {
          name: 'clapp_s'
          type: 'string'
        }
        {
          name: 'clappsig_s'
          type: 'string'
        }
        {
          name: 'COSupport_s'
          type: 'string'
        }
        {
          name: 'latitude_s'
          type: 'string'
        }
        {
          name: 'requestClientApplication_s'
          type: 'string'
        }
        {
          name: 'longitude_s'
          type: 'string'
        }
        {
          name: 'request_s'
          type: 'string'
        }
        {
          name: 'postbody_s'
          type: 'string'
        }
        {
          name: 'EventProduct_s'
          type: 'string'
        }
        {
          name: 'EventType_s'
          type: 'string'
        }
        {
          name: 'severity_s'
          type: 'string'
        }
        {
          name: 'act_s'
          type: 'string'
        }
        {
          name: 'app_s'
          type: 'string'
        }
        {
          name: 'ccode_s'
          type: 'string'
        }
        {
          name: 'cicode_s'
          type: 'string'
        }
        {
          name: 'cn1_s'
          type: 'string'
        }
        {
          name: 'cpt_s'
          type: 'string'
        }
        {
          name: 'Customer_s'
          type: 'string'
        }
        {
          name: 'deviceExternalId_s'
          type: 'string'
        }
        {
          name: 'deviceFacility_s'
          type: 'string'
        }
        {
          name: 'dproc_s'
          type: 'string'
        }
        {
          name: 'end_s'
          type: 'string'
        }
        {
          name: 'fileId_s'
          type: 'string'
        }
        {
          name: 'qstr_s'
          type: 'string'
        }
        {
          name: 'VID_g'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = impervawafcloudclTable.name
output tableId string = impervawafcloudclTable.id
output provisioningState string = impervawafcloudclTable.properties.provisioningState
