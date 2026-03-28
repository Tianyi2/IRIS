targetScope = 'managementGroup'

@description('The display name of the initiative/policy assignment.')
param initiativeDisplayName string = 'assign-nist-800-53-v-5'

@description('The policy definition ID of the built-in initiative definition for NIST SP 800-53 Rev. 5.')
param policyDefinitionId string = '/providers/Microsoft.Authorization/policySetDefinitions/179d1daa-458f-4e47-8086-2a68d0d6c38f'

resource initiativeAssignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: initiativeDisplayName
  location: 'eastus'
  properties: {
    displayName: initiativeDisplayName
    policyDefinitionId: policyDefinitionId
    parameters: {}
  }
  identity: {
    type: 'SystemAssigned'
  }
}

output initiativeAssignmentId string = initiativeAssignment.id
