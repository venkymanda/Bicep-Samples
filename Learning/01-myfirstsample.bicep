//Simple sample explaining the syntax

/*
Creates an Azure storage account with specific configurations.

:param name: The name of the storage account.
:type name: str
:param location: The Azure region where the storage account will be created.
:type location: str
:param sku: The SKU (pricing tier) of the storage account.
:type sku: dict
:param kind: The kind of storage account.
:type kind: str
:param properties: Additional properties specific to the storage account type.
:type properties: dict
:return: None
:rtype: None

*/
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'toylaunchstorage'
  location: 'westus3'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}





/*
Let's look closely at some key parts of this resource definition:
Bicep is Newline sensitive so no JSON formatting to worry about
also VS code helps in suggesting code while writing along with Best Practices
The resource keyword at the start tells Bicep that you're about to define a resource.

Next, you give the resource a symbolic name.
 In the example, the resource's symbolic name is storageAccount.
  Symbolic names are used within Bicep to refer to the resource, but they won't ever show up in Azure.

Microsoft.Storage/storageAccounts@2022-09-01 is the resource type and API version of the resource. Microsoft.Storage/storageAccounts tells Bicep that you're declaring an Azure storage account. The date 2022-09-01 is the version of the Azure Storage API that Bicep uses when it creates the resource.

You have to declare a resource name, 
which is the name the storage account will be assigned in Azure.
 You'll set a resource name using the name keyword.


 You'll then set other details of the resource, such as its location, SKU (pricing tier), and kind. 
 There are also properties you can define that are different for each resource type.
  Different API versions might introduce different properties, too. 
  In this example, we're setting the storage account's access tier to Hot.
*/
