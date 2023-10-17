param sqlServerName string

@secure()
param adminLogin string

@secure()
param adminPassword string
param location string =resourceGroup().location

resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
    version: '12.0'
  }
}
