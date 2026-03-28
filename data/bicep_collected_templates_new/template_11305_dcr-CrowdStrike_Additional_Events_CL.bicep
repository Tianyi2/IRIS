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
// Data Collection Rule for CrowdStrike_Additional_Events_CL
// ============================================================================
// Generated: 2025-09-19 14:20:15
// Table type: Custom (presumed custom for JSON exports)
// Schema imported from JSON export file
// Underscore columns filtered out
// Original columns: 461, DCR columns: 461 (Type column always filtered)
// Output stream: Custom-CrowdStrike_Additional_Events_CL
// Note: Input stream uses string/dynamic only. Type conversions in transform.
// ============================================================================

var roleDefinitionResourceId = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '3913510d-42f4-4e42-8a64-420c390055eb')

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'dcr-${workspaceName}-CrowdStrike_Additional_Events_CL'
  location: location
  properties: {
    dataCollectionEndpointId: dataCollectionEndpointId
    streamDeclarations: {
      'Custom-CrowdStrike_Additional_Events_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'CommandEndTimeStamp'
            type: 'string'
          }
          {
            name: 'CommandCode'
            type: 'string'
          }
          {
            name: 'CommandSequenceTotal'
            type: 'string'
          }
          {
            name: 'CommandCloudTimeStamp'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'CommandCountMax'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'ProcessStartTime'
            type: 'string'
          }
          {
            name: 'SHA1String'
            type: 'string'
          }
          {
            name: 'OriginSourceIpAddress'
            type: 'string'
          }
          {
            name: 'HostnameField'
            type: 'string'
          }
          {
            name: 'StartTimestamp'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'AggregationLatestTimestamp'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'SystemUptimeSeconds'
            type: 'string'
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
            type: 'string'
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
          }
          {
            name: 'timestamp'
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'RetransmitTime'
            type: 'string'
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
            type: 'string'
          }
          {
            name: 'OciContainersStoppedCount'
            type: 'string'
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
            type: 'string'
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
    dataSources: {}
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: workspaceResourceId
          name: 'Sentinel-CrowdStrike_Additional_Events_CL'
        }
      ]
    }
    dataFlows: [
      {
        streams: ['Custom-CrowdStrike_Additional_Events_CL']
        destinations: ['Sentinel-CrowdStrike_Additional_Events_CL']
        transformKql: 'source | project TimeGenerated = todatetime(TimeGenerated), event_simpleName = tostring(event_simpleName), QuarantinedFileName = tostring(QuarantinedFileName), QuarantinedFileState = tostring(QuarantinedFileState), CommandStdErr = tostring(CommandStdErr), CommandStdOut = tostring(CommandStdOut), CommandName = tostring(CommandName), CommandSequenceNumber = tostring(CommandSequenceNumber), CommandStartTimeStamp = toreal(CommandStartTimeStamp), CommandEndTimeStamp = toreal(CommandEndTimeStamp), CommandCode = tostring(CommandCode), CommandSequenceTotal = toint(CommandSequenceTotal), CommandCloudTimeStamp = toreal(CommandCloudTimeStamp), FileSystemOperationType = tostring(FileSystemOperationType), AppArchitecture = tostring(AppArchitecture), AppProvider = tostring(AppProvider), AppSource = tostring(AppSource), AppType = tostring(AppType), InstallDate = tostring(InstallDate), AppPath = tostring(AppPath), AppProductId = tostring(AppProductId), AppUpdateIds = tostring(AppUpdateIds), AppPathFlag = tostring(AppPathFlag), UpdateFlag = tostring(UpdateFlag), AppVersion = tostring(AppVersion), AppName = tostring(AppName), AppIdentificationData = tostring(AppIdentificationData), FsOperationClassificationFlags = tostring(FsOperationClassificationFlags), TargetSHA256HashData = tostring(TargetSHA256HashData), TargetCommandLineParameters = tostring(TargetCommandLineParameters), DeviceProductId = tostring(DeviceProductId), CommandCount = tolong(CommandCount), CommandCountMax = tolong(CommandCountMax), FirstCommand = tostring(FirstCommand), CommandHistory = tostring(CommandHistory), ExclusionType = tostring(ExclusionType), ImageTimeStamp = toreal(ImageTimeStamp), DriverLoadFlags = tostring(DriverLoadFlags), EtwProviders = tostring(EtwProviders), EtwProvidersEnabled = tostring(EtwProvidersEnabled), EtwProvidersError = tostring(EtwProvidersError), AgentLoadFlags = tostring(AgentLoadFlags), ProvisioningDuration = tostring(ProvisioningDuration), FileEcpBitmask = tostring(FileEcpBitmask), HandleCreateAuthenticationId = tostring(HandleCreateAuthenticationId), FileAttributes = tostring(FileAttributes), ShareAccess = tostring(ShareAccess), FileIdentifier = tostring(FileIdentifier), Information = tostring(Information), Options = tostring(Options), RegKeyChangeType = tostring(RegKeyChangeType), RegConfigIndex = tostring(RegConfigIndex), RegConfigClass = tostring(RegConfigClass), RegConfigFlags = tostring(RegConfigFlags), RegConfigValueType = tostring(RegConfigValueType), MemoryDescriptionFlags = tostring(MemoryDescriptionFlags), LocalPort = tostring(LocalPort), ConnectionFlags = tostring(ConnectionFlags), ConnectionDirection = tostring(ConnectionDirection), ApcContextFileName = tostring(ApcContextFileName), TargetThreadId = tostring(TargetThreadId), RawTargetProcessId = tostring(RawTargetProcessId), UninstallPendingUpdateIds = tostring(UninstallPendingUpdateIds), InstalledUpdateExtendedStatus = tostring(InstalledUpdateExtendedStatus), InstalledUpdateIds = tostring(InstalledUpdateIds), LastPendingUpdateInstalledTime = tostring(LastPendingUpdateInstalledTime), PendingUpdateIds = tostring(PendingUpdateIds), LastUpdateInstalledTime = tostring(LastUpdateInstalledTime), SpotlightBatchType = tostring(SpotlightBatchType), BatchTimestamp = toreal(BatchTimestamp), File = tostring(File), Facility = tostring(Facility), RegStringValue = tostring(RegStringValue), RegClassification = tostring(RegClassification), RegOperationType = tostring(RegOperationType), RegClassificationFlags = tostring(RegClassificationFlags), RegClassificationIndex = tostring(RegClassificationIndex), RegType = tostring(RegType), RegValueName = tostring(RegValueName), RegObjectName = tostring(RegObjectName), HashAlgorithm = tostring(HashAlgorithm), SignerInfoCount = tolong(SignerInfoCount), SignInfoRequestFlags = tostring(SignInfoRequestFlags), ToBeSignedHash = tostring(ToBeSignedHash), RawTargetThreadId = tostring(RawTargetThreadId), BluetoothDeviceType = tostring(BluetoothDeviceType), FirmwareAnalysisErrorLocation = tostring(FirmwareAnalysisErrorLocation), FirmwareAnalysisErrorReason = tostring(FirmwareAnalysisErrorReason), ImageBaseName = tostring(ImageBaseName), TargetAuthenticationId = tostring(TargetAuthenticationId), TargetIntegrityLevel = tostring(TargetIntegrityLevel), DriverPreventionStatusFlags = tostring(DriverPreventionStatusFlags), ProcessExecuteFlags = tostring(ProcessExecuteFlags), ReflectivePeTimestamp = toreal(ReflectivePeTimestamp), MaxCpuUsage = tostring(MaxCpuUsage), AvailableDiskSpace = tostring(AvailableDiskSpace), AverageCpuUsage = tostring(AverageCpuUsage), AverageUsedRam = tostring(AverageUsedRam), UsedDiskSpace = tostring(UsedDiskSpace), MaxUsedRam = tostring(MaxUsedRam), ThreadStartBytes = tostring(ThreadStartBytes), TargetDirectoryName = tostring(TargetDirectoryName), PtCompatibilityFlags = tostring(PtCompatibilityFlags), PtStatusFlags = tostring(PtStatusFlags), DiskParentDeviceInstanceId = tostring(DiskParentDeviceInstanceId), VolumeDriveLetter = tostring(VolumeDriveLetter), VolumeMountPoint = tostring(VolumeMountPoint), RemediationTriggerTimeStamp = toreal(RemediationTriggerTimeStamp), DownloadPort = tostring(DownloadPort), DownloadPath = tostring(DownloadPath), DownloadServer = tostring(DownloadServer), ApcFlags = tostring(ApcFlags), InjectedThreadFlag = tostring(InjectedThreadFlag), FirmwareAnalysisErrorSource = tostring(FirmwareAnalysisErrorSource), ToBeSignedAlgorithm = tostring(ToBeSignedAlgorithm), BluetoothDeviceAddressType = tostring(BluetoothDeviceAddressType), BluetoothDeviceName = tostring(BluetoothDeviceName), SignInfoFlagSignHashMismatch = tostring(SignInfoFlagSignHashMismatch), SignatureDigestEncryptAlg = tostring(SignatureDigestEncryptAlg), SubjectDN = tostring(SubjectDN), UTCTimestamp = toreal(UTCTimestamp), SignInfoFlagUnknownError = tostring(SignInfoFlagUnknownError), TpmType = tostring(TpmType), BaseTime = toreal(BaseTime), TpmFirmwareVersion = tostring(TpmFirmwareVersion), ChassisType = tostring(ChassisType), ComputerName = tostring(ComputerName), AgentLocalTime = toreal(AgentLocalTime), SubjectSerialNumber = tostring(SubjectSerialNumber), SideChannelMitigationFlags = tostring(SideChannelMitigationFlags), InterfaceDescriptorName = tostring(InterfaceDescriptorName), InterfaceDescriptorNumEndpoints = tostring(InterfaceDescriptorNumEndpoints), InterfaceDescriptorAlternateSetting = tostring(InterfaceDescriptorAlternateSetting), InterfaceDescriptorNumber = tostring(InterfaceDescriptorNumber), ConfigurationDescriptorMaxPowerDraw = tostring(ConfigurationDescriptorMaxPowerDraw), ConfigurationDescriptorNumInterfaces = tostring(ConfigurationDescriptorNumInterfaces), ConfigurationDescriptorName = tostring(ConfigurationDescriptorName), ConfigurationDescriptorAttributes = tostring(ConfigurationDescriptorAttributes), ConfigurationDescriptorValue = tostring(ConfigurationDescriptorValue), EndpointDescriptorAttributes = tostring(EndpointDescriptorAttributes), EndpointDescriptorAddress = tostring(EndpointDescriptorAddress), DcTypeOrLocation = tostring(DcTypeOrLocation), IssuerDN = tostring(IssuerDN), SubjectCN = tostring(SubjectCN), ExternalApiType = tostring(ExternalApiType), RegBinaryValue = tostring(RegBinaryValue), RegNumericValue = tostring(RegNumericValue), BillingType = tostring(BillingType), ProcessId = tostring(ProcessId), MACAddress = tostring(MACAddress), NetworkAccesses = tostring(NetworkAccesses), SHA256String = tostring(SHA256String), Severity = tostring(Severity), SeverityName = tostring(SeverityName), MD5String = tostring(MD5String), EventUUID = tostring(EventUUID), FilePath = tostring(FilePath), LocalIP = tostring(LocalIP), FileName = tostring(FileName), PatternDispositionFlags = tostring(PatternDispositionFlags), DnsRequests = tostring(DnsRequests), ProcessEndTime = toreal(ProcessEndTime), ProcessStartTime = toreal(ProcessStartTime), SHA1String = tostring(SHA1String), OriginSourceIpAddress = tostring(OriginSourceIpAddress), HostnameField = tostring(HostnameField), StartTimestamp = toreal(StartTimestamp), event_type = tostring(event_type), product_type_desc = tostring(product_type_desc), SignInfoFlagSelfSigned = tostring(SignInfoFlagSelfSigned), EndpointDescriptorMaxPacketSize = tostring(EndpointDescriptorMaxPacketSize), EndpointDescriptorInterval = tostring(EndpointDescriptorInterval), SourceAccountBadPasswordTime = tostring(SourceAccountBadPasswordTime), SourceAccountBadPasswordCount = tolong(SourceAccountBadPasswordCount), DeviceVersion = tostring(DeviceVersion), DcPolicyFlags = tostring(DcPolicyFlags), DeviceProtocol = tostring(DeviceProtocol), ParentHubPort = tostring(ParentHubPort), DeviceProduct = tostring(DeviceProduct), ParentHubInstanceId = tostring(ParentHubInstanceId), DeviceTimeStamp = toreal(DeviceTimeStamp), AggregationLatestTimestamp = toreal(AggregationLatestTimestamp), SourceAccountObjectGuid = tostring(SourceAccountObjectGuid), NtlmAvFlags = tostring(NtlmAvFlags), TargetAccountType = tostring(TargetAccountType), SourceAccountDomain = tostring(SourceAccountDomain), AggregationWindowTimestamp = toreal(AggregationWindowTimestamp), SourceAccountObjectSid = tostring(SourceAccountObjectSid), TargetAccountObjectSid = tostring(TargetAccountObjectSid), AggregationEarliestTimestamp = toreal(AggregationEarliestTimestamp), SourceAccountType = tostring(SourceAccountType), ActiveDirectoryAuthenticationMethod = tostring(ActiveDirectoryAuthenticationMethod), SourceEndpointAccountObjectSid = tostring(SourceEndpointAccountObjectSid), SourceAccountUserPrincipal = tostring(SourceAccountUserPrincipal), TargetAccountObjectGuid = tostring(TargetAccountObjectGuid), SourceEndpointNetworkType = tostring(SourceEndpointNetworkType), AmsiRegistrationState = tostring(AmsiRegistrationState), AmsiStatusCode = tostring(AmsiStatusCode), DeviceVendorId = tostring(DeviceVendorId), DeviceInstanceId = tostring(DeviceInstanceId), BluetoothDeviceAddress = tostring(BluetoothDeviceAddress), DeviceUserSid = tostring(DeviceUserSid), SocketType = tostring(SocketType), AuthenticationFailureMsErrorCode = tostring(AuthenticationFailureMsErrorCode), AsepValueType = tostring(AsepValueType), AsepFlags = tostring(AsepFlags), AmsDeviceType = tostring(AmsDeviceType), MemoryScanFlags = tostring(MemoryScanFlags), FileFormatString = tostring(FileFormatString), HostUrl = tostring(HostUrl), ModuleCharacteristics = tostring(ModuleCharacteristics), SessionProcessId = tostring(SessionProcessId), ObjectTypeEtw = tostring(ObjectTypeEtw), StackLimit = tostring(StackLimit), LdapSecurityType = tostring(LdapSecurityType), VnodeModificationType = tostring(VnodeModificationType), AmsScanSubtypeId = tostring(AmsScanSubtypeId), AmsStatus = tostring(AmsStatus), AmsScanTypeId = tostring(AmsScanTypeId), DomainName = tostring(DomainName), DcSensorInterfaceType = tostring(DcSensorInterfaceType), DcPropertyIdInterfaceType = tostring(DcPropertyIdInterfaceType), DesiredKerberosEncryptionTypes = tostring(DesiredKerberosEncryptionTypes), DelegatorAccountSamAccountName = tostring(DelegatorAccountSamAccountName), DelegatorAccountObjectGuid = tostring(DelegatorAccountObjectGuid), DelegatorAccountObjectSid = tostring(DelegatorAccountObjectSid), KerberosRequestTicketValidityPeriod = tostring(KerberosRequestTicketValidityPeriod), SourceAccountSamAccountName = tostring(SourceAccountSamAccountName), DeviceUserAuthenticationId = tostring(DeviceUserAuthenticationId), AuthenticodeHashData = tostring(AuthenticodeHashData), SignatureState = tostring(SignatureState), SHA1HashData = tostring(SHA1HashData), ContentSHA256HashData = tostring(ContentSHA256HashData), OriginalContentLength = tostring(OriginalContentLength), RawThreadId = tostring(RawThreadId), SourceThreadId = tostring(SourceThreadId), EtwRawThreadId = tostring(EtwRawThreadId), SourceProcessId = tostring(SourceProcessId), EventMax = tostring(EventMax), RpcNestingLevel = tostring(RpcNestingLevel), RpcOpNum = tostring(RpcOpNum), RpcClientThreadId = tostring(RpcClientThreadId), InterfaceVersion = tostring(InterfaceVersion), ScriptContentName = tostring(ScriptContentName), RpcClientProcessId = tostring(RpcClientProcessId), TokenType = tostring(TokenType), TargetProcessId = tostring(TargetProcessId), ErrorCode = tostring(ErrorCode), ServiceDisplayName = tostring(ServiceDisplayName), AntiTamperStateFlag = tostring(AntiTamperStateFlag), WmiNamespaceName = tostring(WmiNamespaceName), WmiQuery = tostring(WmiQuery), SourceFileName = tostring(SourceFileName), EventOrigin = tostring(EventOrigin), BoundingLimitDuration = tostring(BoundingLimitDuration), TotalCount = tolong(TotalCount), InterfaceGuid = tostring(InterfaceGuid), OciContainerId = tostring(OciContainerId), HostProcessType = tostring(HostProcessType), ParentCommandLine = tostring(ParentCommandLine), FileSigningTime = toreal(FileSigningTime), RegCreateDisposition = tostring(RegCreateDisposition), ExtendedKeyUsages = tostring(ExtendedKeyUsages), RegRootObjectName = tostring(RegRootObjectName), RegKeyName = tostring(RegKeyName), RegPostObjectName = tostring(RegPostObjectName), PublicKeys = tostring(PublicKeys), KeyObject = tostring(KeyObject), TaskExecArguments = tostring(TaskExecArguments), TaskAuthor = tostring(TaskAuthor), TaskXml = tostring(TaskXml), TaskExecCommand = tostring(TaskExecCommand), TaskName = tostring(TaskName), ScreenshotType = tostring(ScreenshotType), OriginalFilename = tostring(OriginalFilename), ScriptContentSource = tostring(ScriptContentSource), ScriptControlErrorCode = tostring(ScriptControlErrorCode), KernelTime = toreal(KernelTime), CallStackModuleNames = tostring(CallStackModuleNames), ExecutableBytes = tostring(ExecutableBytes), ScriptContentBytes = tostring(ScriptContentBytes), SuspectStackFlag = tostring(SuspectStackFlag), GrandparentCommandLine = tostring(GrandparentCommandLine), GrandparentImageFileName = tostring(GrandparentImageFileName), ParentImageFileName = tostring(ParentImageFileName), ErrorStatus = tostring(ErrorStatus), UmppaInjectionType = tostring(UmppaInjectionType), RawProcessId = tostring(RawProcessId), WmiProviderType = tostring(WmiProviderType), ContextThreadId = tostring(ContextThreadId), UserCanonical = tostring(UserCanonical), UserName = tostring(UserName), RemoteAccount = tostring(RemoteAccount), LogonDomain = tostring(LogonDomain), LogonTime = toreal(LogonTime), UserIsAdmin = tostring(UserIsAdmin), UserPrincipal = tostring(UserPrincipal), LogonType = tostring(LogonType), TamperFilterFlags = tostring(TamperFilterFlags), ContextTimeStamp = toreal(ContextTimeStamp), SystemUptimeSeconds = tolong(SystemUptimeSeconds), cid = tostring(cid), EffectiveTransmissionClass = tostring(EffectiveTransmissionClass), CrowdStrikeId = tostring(CrowdStrikeId), Name = tostring(Name), Entitlements = tostring(Entitlements), ConfigBuild = tostring(ConfigBuild), BoundingLimitCount = tolong(BoundingLimitCount), ContextProcessId = tostring(ContextProcessId), ConfigStateHash = tostring(ConfigStateHash), event_platform = tostring(event_platform), aid = tostring(aid), aip = tostring(aip), timestamp = tolong(timestamp), UserSid = tostring(UserSid), DesiredAccess = tostring(DesiredAccess), UserFlags = tostring(UserFlags), LogonId = tostring(LogonId), EtwEventCount = tolong(EtwEventCount), CloudErrorCode = tostring(CloudErrorCode), ErrorText = tostring(ErrorText), Status = tostring(Status), TargetFileName = tostring(TargetFileName), SHA256HashData = tostring(SHA256HashData), OriginalUserSid = tostring(OriginalUserSid), ParentAuthenticationId = tostring(ParentAuthenticationId), OriginalParentAuthenticationId = tostring(OriginalParentAuthenticationId), ImageFileName = tostring(ImageFileName), EtwRawProcessId = tostring(EtwRawProcessId), WmiFilterType = tostring(WmiFilterType), WmiConsumerType = tostring(WmiConsumerType), ClientComputerName = tostring(ClientComputerName), CommandLine = tostring(CommandLine), AuthenticationIdMac = tostring(AuthenticationIdMac), AuthenticationUuid = tostring(AuthenticationUuid), UID = tostring(UID), AuthenticationUuidAsString = tostring(AuthenticationUuidAsString), LoginSessionId = tostring(LoginSessionId), UserLogonFlags = tostring(UserLogonFlags), PasswordLastSet = tostring(PasswordLastSet), AuthenticationId = tostring(AuthenticationId), AuthenticationPackage = tostring(AuthenticationPackage), SessionId = tostring(SessionId), LogonServer = tostring(LogonServer), RegCreateOptions = tostring(RegCreateOptions), SignInfoFlags = tostring(SignInfoFlags), Certificate = tostring(Certificate), PhysicalAddress = tostring(PhysicalAddress), ConnectionType = tostring(ConnectionType), PreferredLifetime = tostring(PreferredLifetime), IpEntryFlags = tostring(IpEntryFlags), AccessType = tostring(AccessType), MediaType = tostring(MediaType), InterfaceType = tostring(InterfaceType), PermanentPhysicalAddress = tostring(PermanentPhysicalAddress), InterfaceFlags = tostring(InterfaceFlags), InterfaceIndex = tostring(InterfaceIndex), InterfaceAlias = tostring(InterfaceAlias), NetworkGuid = tostring(NetworkGuid), MaxReassemblySize = tostring(MaxReassemblySize), ValidLifetime = tostring(ValidLifetime), LocalAddressIP4 = tostring(LocalAddressIP4), DeviceId = tostring(DeviceId), PrimaryModule = tostring(PrimaryModule), QuarantinedFileExtendedState = tostring(QuarantinedFileExtendedState), IsOnRemovableDisk = tostring(IsOnRemovableDisk), RemoteAddressIP4 = tostring(RemoteAddressIP4), VolumeEncryptionStatus = tostring(VolumeEncryptionStatus), VolumeRealDeviceName = tostring(VolumeRealDeviceName), VolumeSnapshotTimeStamp = toreal(VolumeSnapshotTimeStamp), VolumeFileSystemDriver = tostring(VolumeFileSystemDriver), VolumeIsEncrypted = tostring(VolumeIsEncrypted), DirectionType = tostring(DirectionType), VolumeSnapshotName = tostring(VolumeSnapshotName), IfType = tostring(IfType), CreationTimeStamp = toreal(CreationTimeStamp), SignatureErrorState = tostring(SignatureErrorState), OperationFlags = tostring(OperationFlags), MajorFunction = tostring(MajorFunction), IrpFlags = tostring(IrpFlags), FileObject = tostring(FileObject), MinorFunction = tostring(MinorFunction), EtwTargetRawProcessId = tostring(EtwTargetRawProcessId), ProcessCount = tolong(ProcessCount), SuppressType = tostring(SuppressType), Timeout = tostring(Timeout), MeasurementType = tostring(MeasurementType), FirmwareType = tostring(FirmwareType), ImageAnalysisRequestTimestamp = toreal(ImageAnalysisRequestTimestamp), FirmwareSize = tostring(FirmwareSize), AssemblyFlags = tostring(AssemblyFlags), DotnetModuleFlags = tostring(DotnetModuleFlags), ModuleNativePath = tostring(ModuleNativePath), DefaultGatewayIP6 = tostring(DefaultGatewayIP6), LocalAddressIP6 = tostring(LocalAddressIP6), TotalDiskSpace = toint(TotalDiskSpace), PhysicalMediumType = tostring(PhysicalMediumType), NetworkInterfaceGuid = tostring(NetworkInterfaceGuid), TunnelType = tostring(TunnelType), PhysicalAddressLength = tostring(PhysicalAddressLength), BaseReachableTime = tolong(BaseReachableTime), RetransmitTime = tolong(RetransmitTime), RpcOpClassification = tostring(RpcOpClassification), VolumeFileSystemDevice = tostring(VolumeFileSystemDevice), CloudRequestId = tostring(CloudRequestId), OSVersionString = tostring(OSVersionString), OSVersionFileData = tostring(OSVersionFileData), BuildNumber = tostring(BuildNumber), CheckedBuild = tostring(CheckedBuild), MinorVersion = tostring(MinorVersion), ProductType = tostring(ProductType), MajorVersion = tostring(MajorVersion), BuildType = tostring(BuildType), PlatformId = tostring(PlatformId), SubBuildNumber = tostring(SubBuildNumber), ProductName = tostring(ProductName), PointerSize = tostring(PointerSize), ProductSku = tostring(ProductSku), FileVersion = tostring(FileVersion), FixedFileVersion = tostring(FixedFileVersion), CompanyName = tostring(CompanyName), VersionInfo = tostring(VersionInfo), OciContainersStartedCount = tolong(OciContainersStartedCount), OciContainersStoppedCount = tolong(OciContainersStoppedCount), Size = tostring(Size), TargetAddress = tostring(TargetAddress), Object1Type = tostring(Object1Type), FileSubType = tostring(FileSubType), PatternHandlingErrorType = tostring(PatternHandlingErrorType), OdsActionType = tostring(OdsActionType), OSVersionFileName = tostring(OSVersionFileName), VolumeSessionUUID = tostring(VolumeSessionUUID), IntegrityLevel = tostring(IntegrityLevel), Protocol = tostring(Protocol), AttemptNumber = tostring(AttemptNumber), LfoUploadFlags = tostring(LfoUploadFlags), PhysicalCoreCount = tolong(PhysicalCoreCount), NamedPipeOperationType = tostring(NamedPipeOperationType), MD5HashData = tostring(MD5HashData), ProcessIntegrityLevel = tostring(ProcessIntegrityLevel), ServiceGroup = tostring(ServiceGroup), ServiceErrorControl = tostring(ServiceErrorControl), ServiceFailureActions = tostring(ServiceFailureActions), ServiceType = tostring(ServiceType), ServiceStart = tostring(ServiceStart), ServiceImagePath = tostring(ServiceImagePath), ServiceSecurity = tostring(ServiceSecurity), ServiceDescription = tostring(ServiceDescription), ServiceObjectName = tostring(ServiceObjectName), TreeId = tostring(TreeId), Length = tostring(Length), VolumeFileSystemType = tostring(VolumeFileSystemType), PatternDisposition = tostring(PatternDisposition), VolumeSectorSize = tostring(VolumeSectorSize), VolumeDeviceCharacteristics = tostring(VolumeDeviceCharacteristics), ByteOffset = tostring(ByteOffset), VolumeDeviceObjectFlags = tostring(VolumeDeviceObjectFlags), VolumeName = tostring(VolumeName), VolumeDeviceType = tostring(VolumeDeviceType), RemotePort = tostring(RemotePort), AdditionalFields = todynamic(AdditionalFields)'
        outputStream: 'Custom-CrowdStrike_Additional_Events_CL'
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
