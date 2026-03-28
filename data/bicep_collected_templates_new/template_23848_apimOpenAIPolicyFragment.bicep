param existingApimName string
param apimLoggerName string
param chatCompletionPolicyFragmentName string

resource apim 'Microsoft.ApiManagement/service@2021-08-01' existing = {
  name: existingApimName
  resource eventHubLogger 'loggers@2023-03-01-preview' existing = {
    name: apimLoggerName
  }
  resource policyFragment 'policyFragments@2023-03-01-preview' = {
    name: chatCompletionPolicyFragmentName
    properties: {
      description: 'A policy fragment to send Azure OpenAI Chat Completion usage details to event hub'
      value: '''
      <log-to-eventhub logger-id="openaieventhub">@{
        JObject openaiResponse = context.Response.Body.As<JObject>(true);
        return new JObject(
            new JProperty("SubscriptionId", context.Subscription.Id),
            new JProperty("EventTime", DateTime.UtcNow.ToString()),
            new JProperty("ServiceName", context.Deployment.ServiceName),
            new JProperty("RequestId", context.RequestId),
            new JProperty("RequestIp", context.Request.IpAddress),
            new JProperty("OperationName", context.Operation.Name),
            new JProperty("Prompt", context.Variables["openAiRequestMessages"]),
            new JProperty("Response", openaiResponse["choices"]),
            new JProperty("Tokens", openaiResponse["usage"])
        ).ToString();
      }</log-to-eventhub>
      '''
    }
  }
}
