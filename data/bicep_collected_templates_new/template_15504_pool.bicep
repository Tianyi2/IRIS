// Dev Box Pool for a Project
targetScope = 'resourceGroup'

@description('Name of the Dev Center Project that owns this pool.')
param projectName string

@description('Name of the Dev Box pool.')
param poolName string

@description('Azure region for the pool.')
param location string

@description('Name of the Dev Box definition to use.')
param devBoxDefinitionName string

@description('Name of the network connection resource to use.')
param networkConnectionName string

@description('Virtual network type for the pool. Use Unmanaged to deploy Dev Boxes into an existing customer subnet via Network Connection.')
@allowed([
  'Managed'
  'Unmanaged'
])
param virtualNetworkType string = 'Unmanaged'

@description('Whether local admin rights are enabled for Dev Boxes in this pool.')
@allowed([
  'Enabled'
  'Disabled'
])
param localAdministrator string = 'Disabled'

@description('Tags to apply to the pool.')
param tags object = {}

// ===== Optional auto-stop schedule =====

@description('Enable creation of an auto-stop schedule for this pool.')
param enableStopSchedule bool

@description('Name of the stop schedule resource.')
param stopScheduleName string

@description('Frequency of the stop schedule (e.g., Daily or Weekly).')
@allowed([
  'Daily'
  'Weekly'
])
param stopScheduleFrequency string

@description('Time of day when the schedule runs (HH:MM, 24-hour format).')
param stopScheduleTime string

@description('Time zone for the stop schedule, for example: Europe/Warsaw.')
param stopScheduleTimeZone string

@description('Overall state of the stop schedule (Enabled or Disabled).')
@allowed([
  'Enabled'
  'Disabled'
])
param stopScheduleState string


// ===== Pool resource =====

resource pool 'Microsoft.DevCenter/projects/pools@2024-02-01' = {
  name: '${projectName}/${poolName}'
  location: location
  properties: {
    devBoxDefinitionName: devBoxDefinitionName
    networkConnectionName: networkConnectionName
    virtualNetworkType: virtualNetworkType
    licenseType: 'Windows_Client'
    localAdministrator: localAdministrator
  }
  tags: tags
}

// ===== Auto-stop schedule (child resource) =====
//
// This creates a schedule under the pool that runs the StopDevBox action
// according to the configured frequency/time/timeZone.
resource stopSchedule 'Microsoft.DevCenter/projects/pools/schedules@2024-02-01' = if (enableStopSchedule) {
  name: stopScheduleName
  parent: pool
  properties: {
    type: 'StopDevBox'
    frequency: stopScheduleFrequency   // e.g. Daily
    time: stopScheduleTime            // e.g. 18:00
    timeZone: stopScheduleTimeZone    // e.g. Europe/Warsaw
    state: stopScheduleState          // Enabled / Disabled
  }
}

output id string = pool.id
output nameOut string = pool.name
