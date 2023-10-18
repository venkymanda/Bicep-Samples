

/*
Let's look closely at some key parts of this module definition:

The module keyword tells Bicep you're about to use another Bicep file as a module.
Just like resources, modules need a symbolic name like myModule.
 You'll use the symbolic name when you refer to the module's outputs in other parts of the template.
modules/mymodule.bicep is the path to the module file, relative to the template file. 
Remember, a module file is just a regular Bicep file.
Just like resources, the name property is mandatory.
 Azure uses the module name because it creates a separate deployment for each module within the template file. 
 Those deployments have names you can use to identify them.
You can specify any parameters of the module by using the params keyword. 
When you set the values of each parameter within the template,
 you can use expressions, template parameters, variables, properties of resources deployed within the template, and outputs from other modules. 
 Bicep will automatically understand the dependencies between the resources.

*/

param appServiceAppName string = 'toy-product-launch-1'
param environmentType string

//Expressions
param location string = resourceGroup().location

module myModule 'modules/mymodule.bicep' = {
  name: 'MyModule'
  params: {
    location: location
    environmentType:'prod'
  }
}

resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: myModule.name //Output value from myModule
  location: location
  sku: {
    name: myModule.name // just dummy assignment
  }
}




module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmentType: environmentType
  }
}

output appServiceAppHostName string = appService.outputs.appServiceAppHostName
