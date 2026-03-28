targetScope = 'resourceGroup'

@description('The scope ID (Resource ID) where the role assignment applies (e.g., Project ID).')
param scopeId string

@description('The built-in or custom Role Definition ID (GUID).')
param roleDefinitionId string

@description('The Entra ID Object ID of the user, group, or service principal.')
param principalId string

@description('Principal Type (Group is the common choice for Dev Box access).')
@allowed([ 'User', 'Group', 'ServicePrincipal' ])
param principalType string = 'Group'

var roleAssignmentName = guid(scopeId, principalId, roleDefinitionId)

resource roleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: resourceId(scopeId)
  name: roleAssignmentName
  properties: {
    roleDefinitionId: roleDefinitionId
    principalId: principalId
    principalType: principalType
  }
}

output roleAssignmentId string = roleAssignment.id
