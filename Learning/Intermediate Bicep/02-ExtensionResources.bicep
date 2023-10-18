
/*
Extension resources are always attached to other Azure resources. They extend the behavior of those resources with extra functionality.

Some examples of common extension resources are:

Name	                    Resource type
Role assignments	        Microsoft.Authorization/roleAssignments
Policyassignments	        Microsoft.Authorization/policyAssignments
Locks	                    Microsoft.Authorization/locks
Diagnostic settings	      Microsoft.Insights/diagnosticSettings

we use Scope property for these extension resources
*/

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


//Here locks are used together with other resource
resource lockResource 'Microsoft.Authorization/locks@2016-09-01' = {
  scope: cosmosDBAccount
  name: 'DontDelete'
  properties: {
    level: 'CanNotDelete'
    notes: 'Prevents deletion of the toy data Cosmos DB account.'
  }
}
