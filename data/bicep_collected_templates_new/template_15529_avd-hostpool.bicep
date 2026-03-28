@description('Location of the AVD host pool')
param location string = resourceGroup().location

@description('Name of the host pool')
param hostPoolName string = 'AVD-Pooled-HostPool'

@description('Host pool type')
param hostPoolType string = 'Pooled' // or 'Personal'

@description('Load balancing type')
param loadBalancerType string = 'BreadthFirst' // or DepthFirst

@description('Maximum session limit per host')
param maxSessionLimit int = 10

@description('Name of the desktop app group')
param appGroupName string = '${hostPoolName}-DAG'

@description('Name of the workspace')
param workspaceName string = '${hostPoolName}-Workspace'

@description('Friendly display name for workspace')
param workspaceFriendlyName string = 'AVD Workspace'

resource hostPool 'Microsoft.DesktopVirtualization/hostPools@2022-02-10-preview' = {
  name: hostPoolName
  location: location
  properties: {
    friendlyName: hostPoolName
    description: 'Pooled Host Pool for AVD'
    hostPoolType: hostPoolType
    loadBalancerType: loadBalancerType
    maxSessionLimit: maxSessionLimit
    registrationInfo: {
      expirationTime: dateTimeAdd(utcNow(), 'P1D')
    }
    customRdpProperty: ''
    type: 'Persistent'
  }
}

resource appGroup 'Microsoft.DesktopVirtualization/applicationGroups@2022-02-10-preview' = {
  name: appGroupName
  location: location
  properties: {
    description: 'Desktop App Group for pooled host pool'
    friendlyName: appGroupName
    hostPoolArmPath: hostPool.id
    applicationGroupType: 'Desktop'
  }
}

resource workspace 'Microsoft.DesktopVirtualization/workspaces@2022-02-10-preview' = {
  name: workspaceName
  location: location
  properties: {
    description: 'Workspace for AVD users'
    friendlyName: workspaceFriendlyName
    applicationGroupReferences: [
      appGroup.id
    ]
  }
}
