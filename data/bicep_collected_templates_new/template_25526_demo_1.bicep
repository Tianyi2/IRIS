
// Concatenating parameters
param resourceNamePrefix string = 'myprefix'
param environment string = 'dev'
output parameterValue string =  '${resourceNamePrefix}-${environment}'

// Using guid
param uniqueId string = newGuid()
output  guidValue string = uniqueId

// Formated current datetime value
param currentTime string = utcNow('yyyyMMddHHmmss')
output timeValue string = currentTime

// Create unique string of 13 characters
var uniqueRGStr  = uniqueString( resourceGroup().id )
output uniqueRGStrValue string = uniqueRGStr

var uniqueSubStr  = uniqueString( subscription().subscriptionId )
output uniqueSubStrValue string = uniqueSubStr




