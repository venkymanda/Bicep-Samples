param sqlServerName string

@secure()
param adminLogin string

@secure()
param adminPassword string
param location string =resourceGroup().location

param storageAccountNames array = [
  'saauditus'
  'saauditeurope'
  'saauditapac'
]

resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-09-01' = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

//Using Ranges
resource storageAccountResourcesv2 'Microsoft.Storage/storageAccounts@2021-09-01' = [for i in range(1,4): {
  name: 'sa${i}'
  location: resourceGroup().location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

/*
When you use the range() function, you provide two arguments.
 The first specifies the starting value,
  and the second tells Bicep the number of values you want. 
  For example, if you use range(3,4) 
  then Bicep will return the values 3, 4, 5, and 6.
   Make sure you request the right number of values, 
   especially when you use a starting value of 0.
*/


param locations array = [
  'westeurope'
  'eastus2'
  'eastasia'
]

//Using Index value inside i+1
resource sqlServers 'Microsoft.Sql/servers@2021-11-01-preview' = [for (location, i) in locations: {
  name: 'sqlserver-${i+1}'
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }
}]


param sqlServerDetails array = [
  {
    name: 'sqlserver-we'
    location: 'westeurope'
    environmentName: 'Production'
  }
  {
    name: 'sqlserver-eus2'
    location: 'eastus2'
    environmentName: 'Development'
  }
  {
    name: 'sqlserver-eas'
    location: 'eastasia'
    environmentName: 'Production'
  }
]
//Conditional Loop
resource sqlServersv3 'Microsoft.Sql/servers@2021-11-01-preview' = [for sqlServer in sqlServerDetails: if (sqlServer.environmentName == 'Production') {
  name: sqlServer.name
  location: sqlServer.location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }
  tags: {
    environment: sqlServer.environmentName
  }
}]

//Control Parallel Execution using batchsize 
//so that loop runs sequentially in this case 1 at a time
@batchSize(1)
resource appServiceApp 'Microsoft.Web/sites@2021-03-01' = [for i in range(1,3): {
  name: 'app${i}'
  // ...
}]
