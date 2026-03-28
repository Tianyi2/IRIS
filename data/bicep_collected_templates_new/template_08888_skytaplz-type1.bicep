// Skytap Landing Zone template - self-contained hub version
// 2023.01.17
// Poom Nupong (poomsawas@gmail.com)

param REGION string = 'southcentralus'
// shorten southcentralus because it's too long
var REGION_SUFFIX = REGION == 'southcentralus' ? 'scus' : REGION

// give user opportunity to customize components in hub
// this template is customized for a scenario that requires ExpressRoute Gateway and Azure Route Server
param DEPLOY_EXRGW bool = true      // mandatory - use for rapid deploy tests
param DEPLOY_ROUTESERVER bool = true    // mandatory - use for rapid deploy tests
param DEPLOY_VPNGW bool = false
param DEPLOY_TESTHUBVM bool = true
param FRR_BGPASN string = '65027'

// passing route server subnet for linux custom script to configure FRR
param FRR_ROUTESERVERSUBNET string = '10.2.27.192/27'
// route server IP addresses are assigned dynamically but I haven't figured out a way to extract them directly from bicep resource object
param FRR_ROUTESERVERIP1 string = '10.2.27.196'
param FRR_ROUTESERVERIP2 string = '10.2.27.197'
// same for gateway address of NVA inside subnet, set it statically
param FRR_NVAINSIDESUBNETGW string = '10.2.27.49'

// set NVA inside IP address to static to deal with circular dependency
param NVAINSIDEIPADDR string = '10.2.27.52'

param VM_USERNAME string = 'azureuser'
@secure()
param VM_PASSWORD string

// set your home IP address here, the template will allow ssh to nva1 VM from this IP address
param HOME_PUBIP string = '99.70.225.17'
param VNET_PREFIX string = 'skytaplz1'
param VNET_ADDRSPACE array = [ '10.2.27.0/24' ]

// vnet1
resource vnet1 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: '${VNET_PREFIX}-${REGION_SUFFIX}-vnet'
  location: REGION
  properties: {
    addressSpace: {
      addressPrefixes: VNET_ADDRSPACE
    }
    subnets: [
      {
        name: 'general1-snet'
        properties: { addressPrefix: '10.2.27.0/28' }
      }
      {
        name: 'nvaoutside-snet'
        properties: {
          addressPrefix: '10.2.27.32/28'
          routeTable: { id: routeTableNvaOutside.id }
        }
      }
      {
        name: 'nvainside-snet'
        properties: { addressPrefix: '10.2.27.48/28' }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: { addressPrefix: '10.2.27.128/26' }
      }
      {
        name: 'RouteServerSubnet'
        properties: { addressPrefix: '10.2.27.192/27' }
      }
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.2.27.224/27'
          routeTable: { id: routeTableGatewaySubnet.id }
        }
      }
    ]
  }
}

// vpn gateway / public IP addresses, need 2x for active-active mode with route server
resource vpngwPip1 'Microsoft.Network/publicIPAddresses@2019-11-01' = if (DEPLOY_VPNGW) {
  name: '${VNET_PREFIX}-${REGION_SUFFIX}-vpngw-pip1'
  location: REGION
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}
resource vpngwPip2 'Microsoft.Network/publicIPAddresses@2019-11-01' = if (DEPLOY_VPNGW) {
  name: '${VNET_PREFIX}-${REGION_SUFFIX}-vpngw-pip2'
  location: REGION
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// vpn gateway
resource vpngw 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = if (DEPLOY_VPNGW) {
  name: '${VNET_PREFIX}-${REGION_SUFFIX}-vpngw'
  location: REGION
  properties: {
    bgpSettings: {
      asn: 65027
    }
    activeActive: true
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${vnet1.id}/subnets/GatewaySubnet'
          }
          publicIPAddress: {
            id: vpngwPip1.id
          }
        }
      }
      {
        name: 'ipconfig2'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${vnet1.id}/subnets/GatewaySubnet'
          }
          publicIPAddress: {
            id: vpngwPip2.id
          }
        }
      }
    ]
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: true
  }
}

// azure route server / public ip
resource routeServer1Pip 'Microsoft.Network/publicIPAddresses@2019-11-01' = if (DEPLOY_ROUTESERVER) {
  name: '${VNET_PREFIX}-${REGION_SUFFIX}-ars-pip'
  location: REGION
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
  }
}

// azure route server
resource routeServer1 'Microsoft.Network/virtualHubs@2021-02-01' = if (DEPLOY_ROUTESERVER) {
  name: '${VNET_PREFIX}-${REGION_SUFFIX}-ars'
  location: REGION
  dependsOn: [
    vnet1
  ]
  properties: {
    sku: 'Standard'
    allowBranchToBranchTraffic: true
  }
}

// azure route server / ip config
resource routeServer1IPConfig 'Microsoft.Network/virtualHubs/ipConfigurations@2022-05-01' = if (DEPLOY_ROUTESERVER) {
  name: 'ipconfig1'
  parent: routeServer1
  properties: {
    subnet: {
      id: '${vnet1.id}/subnets/RouteServerSubnet'
    }
    publicIPAddress: {
      id: routeServer1Pip.id
    }
  }
}

// expressroute gateway / public ip
resource exrgwPip 'Microsoft.Network/publicIPAddresses@2019-11-01' = if (DEPLOY_EXRGW) {
  name: '${VNET_PREFIX}-${REGION_SUFFIX}-exrgw-pip'
  location: REGION
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// expressroute gateway
resource exrgw 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = if (DEPLOY_EXRGW) {
  name: '${VNET_PREFIX}-${REGION_SUFFIX}-exrgw'
  location: REGION
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${vnet1.id}/subnets/GatewaySubnet'
          }
          publicIPAddress: {
            id: exrgwPip.id
          }
        }
      }
    ]
    sku: {
      name: 'Standard'
      tier: 'Standard'
    }
    gatewayType: 'ExpressRoute'
    vpnType: 'PolicyBased'
    enableBgp: true
  }
}

//=== continue with nva from here:
// https://learn.microsoft.com/en-us/azure/templates/microsoft.network/virtualhubs?pivots=deployment-language-bicep

// nva-vm / public ip
resource nva1VmPip 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: 'nva1-${REGION_SUFFIX}-vm-pip'
  location: REGION
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// nva-vm / nsg
resource nva1VmNsg 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: 'nva1-${REGION_SUFFIX}-vm-nsg'
  location: REGION
  properties: {
    securityRules: [
      {
        name: 'allow-ssh-hq'
        properties: {
          description: 'allow-ssh'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: HOME_PUBIP
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

// nva-vm / nic1
resource nva1VmNic1 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'nva1-${REGION_SUFFIX}-vm-nic1'
  location: REGION
  properties: {
    enableIPForwarding: true
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          primary: true
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${vnet1.id}/subnets/nvaoutside-snet'
          }
          publicIPAddress: {
            id: nva1VmPip.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nva1VmNsg.id
    }
  }
}

// nva-vm / nic2
resource nva1VmNic2 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'nva1-${REGION_SUFFIX}-vm-nic2'
  location: REGION
  properties: {
    enableIPForwarding: true
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Static'
          privateIPAddress: NVAINSIDEIPADDR
          subnet: {
            id: '${vnet1.id}/subnets/nvainside-snet'
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nva1VmNsg.id
    }
  }
}

// nva-vm 
resource nva1Vm 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'nva1-${REGION_SUFFIX}-vm'
  //== TODO: need to wait for Route Server to provision to get BGP peer IP addresses but it doesn't work yet
  //== will provision NVA in parallel with hardcoded parameters for now
  // dependsOn: [routeServer1IPConfig]
  location: REGION
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2ds_v4'
    }
    osProfile: {
      computerName: 'skytaplz-nva1'
      adminUsername: VM_USERNAME
      adminPassword: VM_PASSWORD
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        // offer: '0001-com-ubuntu-server-focal'
        // sku: '20_04-lts-gen2'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        // version: 'latest'
        version: '22.04.202301050'
      }
      osDisk: {
        name: 'nva1-${REGION_SUFFIX}-vm-disk0'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nva1VmNic1.id
          properties: {
            primary: true
          }
        }
        {
          id: nva1VmNic2.id
          properties: {
            primary: false
          }
        }
      ]
    }
    // diagnosticsProfile: {
    //   bootDiagnostics: {
    //     enabled: true
    //     storageUri: 'storageUri'
    //   }
    // }
  }
}

// route table for nva to internet
resource routeTableNvaOutside 'Microsoft.Network/routeTables@2019-11-01' = {
  name: 'nvaoutside-rt'
  location: REGION
  properties: {
    routes: [
      {
        name: 'default-to-internet'
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopType: 'Internet'
          // nextHopIpAddress: 'nextHopIp'
        }
      }
    ]
    disableBgpRoutePropagation: true
  }
}

resource routeTableGatewaySubnet 'Microsoft.Network/routeTables@2019-11-01' = {
  name: 'gatewaysubnet-rt'
  location: REGION
  properties: {
    routes: [
      // {
      //   name: 'RFC1918A'
      //   properties: {
      //     addressPrefix: '10.0.0.0/8'
      //     nextHopType: 'VirtualAppliance'
      //     nextHopIpAddress: NVAINSIDEIPADDR
      //   }
      // }
      // {
      //   name: 'RFC1918B'
      //   properties: {
      //     addressPrefix: '172.16.0.0/12'
      //     nextHopType: 'VirtualAppliance'
      //     nextHopIpAddress: NVAINSIDEIPADDR
      //   }
      // }
      // {
      //   name: 'RFC1918C'
      //   properties: {
      //     addressPrefix: '192.168.0.0/16'
      //     nextHopType: 'VirtualAppliance'
      //     nextHopIpAddress: NVAINSIDEIPADDR
      //   }
      // }
    ]
    disableBgpRoutePropagation: false
  }
}


//===== Start configuration =====
//===============================

//=== BGP peering from Route Server
resource routeServer1BGPConnection 'Microsoft.Network/virtualHubs/bgpConnections@2022-07-01' = if (DEPLOY_ROUTESERVER) {
  name: 'nva1-bgpconn'
  parent: routeServer1
  properties: {
    peerAsn: 65027
    peerIp: nva1VmNic2.properties.ipConfigurations[0].properties.privateIPAddress
  }
  dependsOn: [
    routeServer1IPConfig
  ]
}

//=== install and configure FRR on nva
resource nva1linuxVMExtensions 'Microsoft.Compute/virtualMachines/extensions@2022-08-01' = {
  parent: nva1Vm
  name: 'nva1-${REGION_SUFFIX}-vm-extension'
  location: REGION
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      skipDos2Unix: true
      fileUris: [
        'https://raw.githubusercontent.com/poomnupong/azure-networking/main/002-skytap-landing-zone-part1/config-frr.sh'
      ]
    }
    protectedSettings: {
      commandToExecute: '/bin/bash config-frr.sh ${FRR_BGPASN} ${nva1VmNic2.properties.ipConfigurations[0].properties.privateIPAddress} ${FRR_ROUTESERVERIP1} ${FRR_ROUTESERVERIP2} ${FRR_ROUTESERVERSUBNET} ${FRR_NVAINSIDESUBNETGW}'
    }
  }
}


//===== Test VM for hub =====
//===========================

// general VM for hub - NIC
resource hubtest1VmNic 'Microsoft.Network/networkInterfaces@2020-11-01' = if (DEPLOY_TESTHUBVM) {
  name: 'hubtest1-${REGION_SUFFIX}-vm-nic'
  location: REGION
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${vnet1.id}/subnets/general1-snet'
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nva1VmNsg.id
    }
  }
}

// general VM for hub 
resource hubtest1Vm 'Microsoft.Compute/virtualMachines@2020-12-01' = if (DEPLOY_TESTHUBVM) {
  name: 'hubtest1-${REGION_SUFFIX}-vm'
  location: REGION
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    osProfile: {
      computerName: 'hubtest1-${REGION_SUFFIX}-vm'
      adminUsername: VM_USERNAME
      adminPassword: VM_PASSWORD
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        // offer: '0001-com-ubuntu-server-focal'
        // sku: '20_04-lts-gen2'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        name: 'hubtest1-${REGION_SUFFIX}-vm-disk0'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: hubtest1VmNic.id
          properties: {
            primary: true
          }
        }
      ]
    }
    // diagnosticsProfile: {
    //   bootDiagnostics: {
    //     enabled: true
    //     storageUri: 'storageUri'
    //   }
    // }
  }
}


//===== Test spoke section =====
//===============================

// spoke vnet
resource vNetSpoke1 'Microsoft.Network/virtualNetworks@2022-07-01' = if (DEPLOY_EXRGW || DEPLOY_VPNGW) {
  name: 'testspoke1-${REGION_SUFFIX}-vnet'
  location: REGION
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.24.0/24'
      ]
    }
    subnets: [
      {
        name: 'general1-snet'
        properties: {
          addressPrefix: '10.2.24.0/28'
        }
      }
    ]
  }
}

// vnet peering: spoke-to-hub
resource peeringSpoke1ToHub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = if (DEPLOY_EXRGW || DEPLOY_VPNGW) {
  name: '${vNetSpoke1.name}/testspoke1-vnet_to_skytaplz1-vnet_peering'
  dependsOn: [ exrgw ]
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: true
    remoteVirtualNetwork: {
      id: vnet1.id
    }
  }
}

// vnet peering: hub-to-spoke
resource peeringHubToSpoke1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = if (DEPLOY_EXRGW || DEPLOY_VPNGW) {
  name: '${vnet1.name}/skytaplz1-vnet_to_testspoke1-vnet_peering'
  dependsOn: [ exrgw ]
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: true
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vNetSpoke1.id
    }
  }
}

// general VM for spoke - NIC
resource spoketest1VmNic 'Microsoft.Network/networkInterfaces@2020-11-01' = if (DEPLOY_EXRGW || DEPLOY_VPNGW) {
  name: 'spoketest1-${REGION_SUFFIX}-vm-nic'
  location: REGION
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${vNetSpoke1.id}/subnets/general1-snet'
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nva1VmNsg.id
    }
  }
}

// general VM for hub 
resource spoketest1Vm 'Microsoft.Compute/virtualMachines@2020-12-01' = if (DEPLOY_EXRGW || DEPLOY_VPNGW) {
  name: 'spoketest1-${REGION_SUFFIX}-vm'
  location: REGION
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    osProfile: {
      computerName: 'spoketest1-${REGION_SUFFIX}-vm'
      adminUsername: VM_USERNAME
      adminPassword: VM_PASSWORD
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        // offer: '0001-com-ubuntu-server-focal'
        // sku: '20_04-lts-gen2'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        name: 'spoketest1-${REGION_SUFFIX}-vm-disk0'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: spoketest1VmNic.id
          properties: {
            primary: true
          }
        }
      ]
    }
    // diagnosticsProfile: {
    //   bootDiagnostics: {
    //     enabled: true
    //     storageUri: 'storageUri'
    //   }
    // }
  }
}
