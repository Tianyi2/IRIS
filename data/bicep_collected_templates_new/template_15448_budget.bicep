@description('Name for the budget')
param budgetName string 

@description('Amount for the monthly budget in USD')
param amount int

@description('Start date for the budget (ISO format, default: today)')
param startDate string 

@description('Email addresses to notify when budget threshold is reached')
param contactEmails array = []

resource budget 'Microsoft.Consumption/budgets@2021-10-01' = {
  name: budgetName
  scope: resourceGroup()
  properties: {
    category: 'Cost'
    amount: amount
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: startDate
    }
    notifications: {
      Actual_GreaterThan_80_Percent: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 80
        contactEmails: contactEmails
      }
    }
  }
}

output budgetId string = budget.id
