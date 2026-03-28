// ----------------------------------------------------------------------------
// Cheap AVD Starter (LRS)
// - 1 pooled host, Windows 11 multi-session
// - StartVMOnConnect enabled
// - Optional Azure Files (LRS) for FSLogix user profiles
// NOTE: This keeps agent onboarding manual to avoid brittle agent URLs;
//       we output a registration token + PowerShell to run on the VM.
// ----------------------------------------------------------------------------
targetScope = 'subscription'

// ------------------- Parameters -------------------
@description('Short prefix for naming (3-12 chars).')
param prefix string

@description('Primary region.')
param location string = 'canadacentral'

@description('AVD user UPNs who can launch the full desktop.')
param avdUsers array = []

@description('Create Azure Files (LRS) + share for FSLogix profiles.')
param enableFsLogix bool = true

@description('Users to grant share (RBAC/ACL) access for FSLogix (UPNs). Ignored if enableFsLogix=false.')
param fslogixUsers array = []

@description('VM size (small & cheap by default).')
@allowed([
  'Standard_B2s'
  'Standard_D2as_v5'
  'Standard_D2ads_v5'
])
param vmSize string = 'Standard_B2s'

@description('Local admin username for the session host.')
param localAdminUsername string

@secure()
@description('Local admin password or SSH key (password expected for Windows).')
param localAdminPasswordOrKey string

@description('Windows 11 multi-session image SKU. Leave default unless you know a different SKU is required in your region.')
@allowed([
  'win11-23h2-avd'
  'win11-22h2-avd'
])
param win11Sku string = 'win11-23h2-avd'

// ------------------- Naming -------------------
var rgName          = '${prefix}-rg-avd'
var vnetName        = '${prefix}-vnet'
var subnetName      = 'avd-hosts'
var nsgName         = '${prefix}-nsg'
var saName          = toLower('${prefix}stfslogix${uniqueString(subscription().subscriptionId)}') // must be globally unique
var shareName       = 'profiles'
var workspaceName   = '${prefix}-ws'
var hostpoolName    = '${prefix}-hp'
var appGroupName    = '${prefix}-dag'
var vmName          = '${prefix}-w11-01'
var nicName         = '${vmName}-nic'

// ------------------- Resource Group -------------------
resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: rgName
  location: location
  tags: {
    Environment: 'lab'
    Cost: 'low'
  }
}

// ------------------- Network (simple & cheap) -------------------
resource nsg 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: nsgName
  scope: rg
  location: location
  properties: {
    securityRules: [
      // RDP allowed from Internet for quick lab (cheap). For production, lock this down or use a jump host.
      {
        name: 'Allow-RDP-3389'
        properties: {
          priority: 2000
          direction: 'Inbound'
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  scope: rg
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.10.1.0/24'
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
}

// ------------------- Optional: FSLogix via Azure Files (LRS) -------------------
@description('Storage account for FSLogix (LRS).')
resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = if (enableFsLogix) {
  name: saName
  scope: rg
  location: location
  sku: { name: 'Standard_LRS' } // LRS = cheapest redundancy
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
      ipRules: []
      virtualNetworkRules: []
    }
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        file: { enabled: true }
        blob: { enabled: true }
      }
    }
  }
}

@description('Azure Files share for FSLogix user profiles.')
resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-01-01' = if (enableFsLogix) {
  name: '${sa.name}/default/${shareName}'
  scope: rg
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 100 // 100 GB is plenty for a tiny lab; raise for more users
    enabledProtocols: 'SMB'
  }
}

// (Optional) Assign built-in role to each user so they can access Azure Files (preview/region-specific for Entra scenarios vary).
// For quick labs you may keep this minimal and rely on local admin to set NTFS/SMB ACLs after join.
// NOTE: This section is intentionally minimal; adjust to your directory model.
// Skipped here to avoid false precision/cost.

// ------------------- AVD Control Plane -------------------
resource workspace 'Microsoft.DesktopVirtualization/workspaces@2024-04-03' = {
  name: workspaceName
  scope: rg
  location: location
  properties: {
    friendlyName: 'Cheap AVD Workspace'
    description: 'Minimal-cost AVD workspace'
  }
}

resource hostpool 'Microsoft.DesktopVirtualization/hostPools@2024-04-03' = {
  name: hostpoolName
  scope: rg
  location: location
  properties: {
    friendlyName: 'Cheap AVD Host Pool'
    description: '1-host pooled W11 multi-session'
    hostPoolType: 'Pooled'
    preferredAppGroupType: 'Desktop'
    loadBalancerType: 'BreadthFirst'
    maxSessionLimit: 10
    startVMOnConnect: true // $$$ saver: power on when user connects
    registrationInfo: {
      expirationTime: dateTimeAdd(utcNow(), 'P7D') // token valid 7 days
      registrationTokenOperation: 'Update'
    }
    publicNetworkAccess: 'Enabled'
  }
}

resource appGroup 'Microsoft.DesktopVirtualization/applicationGroups@2024-04-03' = {
  name: appGroupName
  scope: rg
  location: location
  properties: {
    description: 'Desktop app group'
    friendlyName: 'Full Desktop'
    applicationGroupType: 'Desktop'
    hostPoolArmPath: hostpool.id
  }
}

// Link the app group to the workspace
resource wsAssociation 'Microsoft.DesktopVirtualization/workspaces/applicationGroupReferences@2024-04-03' = {
  name: '${workspace.name}/${appGroup.name}'
  scope: rg
  properties: {
    applicationGroupPath: appGroup.id
  }
}

// Assign users to the Desktop Application Group
@batchSize(5)
resource dagAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = [for (upn, i) in avdUsers: {
  name: guid('avd-dag-assign', appGroup.id, upn)
  scope: appGroup
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '1a7d1b0d-6b0f-4c2a-9010-38d0c245d3b7') // "Desktop Virtualization User"
    principalId: reference(subscriptionResourceId('Microsoft.Graph/users', upn), '2023-10-01-preview', 'Full').properties.id
    principalType: 'User'
  }
}]

// ------------------- Session Host (Windows 11 multi-session) -------------------
resource nic 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: nicName
  scope: rg
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: resourceId(rg.name, 'Microsoft.Network/virtualNetworks/subnets', vnet.name, subnetName)
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: vmName
  scope: rg
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS' // cheapest managed disk
        }
      }
      imageReference: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'Windows-11'
        sku: win11Sku          // e.g., "win11-23h2-avd"
        version: 'latest'
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: localAdminUsername
      adminPassword: localAdminPasswordOrKey
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        timeZone: 'Pacific Standard Time'
      }
    }
    networkProfile: {
      networkInterfaces: [
        { id: nic.id }
      ]
    }
  }
}

// (Optional) Enable AAD login for VM (lets Entra users RDP if needed)
// For a lab, you can keep local admin + RDP; production: lock it down.
resource aadLogin 'Microsoft.Compute/virtualMachines/extensions@2023-09-01' = {
  name: '${vm.name}/AADLoginForWindows'
  scope: rg
  location: location
  properties: {
    publisher: 'Microsoft.Azure.ActiveDirectory'
    type: 'AADLoginForWindows'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
  }
}

// ------------------- Outputs & Manual Onboarding Notes -------------------
var regToken = hostpool.properties.registrationInfo.token

// FSLogix UNC path (if enabled). You will still need to configure FSLogix GPO/registry inside the VM.
output fslogixSharePath string = enableFsLogix ? '\\\\${sa.name}.file.core.windows.net\\${shareName}' : 'FSLogix disabled'

// Token + script to run *inside* the session host to register it with the host pool.
// This avoids hard-coding external download links into the template (they change).
output avdRegistrationToken string = regToken
output onboardingScript string = 'Run (as admin) in the VM: `powershell -NoProfile -ExecutionPolicy Bypass -Command "Invoke-WebRequest https://aka.ms/avdagent -OutFile $env:TEMP\\AVDAgent.msi; Start-Process msiexec.exe -Wait -ArgumentList \'/i\', \"$env:TEMP\\AVDAgent.msi\", \'/qn\', \'REGISTRATIONTOKEN=${regToken}\'; Invoke-WebRequest https://aka.ms/avdbootloader -OutFile $env:TEMP\\AVDBootLoader.msi; Start-Process msiexec.exe -Wait -ArgumentList \'/i\', \"$env:TEMP\\AVDBootLoader.msi\", \'/qn\'"`'

// Client connect info
output workspaceResourceId string = workspace.id
output hostpoolResourceId string = hostpool.id
output appGroupResourceId string = appGroup.id
output vmId string = vm.id
