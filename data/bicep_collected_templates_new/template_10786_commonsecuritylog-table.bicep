// Bicep template for Log Analytics custom table: CommonSecurityLog
// Generated on 2025-09-19 14:13:51 UTC
// Source: JSON schema export
// Original columns: 159, Deployed columns: 158 (Type column filtered)
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

resource commonsecuritylogTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CommonSecurityLog'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CommonSecurityLog'
      description: 'Custom table CommonSecurityLog - imported from JSON schema'
      displayName: 'CommonSecurityLog'
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
          name: 'DeviceCustomFloatingPoint1Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomFloatingPoint2'
          type: 'real'
        }
        {
          name: 'DeviceCustomFloatingPoint2Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomFloatingPoint3'
          type: 'real'
        }
        {
          name: 'DeviceCustomFloatingPoint3Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomFloatingPoint4'
          type: 'real'
        }
        {
          name: 'DeviceCustomFloatingPoint4Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomNumber1'
          type: 'int'
        }
        {
          name: 'FieldDeviceCustomNumber1'
          type: 'long'
        }
        {
          name: 'DeviceCustomNumber1Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomNumber2'
          type: 'int'
        }
        {
          name: 'FieldDeviceCustomNumber2'
          type: 'long'
        }
        {
          name: 'DeviceCustomNumber2Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomNumber3'
          type: 'int'
        }
        {
          name: 'FieldDeviceCustomNumber3'
          type: 'long'
        }
        {
          name: 'DeviceCustomFloatingPoint1'
          type: 'real'
        }
        {
          name: 'DeviceCustomIPv6Address4Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomIPv6Address4'
          type: 'string'
        }
        {
          name: 'DeviceCustomIPv6Address3Label'
          type: 'string'
        }
        {
          name: 'SourceTranslatedPort'
          type: 'int'
        }
        {
          name: 'SourceProcessId'
          type: 'int'
        }
        {
          name: 'SourceUserPrivileges'
          type: 'string'
        }
        {
          name: 'SourceProcessName'
          type: 'string'
        }
        {
          name: 'SourcePort'
          type: 'int'
        }
        {
          name: 'SourceIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'StartTime'
          type: 'dateTime'
        }
        {
          name: 'DeviceCustomNumber3Label'
          type: 'string'
        }
        {
          name: 'SourceUserID'
          type: 'string'
        }
        {
          name: 'EventType'
          type: 'int'
        }
        {
          name: 'DeviceEventCategory'
          type: 'string'
        }
        {
          name: 'DeviceCustomIPv6Address1'
          type: 'string'
        }
        {
          name: 'DeviceCustomIPv6Address1Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomIPv6Address2'
          type: 'string'
        }
        {
          name: 'DeviceCustomIPv6Address2Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomIPv6Address3'
          type: 'string'
        }
        {
          name: 'SourceUserName'
          type: 'string'
        }
        {
          name: 'DeviceCustomString1'
          type: 'string'
        }
        {
          name: 'DeviceCustomString1Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomString2'
          type: 'string'
        }
        {
          name: 'FlexString1Label'
          type: 'string'
        }
        {
          name: 'FlexString2'
          type: 'string'
        }
        {
          name: 'FlexString2Label'
          type: 'string'
        }
        {
          name: 'RemoteIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'RemotePort'
          type: 'string'
        }
        {
          name: 'MaliciousIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ThreatSeverity'
          type: 'int'
        }
        {
          name: 'FlexString1'
          type: 'string'
        }
        {
          name: 'IndicatorThreatType'
          type: 'string'
        }
        {
          name: 'ThreatConfidence'
          type: 'string'
        }
        {
          name: 'ReportReferenceLink'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'MaliciousIPLongitude'
          type: 'real'
        }
        {
          name: 'MaliciousIPLatitude'
          type: 'real'
        }
        {
          name: 'MaliciousIPCountry'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'ThreatDescription'
          type: 'string'
        }
        {
          name: 'SourceTranslatedAddress'
          type: 'string'
        }
        {
          name: 'FlexNumber2Label'
          type: 'string'
        }
        {
          name: 'FlexNumber1Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomString2Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomString3'
          type: 'string'
        }
        {
          name: 'DeviceCustomString3Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomString4'
          type: 'string'
        }
        {
          name: 'DeviceCustomString4Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomString5'
          type: 'string'
        }
        {
          name: 'DeviceCustomString5Label'
          type: 'string'
        }
        {
          name: 'FlexNumber2'
          type: 'int'
        }
        {
          name: 'DeviceCustomString6'
          type: 'string'
        }
        {
          name: 'DeviceCustomDate1'
          type: 'string'
        }
        {
          name: 'DeviceCustomDate1Label'
          type: 'string'
        }
        {
          name: 'DeviceCustomDate2'
          type: 'string'
        }
        {
          name: 'DeviceCustomDate2Label'
          type: 'string'
        }
        {
          name: 'FlexDate1'
          type: 'string'
        }
        {
          name: 'FlexDate1Label'
          type: 'string'
        }
        {
          name: 'FlexNumber1'
          type: 'int'
        }
        {
          name: 'DeviceCustomString6Label'
          type: 'string'
        }
        {
          name: 'SimplifiedDeviceAction'
          type: 'string'
        }
        {
          name: 'SourceServiceName'
          type: 'string'
        }
        {
          name: 'SourceNTDomain'
          type: 'string'
        }
        {
          name: 'DeviceNtDomain'
          type: 'string'
        }
        {
          name: 'DeviceOutboundInterface'
          type: 'string'
        }
        {
          name: 'DevicePayloadId'
          type: 'string'
        }
        {
          name: 'ProcessName'
          type: 'string'
        }
        {
          name: 'DeviceTranslatedAddress'
          type: 'string'
        }
        {
          name: 'DestinationHostName'
          type: 'string'
        }
        {
          name: 'DestinationMACAddress'
          type: 'string'
        }
        {
          name: 'DestinationNTDomain'
          type: 'string'
        }
        {
          name: 'DestinationProcessId'
          type: 'int'
        }
        {
          name: 'DestinationUserPrivileges'
          type: 'string'
        }
        {
          name: 'DestinationProcessName'
          type: 'string'
        }
        {
          name: 'DestinationPort'
          type: 'int'
        }
        {
          name: 'DestinationIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'DeviceTimeZone'
          type: 'string'
        }
        {
          name: 'DestinationUserID'
          type: 'string'
        }
        {
          name: 'DeviceInboundInterface'
          type: 'string'
        }
        {
          name: 'DeviceFacility'
          type: 'string'
        }
        {
          name: 'DeviceExternalID'
          type: 'string'
        }
        {
          name: 'DeviceDnsDomain'
          type: 'string'
        }
        {
          name: 'DeviceVendor'
          type: 'string'
        }
        {
          name: 'DeviceProduct'
          type: 'string'
        }
        {
          name: 'DeviceVersion'
          type: 'string'
        }
        {
          name: 'DeviceEventClassID'
          type: 'string'
        }
        {
          name: 'Activity'
          type: 'string'
        }
        {
          name: 'LogSeverity'
          type: 'string'
        }
        {
          name: 'OriginalLogSeverity'
          type: 'string'
        }
        {
          name: 'DestinationUserName'
          type: 'string'
        }
        {
          name: 'AdditionalExtensions'
          type: 'string'
        }
        {
          name: 'ApplicationProtocol'
          type: 'string'
        }
        {
          name: 'EventCount'
          type: 'int'
        }
        {
          name: 'DestinationDnsDomain'
          type: 'string'
        }
        {
          name: 'DestinationServiceName'
          type: 'string'
        }
        {
          name: 'DestinationTranslatedAddress'
          type: 'string'
        }
        {
          name: 'DestinationTranslatedPort'
          type: 'int'
        }
        {
          name: 'CommunicationDirection'
          type: 'string'
        }
        {
          name: 'DeviceAction'
          type: 'string'
        }
        {
          name: 'DeviceAddress'
          type: 'string'
        }
        {
          name: 'DeviceName'
          type: 'string'
        }
        {
          name: 'DeviceMacAddress'
          type: 'string'
        }
        {
          name: 'OldFilePath'
          type: 'string'
        }
        {
          name: 'OldFilePermission'
          type: 'string'
        }
        {
          name: 'OldFileSize'
          type: 'int'
        }
        {
          name: 'OldFileType'
          type: 'string'
        }
        {
          name: 'SentBytes'
          type: 'long'
        }
        {
          name: 'EventOutcome'
          type: 'string'
        }
        {
          name: 'Protocol'
          type: 'string'
        }
        {
          name: 'OldFileName'
          type: 'string'
        }
        {
          name: 'Reason'
          type: 'string'
        }
        {
          name: 'RequestClientApplication'
          type: 'string'
        }
        {
          name: 'RequestContext'
          type: 'string'
        }
        {
          name: 'RequestCookies'
          type: 'string'
        }
        {
          name: 'RequestMethod'
          type: 'string'
        }
        {
          name: 'ReceiptTime'
          type: 'string'
        }
        {
          name: 'SourceHostName'
          type: 'string'
        }
        {
          name: 'SourceMACAddress'
          type: 'string'
        }
        {
          name: 'RequestURL'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'SourceDnsDomain'
          type: 'string'
        }
        {
          name: 'OldFileModificationTime'
          type: 'string'
        }
        {
          name: 'OldFileHash'
          type: 'string'
        }
        {
          name: 'ProcessID'
          type: 'int'
        }
        {
          name: 'EndTime'
          type: 'dateTime'
        }
        {
          name: 'ExternalID'
          type: 'int'
        }
        {
          name: 'ExtID'
          type: 'string'
        }
        {
          name: 'FileCreateTime'
          type: 'string'
        }
        {
          name: 'FileHash'
          type: 'string'
        }
        {
          name: 'FileID'
          type: 'string'
        }
        {
          name: 'OldFileID'
          type: 'string'
        }
        {
          name: 'FileModificationTime'
          type: 'string'
        }
        {
          name: 'FilePermission'
          type: 'string'
        }
        {
          name: 'FileType'
          type: 'string'
        }
        {
          name: 'FileName'
          type: 'string'
        }
        {
          name: 'FileSize'
          type: 'int'
        }
        {
          name: 'ReceivedBytes'
          type: 'long'
        }
        {
          name: 'Message'
          type: 'string'
        }
        {
          name: 'OldFileCreateTime'
          type: 'string'
        }
        {
          name: 'FilePath'
          type: 'string'
        }
        {
          name: 'CollectorHostName'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = commonsecuritylogTable.name
output tableId string = commonsecuritylogTable.id
output provisioningState string = commonsecuritylogTable.properties.provisioningState
