targetScope = 'subscription'

@description('Policy assignment name. Should be unique within the subscription.')
param assignmentName string

@description('Location for the policy assignment (subscription-level resource).')
param assignmentLocation string = 'westeurope'

@description('Required tag name.')
param requiredTagName string = 'Env'

@description('Required tag value.')
param requiredTagValue string = 'NonProd'

// Built-in policy definition: "Require a tag and its value on resources"
var policyDefinitionId = '/providers/Microsoft.Authorization/policyDefinitions/1e30110a-5ceb-460c-a204-c1c3969c6d62'

resource assignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: assignmentName
  location: assignmentLocation
  properties: {
    displayName: 'Require tag and its value (built-in)'
    description: 'Ensures a specific tag and value are present on all resources.'
    policyDefinitionId: policyDefinitionId
    parameters: {
      tagName: {
        value: requiredTagName
      }
      tagValue: {
        value: requiredTagValue
      }
    }
    enforcementMode: 'Default'
  }
}
