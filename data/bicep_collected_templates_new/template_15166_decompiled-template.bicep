param accounts_tut_ch4_speech_spch_name string = 'tut-ch4-speech-spch'

resource accounts_tut_ch4_speech_spch_name_resource 'Microsoft.CognitiveServices/accounts@2024-06-01-preview' = {
  name: accounts_tut_ch4_speech_spch_name
  location: 'uksouth'
  tags: {
    tutorial: 'chapter4'
  }
  sku: {
    name: 'F0'
  }
  kind: 'SpeechServices'
  identity: {
    type: 'None'
  }
  properties: {
    networkAcls: {
      defaultAction: 'Allow'
      virtualNetworkRules: []
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
  }
}
