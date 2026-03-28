// Bicep template for Log Analytics custom table: CrowdStrike_Additional_Events_CL
// Generated on 2025-09-19 14:13:54 UTC
// Source: JSON schema export
// Original columns: 461, Deployed columns: 461 (Type column filtered)
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

resource crowdstrikeadditionaleventsclTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'CrowdStrike_Additional_Events_CL'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'CrowdStrike_Additional_Events_CL'
      description: 'Custom table CrowdStrike_Additional_Events_CL - imported from JSON schema'
      displayName: 'CrowdStrike_Additional_Events_CL'
      columns: [
        {
          name: 'TimeGenerated'
          type: 'dateTime'
        }
        {
          name: 'event_simpleName'
          type: 'string'
        }
        {
          name: 'QuarantinedFileName'
          type: 'string'
        }
        {
          name: 'QuarantinedFileState'
          type: 'string'
        }
        {
          name: 'CommandStdErr'
          type: 'string'
        }
        {
          name: 'CommandStdOut'
          type: 'string'
        }
        {
          name: 'CommandName'
          type: 'string'
        }
        {
          name: 'CommandSequenceNumber'
          type: 'string'
        }
        {
          name: 'CommandStartTimeStamp'
          type: 'real'
        }
        {
          name: 'CommandEndTimeStamp'
          type: 'real'
        }
        {
          name: 'CommandCode'
          type: 'string'
        }
        {
          name: 'CommandSequenceTotal'
          type: 'int'
        }
        {
          name: 'CommandCloudTimeStamp'
          type: 'real'
        }
        {
          name: 'FileSystemOperationType'
          type: 'string'
        }
        {
          name: 'AppArchitecture'
          type: 'string'
        }
        {
          name: 'AppProvider'
          type: 'string'
        }
        {
          name: 'AppSource'
          type: 'string'
        }
        {
          name: 'AppType'
          type: 'string'
        }
        {
          name: 'InstallDate'
          type: 'string'
        }
        {
          name: 'AppPath'
          type: 'string'
        }
        {
          name: 'AppProductId'
          type: 'string'
        }
        {
          name: 'AppUpdateIds'
          type: 'string'
        }
        {
          name: 'AppPathFlag'
          type: 'string'
        }
        {
          name: 'UpdateFlag'
          type: 'string'
        }
        {
          name: 'AppVersion'
          type: 'string'
        }
        {
          name: 'AppName'
          type: 'string'
        }
        {
          name: 'AppIdentificationData'
          type: 'string'
        }
        {
          name: 'FsOperationClassificationFlags'
          type: 'string'
        }
        {
          name: 'TargetSHA256HashData'
          type: 'string'
        }
        {
          name: 'TargetCommandLineParameters'
          type: 'string'
        }
        {
          name: 'DeviceProductId'
          type: 'string'
        }
        {
          name: 'CommandCount'
          type: 'long'
        }
        {
          name: 'CommandCountMax'
          type: 'long'
        }
        {
          name: 'FirstCommand'
          type: 'string'
        }
        {
          name: 'CommandHistory'
          type: 'string'
        }
        {
          name: 'ExclusionType'
          type: 'string'
        }
        {
          name: 'ImageTimeStamp'
          type: 'real'
        }
        {
          name: 'DriverLoadFlags'
          type: 'string'
        }
        {
          name: 'EtwProviders'
          type: 'string'
        }
        {
          name: 'EtwProvidersEnabled'
          type: 'string'
        }
        {
          name: 'EtwProvidersError'
          type: 'string'
        }
        {
          name: 'AgentLoadFlags'
          type: 'string'
        }
        {
          name: 'ProvisioningDuration'
          type: 'string'
        }
        {
          name: 'FileEcpBitmask'
          type: 'string'
        }
        {
          name: 'HandleCreateAuthenticationId'
          type: 'string'
        }
        {
          name: 'FileAttributes'
          type: 'string'
        }
        {
          name: 'ShareAccess'
          type: 'string'
        }
        {
          name: 'FileIdentifier'
          type: 'string'
        }
        {
          name: 'Information'
          type: 'string'
        }
        {
          name: 'Options'
          type: 'string'
        }
        {
          name: 'RegKeyChangeType'
          type: 'string'
        }
        {
          name: 'RegConfigIndex'
          type: 'string'
        }
        {
          name: 'RegConfigClass'
          type: 'string'
        }
        {
          name: 'RegConfigFlags'
          type: 'string'
        }
        {
          name: 'RegConfigValueType'
          type: 'string'
        }
        {
          name: 'MemoryDescriptionFlags'
          type: 'string'
        }
        {
          name: 'LocalPort'
          type: 'string'
        }
        {
          name: 'ConnectionFlags'
          type: 'string'
        }
        {
          name: 'ConnectionDirection'
          type: 'string'
        }
        {
          name: 'ApcContextFileName'
          type: 'string'
        }
        {
          name: 'TargetThreadId'
          type: 'string'
        }
        {
          name: 'RawTargetProcessId'
          type: 'string'
        }
        {
          name: 'UninstallPendingUpdateIds'
          type: 'string'
        }
        {
          name: 'InstalledUpdateExtendedStatus'
          type: 'string'
        }
        {
          name: 'InstalledUpdateIds'
          type: 'string'
        }
        {
          name: 'LastPendingUpdateInstalledTime'
          type: 'string'
        }
        {
          name: 'PendingUpdateIds'
          type: 'string'
        }
        {
          name: 'LastUpdateInstalledTime'
          type: 'string'
        }
        {
          name: 'SpotlightBatchType'
          type: 'string'
        }
        {
          name: 'BatchTimestamp'
          type: 'real'
        }
        {
          name: 'File'
          type: 'string'
        }
        {
          name: 'Facility'
          type: 'string'
        }
        {
          name: 'RegStringValue'
          type: 'string'
        }
        {
          name: 'RegClassification'
          type: 'string'
        }
        {
          name: 'RegOperationType'
          type: 'string'
        }
        {
          name: 'RegClassificationFlags'
          type: 'string'
        }
        {
          name: 'RegClassificationIndex'
          type: 'string'
        }
        {
          name: 'RegType'
          type: 'string'
        }
        {
          name: 'RegValueName'
          type: 'string'
        }
        {
          name: 'RegObjectName'
          type: 'string'
        }
        {
          name: 'HashAlgorithm'
          type: 'string'
        }
        {
          name: 'SignerInfoCount'
          type: 'long'
        }
        {
          name: 'SignInfoRequestFlags'
          type: 'string'
        }
        {
          name: 'ToBeSignedHash'
          type: 'string'
        }
        {
          name: 'RawTargetThreadId'
          type: 'string'
        }
        {
          name: 'BluetoothDeviceType'
          type: 'string'
        }
        {
          name: 'FirmwareAnalysisErrorLocation'
          type: 'string'
        }
        {
          name: 'FirmwareAnalysisErrorReason'
          type: 'string'
        }
        {
          name: 'ImageBaseName'
          type: 'string'
        }
        {
          name: 'TargetAuthenticationId'
          type: 'string'
        }
        {
          name: 'TargetIntegrityLevel'
          type: 'string'
        }
        {
          name: 'DriverPreventionStatusFlags'
          type: 'string'
        }
        {
          name: 'ProcessExecuteFlags'
          type: 'string'
        }
        {
          name: 'ReflectivePeTimestamp'
          type: 'real'
        }
        {
          name: 'MaxCpuUsage'
          type: 'string'
        }
        {
          name: 'AvailableDiskSpace'
          type: 'string'
        }
        {
          name: 'AverageCpuUsage'
          type: 'string'
        }
        {
          name: 'AverageUsedRam'
          type: 'string'
        }
        {
          name: 'UsedDiskSpace'
          type: 'string'
        }
        {
          name: 'MaxUsedRam'
          type: 'string'
        }
        {
          name: 'ThreadStartBytes'
          type: 'string'
        }
        {
          name: 'TargetDirectoryName'
          type: 'string'
        }
        {
          name: 'PtCompatibilityFlags'
          type: 'string'
        }
        {
          name: 'PtStatusFlags'
          type: 'string'
        }
        {
          name: 'DiskParentDeviceInstanceId'
          type: 'string'
        }
        {
          name: 'VolumeDriveLetter'
          type: 'string'
        }
        {
          name: 'VolumeMountPoint'
          type: 'string'
        }
        {
          name: 'RemediationTriggerTimeStamp'
          type: 'real'
        }
        {
          name: 'DownloadPort'
          type: 'string'
        }
        {
          name: 'DownloadPath'
          type: 'string'
        }
        {
          name: 'DownloadServer'
          type: 'string'
        }
        {
          name: 'ApcFlags'
          type: 'string'
        }
        {
          name: 'InjectedThreadFlag'
          type: 'string'
        }
        {
          name: 'FirmwareAnalysisErrorSource'
          type: 'string'
        }
        {
          name: 'ToBeSignedAlgorithm'
          type: 'string'
        }
        {
          name: 'BluetoothDeviceAddressType'
          type: 'string'
        }
        {
          name: 'BluetoothDeviceName'
          type: 'string'
        }
        {
          name: 'SignInfoFlagSignHashMismatch'
          type: 'string'
        }
        {
          name: 'SignatureDigestEncryptAlg'
          type: 'string'
        }
        {
          name: 'SubjectDN'
          type: 'string'
        }
        {
          name: 'UTCTimestamp'
          type: 'real'
        }
        {
          name: 'SignInfoFlagUnknownError'
          type: 'string'
        }
        {
          name: 'TpmType'
          type: 'string'
        }
        {
          name: 'BaseTime'
          type: 'real'
        }
        {
          name: 'TpmFirmwareVersion'
          type: 'string'
        }
        {
          name: 'ChassisType'
          type: 'string'
        }
        {
          name: 'ComputerName'
          type: 'string'
        }
        {
          name: 'AgentLocalTime'
          type: 'real'
        }
        {
          name: 'SubjectSerialNumber'
          type: 'string'
        }
        {
          name: 'SideChannelMitigationFlags'
          type: 'string'
        }
        {
          name: 'InterfaceDescriptorName'
          type: 'string'
        }
        {
          name: 'InterfaceDescriptorNumEndpoints'
          type: 'string'
        }
        {
          name: 'InterfaceDescriptorAlternateSetting'
          type: 'string'
        }
        {
          name: 'InterfaceDescriptorNumber'
          type: 'string'
        }
        {
          name: 'ConfigurationDescriptorMaxPowerDraw'
          type: 'string'
        }
        {
          name: 'ConfigurationDescriptorNumInterfaces'
          type: 'string'
        }
        {
          name: 'ConfigurationDescriptorName'
          type: 'string'
        }
        {
          name: 'ConfigurationDescriptorAttributes'
          type: 'string'
        }
        {
          name: 'ConfigurationDescriptorValue'
          type: 'string'
        }
        {
          name: 'EndpointDescriptorAttributes'
          type: 'string'
        }
        {
          name: 'EndpointDescriptorAddress'
          type: 'string'
        }
        {
          name: 'DcTypeOrLocation'
          type: 'string'
        }
        {
          name: 'IssuerDN'
          type: 'string'
        }
        {
          name: 'SubjectCN'
          type: 'string'
        }
        {
          name: 'ExternalApiType'
          type: 'string'
        }
        {
          name: 'RegBinaryValue'
          type: 'string'
        }
        {
          name: 'RegNumericValue'
          type: 'string'
        }
        {
          name: 'BillingType'
          type: 'string'
        }
        {
          name: 'ProcessId'
          type: 'string'
        }
        {
          name: 'MACAddress'
          type: 'string'
        }
        {
          name: 'NetworkAccesses'
          type: 'string'
        }
        {
          name: 'SHA256String'
          type: 'string'
        }
        {
          name: 'Severity'
          type: 'string'
        }
        {
          name: 'SeverityName'
          type: 'string'
        }
        {
          name: 'MD5String'
          type: 'string'
        }
        {
          name: 'EventUUID'
          type: 'string'
        }
        {
          name: 'FilePath'
          type: 'string'
        }
        {
          name: 'LocalIP'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'FileName'
          type: 'string'
        }
        {
          name: 'PatternDispositionFlags'
          type: 'string'
        }
        {
          name: 'DnsRequests'
          type: 'string'
        }
        {
          name: 'ProcessEndTime'
          type: 'real'
        }
        {
          name: 'ProcessStartTime'
          type: 'real'
        }
        {
          name: 'SHA1String'
          type: 'string'
        }
        {
          name: 'OriginSourceIpAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'HostnameField'
          type: 'string'
        }
        {
          name: 'StartTimestamp'
          type: 'real'
        }
        {
          name: 'event_type'
          type: 'string'
        }
        {
          name: 'product_type_desc'
          type: 'string'
        }
        {
          name: 'SignInfoFlagSelfSigned'
          type: 'string'
        }
        {
          name: 'EndpointDescriptorMaxPacketSize'
          type: 'string'
        }
        {
          name: 'EndpointDescriptorInterval'
          type: 'string'
        }
        {
          name: 'SourceAccountBadPasswordTime'
          type: 'string'
        }
        {
          name: 'SourceAccountBadPasswordCount'
          type: 'long'
        }
        {
          name: 'DeviceVersion'
          type: 'string'
        }
        {
          name: 'DcPolicyFlags'
          type: 'string'
        }
        {
          name: 'DeviceProtocol'
          type: 'string'
        }
        {
          name: 'ParentHubPort'
          type: 'string'
        }
        {
          name: 'DeviceProduct'
          type: 'string'
        }
        {
          name: 'ParentHubInstanceId'
          type: 'string'
        }
        {
          name: 'DeviceTimeStamp'
          type: 'real'
        }
        {
          name: 'AggregationLatestTimestamp'
          type: 'real'
        }
        {
          name: 'SourceAccountObjectGuid'
          type: 'string'
        }
        {
          name: 'NtlmAvFlags'
          type: 'string'
        }
        {
          name: 'TargetAccountType'
          type: 'string'
        }
        {
          name: 'SourceAccountDomain'
          type: 'string'
        }
        {
          name: 'AggregationWindowTimestamp'
          type: 'real'
        }
        {
          name: 'SourceAccountObjectSid'
          type: 'string'
        }
        {
          name: 'TargetAccountObjectSid'
          type: 'string'
        }
        {
          name: 'AggregationEarliestTimestamp'
          type: 'real'
        }
        {
          name: 'SourceAccountType'
          type: 'string'
        }
        {
          name: 'ActiveDirectoryAuthenticationMethod'
          type: 'string'
        }
        {
          name: 'SourceEndpointAccountObjectSid'
          type: 'string'
        }
        {
          name: 'SourceAccountUserPrincipal'
          type: 'string'
        }
        {
          name: 'TargetAccountObjectGuid'
          type: 'string'
        }
        {
          name: 'SourceEndpointNetworkType'
          type: 'string'
        }
        {
          name: 'AmsiRegistrationState'
          type: 'string'
        }
        {
          name: 'AmsiStatusCode'
          type: 'string'
        }
        {
          name: 'DeviceVendorId'
          type: 'string'
        }
        {
          name: 'DeviceInstanceId'
          type: 'string'
        }
        {
          name: 'BluetoothDeviceAddress'
          type: 'string'
        }
        {
          name: 'DeviceUserSid'
          type: 'string'
        }
        {
          name: 'SocketType'
          type: 'string'
        }
        {
          name: 'AuthenticationFailureMsErrorCode'
          type: 'string'
        }
        {
          name: 'AsepValueType'
          type: 'string'
        }
        {
          name: 'AsepFlags'
          type: 'string'
        }
        {
          name: 'AmsDeviceType'
          type: 'string'
        }
        {
          name: 'MemoryScanFlags'
          type: 'string'
        }
        {
          name: 'FileFormatString'
          type: 'string'
        }
        {
          name: 'HostUrl'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'ModuleCharacteristics'
          type: 'string'
        }
        {
          name: 'SessionProcessId'
          type: 'string'
        }
        {
          name: 'ObjectTypeEtw'
          type: 'string'
        }
        {
          name: 'StackLimit'
          type: 'string'
        }
        {
          name: 'LdapSecurityType'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'VnodeModificationType'
          type: 'string'
        }
        {
          name: 'AmsScanSubtypeId'
          type: 'string'
        }
        {
          name: 'AmsStatus'
          type: 'string'
        }
        {
          name: 'AmsScanTypeId'
          type: 'string'
        }
        {
          name: 'DomainName'
          type: 'string'
        }
        {
          name: 'DcSensorInterfaceType'
          type: 'string'
        }
        {
          name: 'DcPropertyIdInterfaceType'
          type: 'string'
        }
        {
          name: 'DesiredKerberosEncryptionTypes'
          type: 'string'
        }
        {
          name: 'DelegatorAccountSamAccountName'
          type: 'string'
        }
        {
          name: 'DelegatorAccountObjectGuid'
          type: 'string'
        }
        {
          name: 'DelegatorAccountObjectSid'
          type: 'string'
        }
        {
          name: 'KerberosRequestTicketValidityPeriod'
          type: 'string'
        }
        {
          name: 'SourceAccountSamAccountName'
          type: 'string'
        }
        {
          name: 'DeviceUserAuthenticationId'
          type: 'string'
        }
        {
          name: 'AuthenticodeHashData'
          type: 'string'
        }
        {
          name: 'SignatureState'
          type: 'string'
        }
        {
          name: 'SHA1HashData'
          type: 'string'
        }
        {
          name: 'ContentSHA256HashData'
          type: 'string'
        }
        {
          name: 'OriginalContentLength'
          type: 'string'
        }
        {
          name: 'RawThreadId'
          type: 'string'
        }
        {
          name: 'SourceThreadId'
          type: 'string'
        }
        {
          name: 'EtwRawThreadId'
          type: 'string'
        }
        {
          name: 'SourceProcessId'
          type: 'string'
        }
        {
          name: 'EventMax'
          type: 'string'
        }
        {
          name: 'RpcNestingLevel'
          type: 'string'
        }
        {
          name: 'RpcOpNum'
          type: 'string'
        }
        {
          name: 'RpcClientThreadId'
          type: 'string'
        }
        {
          name: 'InterfaceVersion'
          type: 'string'
        }
        {
          name: 'ScriptContentName'
          type: 'string'
        }
        {
          name: 'RpcClientProcessId'
          type: 'string'
        }
        {
          name: 'TokenType'
          type: 'string'
        }
        {
          name: 'TargetProcessId'
          type: 'string'
        }
        {
          name: 'ErrorCode'
          type: 'string'
        }
        {
          name: 'ServiceDisplayName'
          type: 'string'
        }
        {
          name: 'AntiTamperStateFlag'
          type: 'string'
        }
        {
          name: 'WmiNamespaceName'
          type: 'string'
        }
        {
          name: 'WmiQuery'
          type: 'string'
        }
        {
          name: 'SourceFileName'
          type: 'string'
        }
        {
          name: 'EventOrigin'
          type: 'string'
        }
        {
          name: 'BoundingLimitDuration'
          type: 'string'
        }
        {
          name: 'TotalCount'
          type: 'long'
        }
        {
          name: 'InterfaceGuid'
          type: 'string'
        }
        {
          name: 'OciContainerId'
          type: 'string'
        }
        {
          name: 'HostProcessType'
          type: 'string'
        }
        {
          name: 'ParentCommandLine'
          type: 'string'
        }
        {
          name: 'FileSigningTime'
          type: 'real'
        }
        {
          name: 'RegCreateDisposition'
          type: 'string'
        }
        {
          name: 'ExtendedKeyUsages'
          type: 'string'
        }
        {
          name: 'RegRootObjectName'
          type: 'string'
        }
        {
          name: 'RegKeyName'
          type: 'string'
        }
        {
          name: 'RegPostObjectName'
          type: 'string'
        }
        {
          name: 'PublicKeys'
          type: 'string'
        }
        {
          name: 'KeyObject'
          type: 'string'
        }
        {
          name: 'TaskExecArguments'
          type: 'string'
        }
        {
          name: 'TaskAuthor'
          type: 'string'
        }
        {
          name: 'TaskXml'
          type: 'string'
        }
        {
          name: 'TaskExecCommand'
          type: 'string'
        }
        {
          name: 'TaskName'
          type: 'string'
        }
        {
          name: 'ScreenshotType'
          type: 'string'
        }
        {
          name: 'OriginalFilename'
          type: 'string'
        }
        {
          name: 'ScriptContentSource'
          type: 'string'
        }
        {
          name: 'ScriptControlErrorCode'
          type: 'string'
        }
        {
          name: 'KernelTime'
          type: 'real'
        }
        {
          name: 'CallStackModuleNames'
          type: 'string'
        }
        {
          name: 'ExecutableBytes'
          type: 'string'
        }
        {
          name: 'ScriptContentBytes'
          type: 'string'
        }
        {
          name: 'SuspectStackFlag'
          type: 'string'
        }
        {
          name: 'GrandparentCommandLine'
          type: 'string'
        }
        {
          name: 'GrandparentImageFileName'
          type: 'string'
        }
        {
          name: 'ParentImageFileName'
          type: 'string'
        }
        {
          name: 'ErrorStatus'
          type: 'string'
        }
        {
          name: 'UmppaInjectionType'
          type: 'string'
        }
        {
          name: 'RawProcessId'
          type: 'string'
        }
        {
          name: 'WmiProviderType'
          type: 'string'
        }
        {
          name: 'ContextThreadId'
          type: 'string'
        }
        {
          name: 'UserCanonical'
          type: 'string'
        }
        {
          name: 'UserName'
          type: 'string'
        }
        {
          name: 'RemoteAccount'
          type: 'string'
        }
        {
          name: 'LogonDomain'
          type: 'string'
        }
        {
          name: 'LogonTime'
          type: 'real'
        }
        {
          name: 'UserIsAdmin'
          type: 'string'
        }
        {
          name: 'UserPrincipal'
          type: 'string'
        }
        {
          name: 'LogonType'
          type: 'string'
        }
        {
          name: 'TamperFilterFlags'
          type: 'string'
        }
        {
          name: 'ContextTimeStamp'
          type: 'real'
        }
        {
          name: 'SystemUptimeSeconds'
          type: 'long'
        }
        {
          name: 'cid'
          type: 'string'
        }
        {
          name: 'EffectiveTransmissionClass'
          type: 'string'
        }
        {
          name: 'CrowdStrikeId'
          type: 'string'
        }
        {
          name: 'Name'
          type: 'string'
        }
        {
          name: 'Entitlements'
          type: 'string'
        }
        {
          name: 'ConfigBuild'
          type: 'string'
        }
        {
          name: 'BoundingLimitCount'
          type: 'long'
        }
        {
          name: 'ContextProcessId'
          type: 'string'
        }
        {
          name: 'ConfigStateHash'
          type: 'string'
        }
        {
          name: 'event_platform'
          type: 'string'
        }
        {
          name: 'aid'
          type: 'string'
        }
        {
          name: 'aip'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'timestamp'
          type: 'long'
        }
        {
          name: 'UserSid'
          type: 'string'
        }
        {
          name: 'DesiredAccess'
          type: 'string'
        }
        {
          name: 'UserFlags'
          type: 'string'
        }
        {
          name: 'LogonId'
          type: 'string'
        }
        {
          name: 'EtwEventCount'
          type: 'long'
        }
        {
          name: 'CloudErrorCode'
          type: 'string'
        }
        {
          name: 'ErrorText'
          type: 'string'
        }
        {
          name: 'Status'
          type: 'string'
        }
        {
          name: 'TargetFileName'
          type: 'string'
        }
        {
          name: 'SHA256HashData'
          type: 'string'
        }
        {
          name: 'OriginalUserSid'
          type: 'string'
        }
        {
          name: 'ParentAuthenticationId'
          type: 'string'
        }
        {
          name: 'OriginalParentAuthenticationId'
          type: 'string'
        }
        {
          name: 'ImageFileName'
          type: 'string'
        }
        {
          name: 'EtwRawProcessId'
          type: 'string'
        }
        {
          name: 'WmiFilterType'
          type: 'string'
        }
        {
          name: 'WmiConsumerType'
          type: 'string'
        }
        {
          name: 'ClientComputerName'
          type: 'string'
        }
        {
          name: 'CommandLine'
          type: 'string'
        }
        {
          name: 'AuthenticationIdMac'
          type: 'string'
        }
        {
          name: 'AuthenticationUuid'
          type: 'string'
        }
        {
          name: 'UID'
          type: 'string'
        }
        {
          name: 'AuthenticationUuidAsString'
          type: 'string'
        }
        {
          name: 'LoginSessionId'
          type: 'string'
        }
        {
          name: 'UserLogonFlags'
          type: 'string'
        }
        {
          name: 'PasswordLastSet'
          type: 'string'
        }
        {
          name: 'AuthenticationId'
          type: 'string'
        }
        {
          name: 'AuthenticationPackage'
          type: 'string'
        }
        {
          name: 'SessionId'
          type: 'string'
        }
        {
          name: 'LogonServer'
          type: 'string'
        }
        {
          name: 'RegCreateOptions'
          type: 'string'
        }
        {
          name: 'SignInfoFlags'
          type: 'string'
        }
        {
          name: 'Certificate'
          type: 'string'
        }
        {
          name: 'PhysicalAddress'
          type: 'string'
        }
        {
          name: 'ConnectionType'
          type: 'string'
        }
        {
          name: 'PreferredLifetime'
          type: 'string'
        }
        {
          name: 'IpEntryFlags'
          type: 'string'
        }
        {
          name: 'AccessType'
          type: 'string'
        }
        {
          name: 'MediaType'
          type: 'string'
        }
        {
          name: 'InterfaceType'
          type: 'string'
        }
        {
          name: 'PermanentPhysicalAddress'
          type: 'string'
        }
        {
          name: 'InterfaceFlags'
          type: 'string'
        }
        {
          name: 'InterfaceIndex'
          type: 'string'
        }
        {
          name: 'InterfaceAlias'
          type: 'string'
        }
        {
          name: 'NetworkGuid'
          type: 'string'
        }
        {
          name: 'MaxReassemblySize'
          type: 'string'
        }
        {
          name: 'ValidLifetime'
          type: 'string'
        }
        {
          name: 'LocalAddressIP4'
          type: 'string'
        }
        {
          name: 'DeviceId'
          type: 'string'
        }
        {
          name: 'PrimaryModule'
          type: 'string'
        }
        {
          name: 'QuarantinedFileExtendedState'
          type: 'string'
        }
        {
          name: 'IsOnRemovableDisk'
          type: 'string'
        }
        {
          name: 'RemoteAddressIP4'
          type: 'string'
        }
        {
          name: 'VolumeEncryptionStatus'
          type: 'string'
        }
        {
          name: 'VolumeRealDeviceName'
          type: 'string'
        }
        {
          name: 'VolumeSnapshotTimeStamp'
          type: 'real'
        }
        {
          name: 'VolumeFileSystemDriver'
          type: 'string'
        }
        {
          name: 'VolumeIsEncrypted'
          type: 'string'
        }
        {
          name: 'DirectionType'
          type: 'string'
        }
        {
          name: 'VolumeSnapshotName'
          type: 'string'
        }
        {
          name: 'IfType'
          type: 'string'
        }
        {
          name: 'CreationTimeStamp'
          type: 'real'
        }
        {
          name: 'SignatureErrorState'
          type: 'string'
        }
        {
          name: 'OperationFlags'
          type: 'string'
        }
        {
          name: 'MajorFunction'
          type: 'string'
        }
        {
          name: 'IrpFlags'
          type: 'string'
        }
        {
          name: 'FileObject'
          type: 'string'
        }
        {
          name: 'MinorFunction'
          type: 'string'
        }
        {
          name: 'EtwTargetRawProcessId'
          type: 'string'
        }
        {
          name: 'ProcessCount'
          type: 'long'
        }
        {
          name: 'SuppressType'
          type: 'string'
        }
        {
          name: 'Timeout'
          type: 'string'
        }
        {
          name: 'MeasurementType'
          type: 'string'
        }
        {
          name: 'FirmwareType'
          type: 'string'
        }
        {
          name: 'ImageAnalysisRequestTimestamp'
          type: 'real'
        }
        {
          name: 'FirmwareSize'
          type: 'string'
        }
        {
          name: 'AssemblyFlags'
          type: 'string'
        }
        {
          name: 'DotnetModuleFlags'
          type: 'string'
        }
        {
          name: 'ModuleNativePath'
          type: 'string'
        }
        {
          name: 'DefaultGatewayIP6'
          type: 'string'
        }
        {
          name: 'LocalAddressIP6'
          type: 'string'
        }
        {
          name: 'TotalDiskSpace'
          type: 'int'
        }
        {
          name: 'PhysicalMediumType'
          type: 'string'
        }
        {
          name: 'NetworkInterfaceGuid'
          type: 'string'
        }
        {
          name: 'TunnelType'
          type: 'string'
        }
        {
          name: 'PhysicalAddressLength'
          type: 'string'
        }
        {
          name: 'BaseReachableTime'
          type: 'long'
        }
        {
          name: 'RetransmitTime'
          type: 'long'
        }
        {
          name: 'RpcOpClassification'
          type: 'string'
        }
        {
          name: 'VolumeFileSystemDevice'
          type: 'string'
        }
        {
          name: 'CloudRequestId'
          type: 'string'
        }
        {
          name: 'OSVersionString'
          type: 'string'
        }
        {
          name: 'OSVersionFileData'
          type: 'string'
        }
        {
          name: 'BuildNumber'
          type: 'string'
        }
        {
          name: 'CheckedBuild'
          type: 'string'
        }
        {
          name: 'MinorVersion'
          type: 'string'
        }
        {
          name: 'ProductType'
          type: 'string'
        }
        {
          name: 'MajorVersion'
          type: 'string'
        }
        {
          name: 'BuildType'
          type: 'string'
        }
        {
          name: 'PlatformId'
          type: 'string'
        }
        {
          name: 'SubBuildNumber'
          type: 'string'
        }
        {
          name: 'ProductName'
          type: 'string'
        }
        {
          name: 'PointerSize'
          type: 'string'
        }
        {
          name: 'ProductSku'
          type: 'string'
        }
        {
          name: 'FileVersion'
          type: 'string'
        }
        {
          name: 'FixedFileVersion'
          type: 'string'
        }
        {
          name: 'CompanyName'
          type: 'string'
        }
        {
          name: 'VersionInfo'
          type: 'string'
        }
        {
          name: 'OciContainersStartedCount'
          type: 'long'
        }
        {
          name: 'OciContainersStoppedCount'
          type: 'long'
        }
        {
          name: 'Size'
          type: 'string'
        }
        {
          name: 'TargetAddress'
          type: 'string'
        }
        {
          name: 'Object1Type'
          type: 'string'
        }
        {
          name: 'FileSubType'
          type: 'string'
        }
        {
          name: 'PatternHandlingErrorType'
          type: 'string'
        }
        {
          name: 'OdsActionType'
          type: 'string'
        }
        {
          name: 'OSVersionFileName'
          type: 'string'
        }
        {
          name: 'VolumeSessionUUID'
          type: 'string'
        }
        {
          name: 'IntegrityLevel'
          type: 'string'
        }
        {
          name: 'Protocol'
          type: 'string'
        }
        {
          name: 'AttemptNumber'
          type: 'string'
        }
        {
          name: 'LfoUploadFlags'
          type: 'string'
        }
        {
          name: 'PhysicalCoreCount'
          type: 'long'
        }
        {
          name: 'NamedPipeOperationType'
          type: 'string'
        }
        {
          name: 'MD5HashData'
          type: 'string'
        }
        {
          name: 'ProcessIntegrityLevel'
          type: 'string'
        }
        {
          name: 'ServiceGroup'
          type: 'string'
        }
        {
          name: 'ServiceErrorControl'
          type: 'string'
        }
        {
          name: 'ServiceFailureActions'
          type: 'string'
        }
        {
          name: 'ServiceType'
          type: 'string'
        }
        {
          name: 'ServiceStart'
          type: 'string'
        }
        {
          name: 'ServiceImagePath'
          type: 'string'
        }
        {
          name: 'ServiceSecurity'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'ServiceDescription'
          type: 'string'
        }
        {
          name: 'ServiceObjectName'
          type: 'string'
        }
        {
          name: 'TreeId'
          type: 'string'
        }
        {
          name: 'Length'
          type: 'string'
        }
        {
          name: 'VolumeFileSystemType'
          type: 'string'
        }
        {
          name: 'PatternDisposition'
          type: 'string'
        }
        {
          name: 'VolumeSectorSize'
          type: 'string'
        }
        {
          name: 'VolumeDeviceCharacteristics'
          type: 'string'
        }
        {
          name: 'ByteOffset'
          type: 'string'
        }
        {
          name: 'VolumeDeviceObjectFlags'
          type: 'string'
        }
        {
          name: 'VolumeName'
          type: 'string'
        }
        {
          name: 'VolumeDeviceType'
          type: 'string'
        }
        {
          name: 'RemotePort'
          type: 'string'
        }
        {
          name: 'AdditionalFields'
          type: 'dynamic'
        }
      ]
    }
  }
}

output tableName string = crowdstrikeadditionaleventsclTable.name
output tableId string = crowdstrikeadditionaleventsclTable.id
output provisioningState string = crowdstrikeadditionaleventsclTable.properties.provisioningState
