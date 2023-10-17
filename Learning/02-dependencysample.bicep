// Sample of Bicep showing Depenency btween appserviceplan and appservice

/// <summary>
/// Defines an Azure App Service Plan resource in Bicep.
/// The App Service Plan represents the underlying infrastructure that hosts the web app.
/// </summary>
/// <example>
/// <code>
resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: 'toy-product-launch-plan'
  location: 'westus3'
  sku: {
    name: 'F1'
  }
}

/// </code>
/// </example>
/// <param name="name">The name of the App Service Plan.</param>
/// <param name="location">The Azure region where the App Service Plan will be deployed.</param>
/// <param name="sku">The SKU (pricing tier) of the App Service Plan. It contains the `name` property which specifies the tier.</param>
/// <returns>None</returns>






/// <summary>
/// Defines an Azure App Service resource in Bicep.
/// </summary>
/// <remarks>
/// The resource represents a web app and is named 'toy-product-launch-1'. It is deployed in the 'westus3' region.
/// The properties of the resource include the serverFarmId, which is set to the id of the appServicePlan resource, and the httpsOnly flag, which is set to true.
/// </remarks>
/// <example>
/// <code>
resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'toy-product-launch-1'
  location: 'westus3'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
/// </code>
/// </example>

/*
By declaring the app resource with a property that references the symbolic name of the plan, 
Azure understands the implicit dependency between the App Service app and the plan. 
When it deploys the resources, Azure will ensure it fully deploys the plan before it starts to deploy the app.
*/
