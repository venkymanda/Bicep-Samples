param sqlServerName string
param adminLogin string

param subscriptionId string
param kvResourceGroup string
param kvName string

@secure()
param secureUserName string
@secure()
param securePassword string

resource kv 'Microsoft.KeyVault/vaults@2023-02-01' existing = {
  name: kvName
  scope: resourceGroup(subscriptionId, kvResourceGroup )
}

//Directly Using keyvault in template for getting secret
module sql './modules/sql.bicep' = {
  name: 'deploySQL'
  params: {
    sqlServerName: sqlServerName
    adminLogin: adminLogin
    adminPassword: kv.getSecret('vmAdminPassword')
  }
}

//Other way is to Use Parameter files as secure and get secret from them
module sqlv2 './modules/sql.bicep' = {
  name: 'deploySQLv2'
  params: {
    sqlServerName: sqlServerName
    adminLogin: secureUserName
    adminPassword: securePassword
  }
}
