/*
Refer to an existing resource's properties
*/

param applicationInsightsName string
param functionAppName string
param location string
param storageAccountName string

resource applicationInsights 'Microsoft.Insights/components@2018-05-01-preview' existing = {
  name: applicationInsightsName
}

resource functionApp 'Microsoft.Web/sites@2020-06-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    siteConfig: {
      appSettings: [
        // ...
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          //get Key from functionapp properties
          value: applicationInsights.properties.InstrumentationKey
        }
      ]
    }
  }
}


/*
When you need to access secure data, 
such as the credentials to use to access a resource, use the listKeys()
*/


resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: storageAccountName
}

resource functionAppV2 'Microsoft.Web/sites@2020-06-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  properties: {
    siteConfig: {
      appSettings: [
        // ...
        {
          name: 'StorageAccountKey'
          value: storageAccount.listKeys().keys[0].value
        }
      ]
    }
  }
}
