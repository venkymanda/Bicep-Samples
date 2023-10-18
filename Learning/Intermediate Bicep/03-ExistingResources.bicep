
//Refer Paraent Existing resources

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: 'toydesigndocs'
}



//Refer Child Resources
resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: 'toy-design-vnet'

  resource managementSubnet 'subnets' existing = {
    name: 'management'
  }
}

//Output can now be referenced using child resource name
//output managementSubnetResourceId string = vnet::managementSubnet.id


//Refer Resources in different resource group

resource vnetv2 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  scope: resourceGroup('networking-rg')
  name: 'toy-design-vnet'
}


////Refer Resources in different subscription
resource vnetv3 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  scope: resourceGroup('f0750bbe-ea75-4ae5-b24d-a92ca601da2c', 'networking-rg')
  name: 'toy-design-vnet'
}


/*
Add child and extension resources to an existing resource
*/

param serverName string='server-existing'

param databaseName string='database-new'

param location string ='westus'
resource server 'Microsoft.Sql/servers@2020-11-01-preview' existing = {
  name: serverName
}

resource database 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  parent: server
  name: databaseName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

/*

you need to deploy an extension resource to an existing resource, 
*/

resource storageAccountv2 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: 'toydesigndocs'
}

resource lockResource 'Microsoft.Authorization/locks@2016-09-01' = {
  scope: storageAccountv2
  name: 'DontDelete'
  properties: {
    level: 'CanNotDelete'
    notes: 'Prevents deletion of the toy design documents storage account.'
  }
}
