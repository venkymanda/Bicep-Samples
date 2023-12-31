param sqlServerName string

@secure()
param adminLogin string

@secure()
param adminPassword string
param location string =resourceGroup().location


param deployStorageAccount bool


@allowed([
  'Development'
  'Production'
])
param environmentName string

param resourceNames array = [
  'storageAccount'
  
]




resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = if (deployStorageAccount) {
  name: 'teddybearstorage'
  location: resourceGroup().location
  kind: 'StorageV2'
  // ...
}

resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    version: '12.0'
  }
}

param auditStorageAccountName string = 'bearaudit${uniqueString(resourceGroup().id)}'

var auditingEnabled = environmentName == 'Production'
var storageAccountSkuName = 'Standard_LRS'

//Conditional Deployment for Only production

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = if (auditingEnabled) {
  name: auditStorageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
}


resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2021-11-01-preview' = if (auditingEnabled) {
  parent: sqlServer
  name: 'default'
  properties: {
    state: 'Enabled'
    storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
    storageAccountAccessKey: environmentName == 'Production' ? listKeys(auditStorageAccount.id, auditStorageAccount.apiVersion).keys[0].value : ''
  }
}

/*
Below approach can be used to deploy only a particular resource for a deployment in a bicep file

sometimes you dont want to deploy all the resources in a file or want to control it

in this we will override the parametersarray in devops when passing deployment so that 
only resource thats passed in parameter will be deployed
*/
var storageaccount_resourcename='storageAccount_usingconditonal'
var deploy_storageaccount_resource=contains(resourceNames,storageaccount_resourcename)

resource storageAccount_usingconditonal 'Microsoft.Storage/storageAccounts@2021-09-01' = if (deploy_storageaccount_resource) {
  name: 'teddybearstoragev2'
  location: resourceGroup().location
  kind: 'StorageV2'
  // ...
}
/*
You might wonder why this code is necessary, 
because auditingSettings and auditStorageAccount both have the same condition, 
and so you'll never need to deploy a SQL auditing settings resource 
without a storage account. 
Although this is true, Azure Resource Manager evaluates the property
 expressions before the conditionals on the resources. 
 So, if the Bicep code doesn't have this expression, 
 the deployment will fail with a ResourceNotFound error.
*/

//Loops
