param location string = resourceGroup().location

param aiFoundry_name string = 'aif-mslearn-ai-agents-eastus2-001'

param modelName string = 'gpt-4o'

param aiFoundary_project_name string = 'proj-mslearn-ai-agents-eastus2-001'

resource aiFoundry 'Microsoft.CognitiveServices/accounts@2025-06-01' = {
  name: aiFoundry_name
  location: location
  sku: {
    name: 'S0'
  }
  kind: 'AIServices'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    apiProperties: {}
    customSubDomainName: aiFoundry_name
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    allowProjectManagement: true
    defaultProject: aiFoundary_project_name
    associatedProjects: [
      aiFoundary_project_name
    ]
    publicNetworkAccess: 'Enabled'
  }
}

// https://learn.microsoft.com/azure/templates/microsoft.cognitiveservices/2025-06-01/accounts/projects?pivots=deployment-language-bicep&WT.mc_id=DOP-MVP-5001655
resource aiFoundry_project 'Microsoft.CognitiveServices/accounts/projects@2025-06-01' = {
  parent: aiFoundry
  name: aiFoundary_project_name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    description: 'Default project created with the resource'
    displayName: 'proj-mslearn-ai-agents-eastus2-001'
  }
}

// https://learn.microsoft.com/azure/templates/microsoft.cognitiveservices/2025-06-01/accounts/deployments?pivots=deployment-language-bicep&WT.mc_id=DOP-MVP-5001655
resource modelDeployment 'Microsoft.CognitiveServices/accounts/deployments@2025-06-01' = {
  parent: aiFoundry
  name: modelName
  sku: {
    name: 'GlobalStandard'
    capacity: 50
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: modelName
      version: '2024-11-20'
    }
    raiPolicyName: 'Microsoft.DefaultV2'
  }
}

output aiFoundary_endpoint string = aiFoundry.properties.endpoint
