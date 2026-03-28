param logAnalyticsWorkspaceName string
param location string = resourceGroup().location

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-08-01-preview' = {
  name: logAnalyticsWorkspaceName
  location: location
}

resource accessControl 'Microsoft.OperationalInsights/workspaces/accessControl@2020-08-01-preview' = {
  parent: logAnalyticsWorkspace
  name: 'add'
  properties: {
    principalType: 'User' // Can be 'User', 'Group', or 'ServicePrincipal'
    principalId: 'YOUR_PRINCIPAL_ID' // Replace with the ID of the user, group, or service principal
    role: 'LogAnalytics Reader' // Role name, e.g., 'LogAnalytics Reader', 'LogAnalytics Contributor'
  }
}
In this simplified template:

The properties node has been removed from the logAnalyticsWorkspace resource block.
The rest of the template remains the same, including the accessControl resource block for assigning access control policies.
Remember to replace 'YOUR_PRINCIPAL_ID' with the actual ID of the user, group, or service principal to which you want to grant access.

This approach assumes that you're using default settings for the workspace properties. If you need to configure retention settings or other properties for the workspace, you can always add the properties node back with the necessary settings.





