// =============================================================================
// Alerts Module - Action Groups + Alert Rules
// =============================================================================

@description('Azure region')
param location string

@description('Resource prefix')
param prefix string

@description('Environment name')
param environmentName string

@description('VM Resource ID')
param vmResourceId string

@description('Application Insights ID')
param appInsightsId string

@description('Resource tags')
param tags object

// =============================================================================
// VARIABLES
// =============================================================================

var actionGroupName = '${prefix}-ag-${environmentName}'

// =============================================================================
// ACTION GROUP
// =============================================================================

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: actionGroupName
  location: 'Global'
  tags: tags
  properties: {
    groupShortName: 'Jarvis${toUpper(environmentName)}'
    enabled: true
    emailReceivers: [
      {
        name: 'Jarvis Ops Team'
        emailAddress: 'jarvis-ops@company.com'
        useCommonAlertSchema: true
      }
    ]
    smsReceivers: []
    webhookReceivers: []
    azureAppPushReceivers: []
    armRoleReceivers: []
    azureFunctionReceivers: []
    logicAppReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    eventHubReceivers: []
  }
}

// =============================================================================
// ALERT RULES
// =============================================================================

// Alert: VM High CPU
resource alertHighCPU 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: '${prefix}-alert-high-cpu-${environmentName}'
  location: 'Global'
  tags: tags
  properties: {
    severity: 2
    enabled: true
    scopes: [
      vmResourceId
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'HighCPU'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'Percentage CPU'
          operator: 'GreaterThan'
          threshold: 90
          timeAggregation: 'Average'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
    description: 'Alert when VM CPU exceeds 90% for 15 minutes'
  }
}

// Alert: VM High Memory (requires Azure Monitor agent)
resource alertHighMemory 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: '${prefix}-alert-high-memory-${environmentName}'
  location: 'Global'
  tags: tags
  properties: {
    severity: 2
    enabled: true
    scopes: [
      vmResourceId
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'HighMemory'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'Available Memory Bytes'
          operator: 'LessThan'
          threshold: 1073741824 // 1 GB
          timeAggregation: 'Average'
        }
      ]
    }
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
    description: 'Alert when available memory is less than 1 GB'
  }
}

// Alert: Application Errors
resource alertAppErrors 'Microsoft.Insights/scheduledQueryRules@2023-03-15-preview' = {
  name: '${prefix}-alert-app-errors-${environmentName}'
  location: location
  tags: tags
  properties: {
    displayName: 'Jarvis - High Error Rate'
    description: 'Alert when error rate exceeds 10 exceptions in 5 minutes'
    severity: 1
    enabled: true
    evaluationFrequency: 'PT5M'
    scopes: [
      appInsightsId
    ]
    windowSize: 'PT5M'
    criteria: {
      allOf: [
        {
          query: 'exceptions | where timestamp > ago(5m) | summarize count()'
          timeAggregation: 'Count'
          operator: 'GreaterThan'
          threshold: 10
          failingPeriods: {
            numberOfEvaluationPeriods: 1
            minFailingPeriodsToAlert: 1
          }
        }
      ]
    }
    actions: {
      actionGroups: [
        actionGroup.id
      ]
    }
    autoMitigate: true
  }
}

// Alert: Slow Response Time
resource alertSlowResponse 'Microsoft.Insights/scheduledQueryRules@2023-03-15-preview' = {
  name: '${prefix}-alert-slow-response-${environmentName}'
  location: location
  tags: tags
  properties: {
    displayName: 'Jarvis - Slow Response Time'
    description: 'Alert when average response time exceeds 3 seconds'
    severity: 3
    enabled: true
    evaluationFrequency: 'PT5M'
    scopes: [
      appInsightsId
    ]
    windowSize: 'PT10M'
    criteria: {
      allOf: [
        {
          query: 'requests | where timestamp > ago(10m) | summarize avg(duration)'
          timeAggregation: 'Average'
          operator: 'GreaterThan'
          threshold: 3000
          failingPeriods: {
            numberOfEvaluationPeriods: 2
            minFailingPeriodsToAlert: 2
          }
        }
      ]
    }
    actions: {
      actionGroups: [
        actionGroup.id
      ]
    }
    autoMitigate: true
  }
}

// Alert: Bot Offline (No Heartbeat)
resource alertBotOffline 'Microsoft.Insights/scheduledQueryRules@2023-03-15-preview' = {
  name: '${prefix}-alert-bot-offline-${environmentName}'
  location: location
  tags: tags
  properties: {
    displayName: 'Jarvis - Bot Offline'
    description: 'Alert when no heartbeat detected for 10 minutes'
    severity: 0
    enabled: true
    evaluationFrequency: 'PT5M'
    scopes: [
      appInsightsId
    ]
    windowSize: 'PT10M'
    criteria: {
      allOf: [
        {
          query: 'traces | where message contains "healthz" | where timestamp > ago(10m) | summarize count()'
          timeAggregation: 'Count'
          operator: 'LessThanOrEqual'
          threshold: 0
          failingPeriods: {
            numberOfEvaluationPeriods: 1
            minFailingPeriodsToAlert: 1
          }
        }
      ]
    }
    actions: {
      actionGroups: [
        actionGroup.id
      ]
    }
    autoMitigate: true
  }
}

// =============================================================================
// OUTPUTS
// =============================================================================

@description('Action Group ID')
output actionGroupId string = actionGroup.id

@description('Action Group Name')
output actionGroupName string = actionGroup.name
