// Local deploy example.

targetScope = 'local'

extension local

param name string
param platform string = 'PowerShell'

resource sayHelloWithPowerShell 'Script' = if (platform == 'PowerShell') {
  type: 'PowerShell'
  script: replace(loadTextContent('./script.ps1'), '$INPUT_NAME', name)
}

output stdout string? = sayHelloWithPowerShell.?stdOut
