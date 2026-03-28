// Define parameters for the deployment
@description('Name of the CRUD application.')
param name string = 'crudapp'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The name of the virtual network.')
param VNET string = '${name}vnet'

@description('The subnet name where container instances will be deployed.')
param SubnetContainerInstance string = '${name}-CI-subnet'

@description('The name of the subnet for the Application Gateway.')
param SubnetAppGateway string = '${name}-appgw-subnet'

@description('The name of the Network Security Group (NSG) to apply to resources.')
param NSG string = '${name}-nsg'

@description('Container image to deploy. Format: repoName/imagename:tag for public Docker Hub, or a fully qualified URI for private registries.')
param image string = 'acrds.azurecr.io/mycrudapp:latest'

@description('Port to open on the container and the public IP address.')
param port int = 80

@description('The number of CPU cores to allocate to the container.')
param cpuCores int = 1

@description('The amount of memory (in GB) to allocate to the container.')
param memoryInGb int = 2

@description('The name of the App Gateway IP configuration.')
param IPConfig string = 'AppGatewayIP'

@description('The name of the log analytics workspace.')
param LOGS string = '${name}-logs'

@description('ACR login server URL (Azure Container Registry).')
param acrLoginServer string = 'acrds.azurecr.io'

@description('Resource group name for the Azure Container Registry (ACR).')
param resourceGroupName string = 'crudapp-rg'

@description('The name of the frontend port for the Application Gateway.')
param NameFrontendPort string = 'AppGatewayFrontPort'

@description('The container restart policy (Always, Never, OnFailure).')
@allowed([ 'Always', 'Never', 'OnFailure' ])
param restartPolicy string = 'Always'


// Create the Virtual Network (VNet) with two subnets: one for container instances and one for App Gateway
resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: VNET
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: SubnetContainerInstance // Subnet for container instances
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: nsg.id
          }
          delegations: [
            {
              name: 'aciDelegation'
              properties: {
                serviceName: 'Microsoft.ContainerInstance/containerGroups' // Allow container instances in this subnet
              }
            }
          ]
        }
      }
      {
        name: SubnetAppGateway // Subnet for Application Gateway
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}


// Create a Network Security Group to control inbound and outbound traffic
resource nsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: NSG
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'Allow-HTTP'
        properties: {
          priority: 100
          direction: 'Inbound' // Allow inbound HTTP traffic (port 80)
          access: 'Allow'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
      {
        name: 'Allow-Outbound'
        properties: {
          priority: 100
          direction: 'Outbound' // Allow all outbound traffic
          access: 'Allow'
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}


// Create a Public IP for the Application Gateway
resource appGatewayPublicIP 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: '${name}-publicIP'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}


// Extract the ACR name from the login server URL
var acrName = first(split(acrLoginServer, '.'))

// Reference an existing Azure Container Registry
resource acr 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' existing = {
  name: acrName
  scope: resourceGroup(subscription().subscriptionId, resourceGroupName)
}


// Create a Container Group for the application in Azure Container Instances
resource containerGroup 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: name
  location: location
  dependsOn: [ vnet ] // Ensure the VNet is created before the container group
  properties: {
    containers: [
      {
        name: name
        properties: {
          image: image // Container image to deploy
          ports: [
            {
              port: port
              protocol: 'TCP' // Open the specified port for TCP traffic
            }
          ]
          resources: {
            requests: {
              cpu: cpuCores
              memoryInGB: memoryInGb
            }
          }
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: restartPolicy
    ipAddress: {
      type: 'Private' // Private IP address for the container group
      ports: [
        {
          port: port
          protocol: 'TCP'
        }
      ]
    }
    subnetIds: [
      {
        id: resourceId('Microsoft.Network/virtualNetworks/subnets', VNET, SubnetContainerInstance) // Attach to the container subnet
      }
    ]
    imageRegistryCredentials: [
      {
        server: acrLoginServer // ACR registry server
        username: acr.listCredentials().username // Retrieve ACR credentials
        password: acr.listCredentials().passwords[0].value // retrieve ACR password
      }
    ]
  }
}


// Create an Application Gateway (App Gateway) to route traffic to the container instance
resource appGateway 'Microsoft.Network/applicationGateways@2023-05-01' = {
  name: '${name}-AppGateway'
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
      capacity: 2 
    }
    gatewayIPConfigurations: [
      {
        name: IPConfig
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', VNET, SubnetAppGateway) // Assign to the App Gateway subnet
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          publicIPAddress: {
            id: resourceId('Microsoft.Network/publicIPAddresses', '${name}-publicIP') // Link to the public IP
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: NameFrontendPort
        properties: {
          port: 80 // Frontend port for the App Gateway
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'backendPool'
        properties: {
          backendAddresses: [
            {
              ipAddress: containerGroup.properties.ipAddress.ip // Points to the container groups private IP
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'httpSettings'
        properties: {
          port: 80 // Backend HTTP settings
          protocol: 'Http'
          requestTimeout: 60 // Timeout for backend requests
        }
      }
    ]
    httpListeners: [
      {
        name: 'httpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', '${name}-AppGateway', 'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', '${name}-AppGateway', NameFrontendPort)
          }
          protocol: 'Http' // Protocol for the listener
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'routingRule'
        properties: {
          ruleType: 'Basic'
          priority: 100
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', '${name}-AppGateway', 'httpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', '${name}-AppGateway', 'backendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', '${name}-AppGateway', 'httpSettings')
          }
        }
      }
    ]
  }
}


// Create a Log Analytics workspace for monitoring and logging
resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: LOGS
  location: resourceGroup().location
  properties: {}
}
