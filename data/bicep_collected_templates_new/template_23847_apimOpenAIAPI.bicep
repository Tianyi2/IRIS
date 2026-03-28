param existingApimName string
param apiName string
param apiPath string
param openAiName string
param chatCompletionPolicyFragmentName string

resource apim 'Microsoft.ApiManagement/service@2021-08-01' existing = {
  name: existingApimName
  resource policyFragment 'policyFragments@2023-03-01-preview' existing = {
    name: chatCompletionPolicyFragmentName
  }
  resource openAiApi 'apis@2023-03-01-preview' = {
    name: apiName
    properties: {
      path: apiPath
      
    }
  }
}
