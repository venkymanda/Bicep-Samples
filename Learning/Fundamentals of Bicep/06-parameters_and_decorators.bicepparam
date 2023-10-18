//Parameter file for bicep

using './06-parameters_and_decorators.bicep'

/*
A single Bicep file can have multiple Bicep parameters files associated with it. 
Maybe one each for prod,test and uat
However, each Bicep parameters file is intended for one particular Bicep file.
 This relationship is established using the using statement within the Bicep parameters file.
*/
param environmentName = 'dev'
//secure decorator for secret values

param solutionName = 'toyhr'
param appServicePlanInstanceCount = 1
param appServicePlanSku = {
  name: 'F1'
  tier: 'Free'
}
param location = 'westus3'

