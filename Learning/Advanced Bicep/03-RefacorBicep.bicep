/*

The refactor phase consists of eight steps, which you do in any order:

Review resource API versions.
Review the linter suggestions in your new Bicep file.
Revise parameters, variables, and symbolic names.
Simplify expressions.
Review child and extension resources.
Modularize.
Add comments.
Follow Bicep best practices.

*/



/*
  This Bicep file was developed by the web team.
  It deploys the resources we need for our toy company's website.
*/

// Parameters
@description('Location for all resources.')
param location string = resourceGroup().location

@allowed([
  'prod' // Production environment
  'dev' // Development environment
  'test' // Test environment
])
@description('The list of allowed environment names.')
param environment string = 'prod'

@allowed([
  'P1v3'
  'P2v3'
  'P3v3'
])
@description('The list of allowed App Service plan SKUs.')
param appServicePlanSku string = 'P1v3'

@minValue(1)
@maxValue(10)
@description('The number of allowed App Service plan instances.')
param appServicePlanInstanceCount int = 1

// Variables
@description('The name of the App Service plan.')
var appServicePlanName = 'plan-${environment}-001'

// Resource - App Service plan
@description('The App Service plan resource name.')
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku // Specifies the SKU of the App Service plan.
    capacity: appServicePlanInstanceCount
  }
  kind: 'app' // Specifies a Windows App Service plan.
}

// Outputs
@description('The resource ID of the App Service plan.')
output appServicePlanId string = appServicePlan.id // Resource ID of the App Service plan.
