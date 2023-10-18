param cosmosDBAccountName string = 'toyrnd-${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location
param cosmosDBDatabaseThroughput int = 400
var cosmosDBDatabaseName = 'FlightTests'

var cosmosDBContainerName = 'FlightTests'
var cosmosDBContainerPartitionKey = '/droneId'

resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
  name: cosmosDBAccountName
  location: location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: location
      }
    ]
  }
}

//Parent Property
resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2020-04-01' = {
  parent: cosmosDBAccount
  name: cosmosDBDatabaseName
  properties: {
    resource: {
      id: cosmosDBDatabaseName
    }
    options: {
      throughput: cosmosDBDatabaseThroughput
    }
  }

//Nested Resource
resource container 'containers' = {
  name: cosmosDBContainerName
  properties: {
    resource: {
      id: cosmosDBContainerName
      partitionKey: {
        kind: 'Hash'
        paths: [
          cosmosDBContainerPartitionKey
        ]
      }
    }
    options: {}
  }
}
}
