targetScope = 'subscription'

@description('Logical name of the budget.')
param name string

@description('Monthly budget amount.')
@minValue(1)
param amount int

@description('Budget category (Cost or Usage).')
@allowed([
  'Cost'
  'Usage'
])
param category string

@description('Start date of the budget in ISO 8601 format (e.g. 2025-09-01T00:00:00Z). If not provided, current UTC time is used.')
param budgetStartDate string = utcNow()

// Remove non-numeric characters: '-', ':', 'T', 'Z'
var compact = replace(replace(replace(replace(budgetStartDate, '-', ''), ':', ''), 'T', ''), 'Z', '')

// YYYYMMDD...
var yyyy = substring(compact, 0, 4)
var mm   = substring(compact, 4, 2)

// First day of that month
var startOfThisMonth = '${yyyy}-${mm}-01T00:00:00Z'

// Far future end date
var endDate = '2099-12-31T23:59:59Z'

resource budget 'Microsoft.Consumption/budgets@2021-10-01' = {
  name: name
  properties: {
    category: category
    amount: amount
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: startOfThisMonth
      endDate: endDate
    }
    notifications: {
      Actual_GreaterThan_80_Percent: {
        enabled: true
        operator: 'GreaterThan'
        threshold: 80
        contactEmails: [
          'finops@example.com'
        ]
        thresholdType: 'Actual'
      }
    }
  }
}
