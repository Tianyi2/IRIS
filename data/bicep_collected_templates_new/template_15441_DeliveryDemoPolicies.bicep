
param deliveryType string 
param deliveryId string

var deliveryIdAssignmentName  = take('Assign tag DeliveryID (ID ${deliveryId})',64) 
var policyID  = tenantResourceId('Microsoft.Authorization/policyDefinitions','2a0e14a6-b0a6-4fab-991a-187a4f81c498')

resource idAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: deliveryIdAssignmentName
  scope: resourceGroup()
  properties: {
      policyDefinitionId: policyID
      parameters: {
        TagName : {
          value: 'Delivery'
        }
        TagValue: {
          value: deliveryType
        }
      }
  }
}

var deliveryTypeAssignmentName  = take('Assign tag Delivery (ID ${deliveryId})',64) 

resource typeAssignment 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: deliveryTypeAssignmentName
  scope: resourceGroup()
  properties: {
      policyDefinitionId: policyID
      parameters: {
        TagName : {
          value: 'DeliveryId'
        }
        TagValue: {
          value: deliveryId
        }
      }
  }
}
