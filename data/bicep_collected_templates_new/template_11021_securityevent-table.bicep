// Bicep template for Log Analytics custom table: SecurityEvent
// Generated on 2025-09-19 14:13:58 UTC
// Source: JSON schema export
// Original columns: 233, Deployed columns: 232 (Type column filtered)
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

resource securityeventTable 'Microsoft.OperationalInsights/workspaces/tables@2025-02-01' = {
  parent: workspace
  name: 'SecurityEvent'
  properties: {
    plan: tablePlan
    retentionInDays: retentionInDays
    totalRetentionInDays: totalRetentionInDays
    schema: {
      name: 'SecurityEvent'
      description: 'Custom table SecurityEvent - imported from JSON schema'
      displayName: 'SecurityEvent'
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
          name: 'PrimaryGroupId'
          type: 'string'
        }
        {
          name: 'PrivateKeyUsageCount'
          type: 'string'
        }
        {
          name: 'PrivilegeList'
          type: 'string'
        }
        {
          name: 'Process'
          type: 'string'
        }
        {
          name: 'ProcessId'
          type: 'string'
        }
        {
          name: 'ProcessName'
          type: 'string'
        }
        {
          name: 'Properties'
          type: 'string'
        }
        {
          name: 'ProfilePath'
          type: 'string'
        }
        {
          name: 'ProtocolSequence'
          type: 'string'
        }
        {
          name: 'ProxyPolicyName'
          type: 'string'
        }
        {
          name: 'QuarantineHelpURL'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'QuarantineSessionID'
          type: 'string'
        }
        {
          name: 'QuarantineSessionIdentifier'
          type: 'string'
        }
        {
          name: 'QuarantineState'
          type: 'string'
        }
        {
          name: 'QuarantineSystemHealthResult'
          type: 'string'
        }
        {
          name: 'RelativeTargetName'
          type: 'string'
        }
        {
          name: 'RemoteIpAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'RemotePort'
          type: 'string'
        }
        {
          name: 'Requester'
          type: 'string'
        }
        {
          name: 'RequestId'
          type: 'string'
        }
        {
          name: 'RestrictedAdminMode'
          type: 'string'
        }
        {
          name: 'RowsDeleted'
          type: 'string'
        }
        {
          name: 'SamAccountName'
          type: 'string'
        }
        {
          name: 'ScriptPath'
          type: 'string'
        }
        {
          name: 'SecurityDescriptor'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'PreviousTime'
          type: 'string'
        }
        {
          name: 'ServiceAccount'
          type: 'string'
        }
        {
          name: 'PreviousDate'
          type: 'string'
        }
        {
          name: 'PasswordLastSet'
          type: 'string'
        }
        {
          name: 'NewDate'
          type: 'string'
        }
        {
          name: 'NewMaxUsers'
          type: 'string'
        }
        {
          name: 'NewProcessId'
          type: 'string'
        }
        {
          name: 'NewProcessName'
          type: 'string'
        }
        {
          name: 'NewRemark'
          type: 'string'
        }
        {
          name: 'NewShareFlags'
          type: 'string'
        }
        {
          name: 'NewTime'
          type: 'string'
        }
        {
          name: 'NewUacValue'
          type: 'string'
        }
        {
          name: 'NewValue'
          type: 'string'
        }
        {
          name: 'NewValueType'
          type: 'string'
        }
        {
          name: 'ObjectName'
          type: 'string'
        }
        {
          name: 'ObjectServer'
          type: 'string'
        }
        {
          name: 'ObjectType'
          type: 'string'
        }
        {
          name: 'ObjectValueName'
          type: 'string'
        }
        {
          name: 'OemInformation'
          type: 'string'
        }
        {
          name: 'OldMaxUsers'
          type: 'string'
        }
        {
          name: 'OldRemark'
          type: 'string'
        }
        {
          name: 'OldShareFlags'
          type: 'string'
        }
        {
          name: 'OldUacValue'
          type: 'string'
        }
        {
          name: 'OldValue'
          type: 'string'
        }
        {
          name: 'OldValueType'
          type: 'string'
        }
        {
          name: 'OperationType'
          type: 'string'
        }
        {
          name: 'PackageName'
          type: 'string'
        }
        {
          name: 'ParentProcessName'
          type: 'string'
        }
        {
          name: 'PasswordHistoryLength'
          type: 'string'
        }
        {
          name: 'PasswordProperties'
          type: 'string'
        }
        {
          name: 'NetworkPolicyName'
          type: 'string'
        }
        {
          name: 'ServiceFileName'
          type: 'string'
        }
        {
          name: 'ServiceStartType'
          type: 'int'
        }
        {
          name: 'TargetUser'
          type: 'string'
        }
        {
          name: 'TargetUserName'
          type: 'string'
        }
        {
          name: 'TargetUserSid'
          type: 'string'
        }
        {
          name: 'TemplateContent'
          type: 'string'
        }
        {
          name: 'TemplateDSObjectFQDN'
          type: 'string'
        }
        {
          name: 'TemplateInternalName'
          type: 'string'
        }
        {
          name: 'TemplateOID'
          type: 'string'
        }
        {
          name: 'TemplateSchemaVersion'
          type: 'string'
        }
        {
          name: 'TemplateVersion'
          type: 'string'
        }
        {
          name: 'TokenElevationType'
          type: 'string'
        }
        {
          name: 'TransmittedServices'
          type: 'string'
        }
        {
          name: 'UserAccountControl'
          type: 'string'
        }
        {
          name: 'UserParameters'
          type: 'string'
        }
        {
          name: 'UserPrincipalName'
          type: 'string'
        }
        {
          name: 'UserWorkstations'
          type: 'string'
        }
        {
          name: 'VirtualAccount'
          type: 'string'
        }
        {
          name: 'VendorIds'
          type: 'string'
        }
        {
          name: 'Workstation'
          type: 'string'
        }
        {
          name: 'WorkstationName'
          type: 'string'
        }
        {
          name: 'SystemUserId'
          type: 'string'
        }
        {
          name: 'Version'
          type: 'int'
        }
        {
          name: 'Opcode'
          type: 'string'
        }
        {
          name: 'Keywords'
          type: 'string'
        }
        {
          name: 'Correlation'
          type: 'string'
        }
        {
          name: 'SystemProcessId'
          type: 'int'
        }
        {
          name: 'TargetSid'
          type: 'string'
        }
        {
          name: 'ServiceName'
          type: 'string'
        }
        {
          name: 'TargetServerName'
          type: 'string'
        }
        {
          name: 'TargetOutboundDomainName'
          type: 'string'
        }
        {
          name: 'ServiceType'
          type: 'string'
        }
        {
          name: 'SessionName'
          type: 'string'
        }
        {
          name: 'ShareLocalPath'
          type: 'string'
        }
        {
          name: 'ShareName'
          type: 'string'
        }
        {
          name: 'SidHistory'
          type: 'string'
        }
        {
          name: 'Status'
          type: 'string'
        }
        {
          name: 'SubjectAccount'
          type: 'string'
        }
        {
          name: 'SubcategoryGuid'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'SubcategoryId'
          type: 'string'
        }
        {
          name: 'Subject'
          type: 'string'
        }
        {
          name: 'SubjectDomainName'
          type: 'string'
        }
        {
          name: 'SubjectKeyIdentifier'
          type: 'string'
        }
        {
          name: 'SubjectLogonId'
          type: 'string'
        }
        {
          name: 'SubjectMachineName'
          type: 'string'
        }
        {
          name: 'SubjectMachineSID'
          type: 'string'
        }
        {
          name: 'SubjectUserName'
          type: 'string'
        }
        {
          name: 'SubjectUserSid'
          type: 'string'
        }
        {
          name: 'SubStatus'
          type: 'string'
        }
        {
          name: 'TableId'
          type: 'string'
        }
        {
          name: 'TargetAccount'
          type: 'string'
        }
        {
          name: 'TargetDomainName'
          type: 'string'
        }
        {
          name: 'TargetInfo'
          type: 'string'
        }
        {
          name: 'TargetLinkedLogonId'
          type: 'string'
          dataTypeHint: 0
        }
        {
          name: 'TargetLogonGuid'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'TargetLogonId'
          type: 'string'
        }
        {
          name: 'TargetOutboundUserName'
          type: 'string'
        }
        {
          name: 'SystemThreadId'
          type: 'int'
        }
        {
          name: 'NASPortType'
          type: 'string'
        }
        {
          name: 'NASIPv6Address'
          type: 'string'
        }
        {
          name: 'AdditionalInfo'
          type: 'string'
        }
        {
          name: 'AdditionalInfo2'
          type: 'string'
        }
        {
          name: 'AllowedToDelegateTo'
          type: 'string'
        }
        {
          name: 'Attributes'
          type: 'string'
        }
        {
          name: 'AuditPolicyChanges'
          type: 'string'
        }
        {
          name: 'AuditsDiscarded'
          type: 'int'
        }
        {
          name: 'AuthenticationLevel'
          type: 'int'
        }
        {
          name: 'AuthenticationPackageName'
          type: 'string'
        }
        {
          name: 'AuthenticationProvider'
          type: 'string'
        }
        {
          name: 'AuthenticationServer'
          type: 'string'
        }
        {
          name: 'AuthenticationService'
          type: 'int'
        }
        {
          name: 'AuthenticationType'
          type: 'string'
        }
        {
          name: 'CACertificateHash'
          type: 'string'
        }
        {
          name: 'CalledStationID'
          type: 'string'
        }
        {
          name: 'CallerProcessId'
          type: 'string'
        }
        {
          name: 'CallerProcessName'
          type: 'string'
        }
        {
          name: 'CallingStationID'
          type: 'string'
        }
        {
          name: 'CAPublicKeyHash'
          type: 'string'
        }
        {
          name: 'CategoryId'
          type: 'string'
        }
        {
          name: 'CertificateDatabaseHash'
          type: 'string'
        }
        {
          name: 'ClassId'
          type: 'string'
        }
        {
          name: 'ClassName'
          type: 'string'
        }
        {
          name: 'ClientAddress'
          type: 'string'
        }
        {
          name: 'ClientIPAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ClientName'
          type: 'string'
        }
        {
          name: 'AccountSessionIdentifier'
          type: 'string'
        }
        {
          name: 'CommandLine'
          type: 'string'
        }
        {
          name: 'AccountName'
          type: 'string'
        }
        {
          name: 'AccountDomain'
          type: 'string'
        }
        {
          name: 'SourceSystem'
          type: 'string'
        }
        {
          name: 'Account'
          type: 'string'
        }
        {
          name: 'AccountType'
          type: 'string'
        }
        {
          name: 'Computer'
          type: 'string'
        }
        {
          name: 'EventSourceName'
          type: 'string'
        }
        {
          name: 'Channel'
          type: 'string'
        }
        {
          name: 'Task'
          type: 'int'
        }
        {
          name: 'Level'
          type: 'string'
        }
        {
          name: 'EventLevelName'
          type: 'string'
        }
        {
          name: 'EventData'
          type: 'string'
        }
        {
          name: 'EventID'
          type: 'int'
        }
        {
          name: 'Activity'
          type: 'string'
        }
        {
          name: 'SourceComputerId'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'EventOriginId'
          type: 'string'
        }
        {
          name: 'MG'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'TimeCollected'
          type: 'dateTime'
        }
        {
          name: 'ManagementGroupName'
          type: 'string'
        }
        {
          name: 'PartitionKey'
          type: 'string'
        }
        {
          name: 'RowKey'
          type: 'string'
        }
        {
          name: 'StorageAccount'
          type: 'string'
        }
        {
          name: 'AzureDeploymentID'
          type: 'string'
        }
        {
          name: 'AzureTableName'
          type: 'string'
        }
        {
          name: 'AccessList'
          type: 'string'
        }
        {
          name: 'AccessMask'
          type: 'string'
        }
        {
          name: 'AccessReason'
          type: 'string'
        }
        {
          name: 'AccountExpires'
          type: 'string'
        }
        {
          name: 'NASPort'
          type: 'string'
        }
        {
          name: 'CompatibleIds'
          type: 'string'
        }
        {
          name: 'DeviceDescription'
          type: 'string'
        }
        {
          name: 'KeyLength'
          type: 'int'
        }
        {
          name: 'LmPackageName'
          type: 'string'
        }
        {
          name: 'LocationInformation'
          type: 'string'
        }
        {
          name: 'LockoutDuration'
          type: 'string'
        }
        {
          name: 'LockoutObservationWindow'
          type: 'string'
        }
        {
          name: 'LockoutThreshold'
          type: 'string'
        }
        {
          name: 'LoggingResult'
          type: 'string'
        }
        {
          name: 'LogonGuid'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'LogonHours'
          type: 'string'
        }
        {
          name: 'LogonID'
          type: 'string'
        }
        {
          name: 'LogonProcessName'
          type: 'string'
        }
        {
          name: 'LogonType'
          type: 'int'
        }
        {
          name: 'LogonTypeName'
          type: 'string'
        }
        {
          name: 'MachineAccountQuota'
          type: 'string'
        }
        {
          name: 'MachineInventory'
          type: 'string'
        }
        {
          name: 'MachineLogon'
          type: 'string'
        }
        {
          name: 'MandatoryLabel'
          type: 'string'
        }
        {
          name: 'MaxPasswordAge'
          type: 'string'
        }
        {
          name: 'MemberName'
          type: 'string'
        }
        {
          name: 'MemberSid'
          type: 'string'
        }
        {
          name: 'MinPasswordAge'
          type: 'string'
        }
        {
          name: 'MinPasswordLength'
          type: 'string'
        }
        {
          name: 'MixedDomainMode'
          type: 'string'
        }
        {
          name: 'NASIdentifier'
          type: 'string'
        }
        {
          name: 'NASIPv4Address'
          type: 'string'
        }
        {
          name: 'IpPort'
          type: 'string'
        }
        {
          name: 'DCDNSName'
          type: 'string'
        }
        {
          name: 'IpAddress'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'ImpersonationLevel'
          type: 'string'
        }
        {
          name: 'DeviceId'
          type: 'string'
        }
        {
          name: 'DisplayName'
          type: 'string'
        }
        {
          name: 'Disposition'
          type: 'string'
        }
        {
          name: 'DomainBehaviorVersion'
          type: 'string'
        }
        {
          name: 'DomainName'
          type: 'string'
        }
        {
          name: 'DomainPolicyChanged'
          type: 'string'
        }
        {
          name: 'DomainSid'
          type: 'string'
        }
        {
          name: 'EAPType'
          type: 'string'
        }
        {
          name: 'ElevatedToken'
          type: 'string'
        }
        {
          name: 'ErrorCode'
          type: 'int'
        }
        {
          name: 'ExtendedQuarantineState'
          type: 'string'
        }
        {
          name: 'FailureReason'
          type: 'string'
        }
        {
          name: 'FileHash'
          type: 'string'
        }
        {
          name: 'FilePath'
          type: 'string'
        }
        {
          name: 'FilePathNoUser'
          type: 'string'
        }
        {
          name: 'Filter'
          type: 'string'
        }
        {
          name: 'ForceLogoff'
          type: 'string'
        }
        {
          name: 'Fqbn'
          type: 'string'
        }
        {
          name: 'FullyQualifiedSubjectMachineName'
          type: 'string'
        }
        {
          name: 'FullyQualifiedSubjectUserName'
          type: 'string'
        }
        {
          name: 'GroupMembership'
          type: 'string'
          dataTypeHint: 3
        }
        {
          name: 'HandleId'
          type: 'string'
        }
        {
          name: 'HardwareIds'
          type: 'string'
        }
        {
          name: 'HomeDirectory'
          type: 'string'
        }
        {
          name: 'HomePath'
          type: 'string'
        }
        {
          name: 'InterfaceUuid'
          type: 'guid'
          dataTypeHint: 1
        }
        {
          name: 'EventRecordId'
          type: 'string'
        }
      ]
    }
  }
}

output tableName string = securityeventTable.name
output tableId string = securityeventTable.id
output provisioningState string = securityeventTable.properties.provisioningState
