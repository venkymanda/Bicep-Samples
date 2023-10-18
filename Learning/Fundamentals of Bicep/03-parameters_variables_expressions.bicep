//Parameter
//param tells Bicep that you're defining a parameter. and you can deault a Value
param appServiceAppName string = 'toy-product-launch-1'

//Expressions
param location string = resourceGroup().location

//Variables
var appServicePlanName = 'toy-product-launch-plan'

//Use Parameter values in template

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: appServicePlanName //Variable
  location: location   //parameter intialized by expressions
  sku: {
    name: 'F1'
  }
}


resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceAppName //parameter
  location: location  //parameter intialized by expressions
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
