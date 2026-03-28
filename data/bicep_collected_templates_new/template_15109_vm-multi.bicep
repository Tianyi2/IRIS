@description('Location for the virtual machines')
param location string

@description('Size of each virtual machine')
param vmSize string

@description('SSH public key for secure access')
@secure()
param adminPublicKey string

@description('Admin username for the virtual machines')
param adminUsername string = 'azureuser'

@description('Base name for the virtual machines')
param vmBaseName string

@description('Number of virtual machines to deploy')
param vmCount int

@description('Subnet resource ID where VMs will be deployed')
param subnetId string

@description('Backend pool ID of the load balancer')
param backendPoolId string

// Creates virtual machines
resource vmArray 'Microsoft.Compute/virtualMachines@2023-03-01' = [for i in range(0, vmCount): {
  name: '${vmBaseName}-${i}'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: '${vmBaseName}-${i}'
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: adminPublicKey
            }
          ]
        }
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: '0001-com-ubuntu-server-jammy'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicArray[i].id
        }
      ]
    }
  }
}]

// Creates network interfaces for each VM
resource nicArray 'Microsoft.Network/networkInterfaces@2023-04-01' = [for i in range(0, vmCount): {
  name: '${vmBaseName}-nic-${i}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnetId
          }
          loadBalancerBackendAddressPools: [
            {
              id: backendPoolId
            }
          ]
        }
      }
    ]
  }
}]

// Adds Custom Script Extension to install NGINX on each VM
resource extArray 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = [for i in range(0, vmCount): {
  name: 'install-nginx-${i}'
  location: location
  parent: vmArray[i]
  properties: {
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    typeHandlerVersion: '2.1'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: []
      commandToExecute: 'curl -sSL https://raw.githubusercontent.com/gil-daniel/iac-nginx-lab/main/scripts/install-nginx.sh | bash'
    }
  }
}]
