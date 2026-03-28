// parameters

param location string = 'westeurope'
param name string = 'mynsg001'
param tags object {
  default: {
    environment: 'dev'
  }
}

param securityRules array {
  default: []
}

// variables

var cleanname = toLower(name)  // lowercase the name of the nsg


// resources

resource mynsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: cleanname
  tags: tags
  location: location
  properties: {
    securityRules: securityRules
  }
}

// outputs 

output nsgid string = mynsg.id  // the resourceId of the NSG