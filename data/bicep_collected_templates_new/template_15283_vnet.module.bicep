// *********************************************************
//
// Type: Module
// Author: Lukas Rottach
// Page: https://github.com/lrottach
// Description: Azure Bicep user-defined data types - Virtual Network
//
// *********************************************************

// Target scope
targetScope = 'resourceGroup'

// Parameters
// ******************************

// Deployment parameter
param deploymentLocation string

// Virtual Network Parameter
param vnetName string
param vnetRange string
param subnetRange string

// Resources
// ******************************

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: deploymentLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetRange
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: subnetRange
        }
      }
    ]
  }
}

// Outputs
// ******************************
output vnetId string = vnet.id
output defaultSubnetId string = vnet.properties.subnets[0].id
